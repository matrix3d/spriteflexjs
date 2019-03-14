package fairygui.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import fairygui.GObject;
	import fairygui.display.UIDisplayObject;

	public class ToolSet
	{
		public static var GRAY_FILTERS:Array = [new ColorMatrixFilter(
			[0.299, 0.587, 0.114, 0, 0,
				0.299, 0.587, 0.114, 0, 0,
				0.299, 0.587, 0.114, 0, 0,
				0, 0, 0, 1, 0])];
		
		public static const RAD_TO_DEG:Number = 180/Math.PI;
		public static const DEG_TO_RAD:Number = Math.PI/180;
		
		public function ToolSet()
		{
		}
		
		public static function startsWith(source:String, str:String, ignoreCase:Boolean=false):Boolean {
			if(!source)
				return false;
			else if(source.length<str.length)
				return false;
			else {
				source = source.substring(0, str.length);
				if(!ignoreCase)
					return source==str;
				else
					return source.toLowerCase()==str.toLowerCase();
			}
		}
		
		public static function endsWith(source:String, str:String, ignoreCase:Boolean=false):Boolean {
			if(!source)
				return false;
			else if(source.length<str.length)
				return false;
			else {
				source = source.substring(source.length-str.length);
				if(!ignoreCase)
					return source==str;
				else
					return source.toLowerCase()==str.toLowerCase();
			}
		}
		
		public static function trim(targetString:String):String{
			return trimLeft(trimRight(targetString));
		}
		
		public static function trimLeft(targetString:String):String{
			var tempChar:String = "";
			for(var i:int=0; i<targetString.length; i++){
				tempChar = targetString.charAt(i);
				if(tempChar != " " && tempChar != "\n" && tempChar != "\r"){
					break;
				}
			}
			return targetString.substr(i);
		}
		
		public static function trimRight(targetString:String):String{
			var tempChar:String = "";
			for(var i:int=targetString.length-1; i>=0; i--){
				tempChar = targetString.charAt(i);
				if(tempChar != " " && tempChar != "\n" && tempChar != "\r"){
					break;
				}
			}
			return targetString.substring(0 , i+1);
		}
		
		
		public static function convertToHtmlColor(argb:uint, hasAlpha:Boolean=false):String {
			var alpha:String;
			if(hasAlpha)
				alpha = (argb >> 24 & 0xFF).toString(16);
			else
				alpha = "";
			var red:String = (argb >> 16 & 0xFF).toString(16);
			var green:String = (argb >> 8 & 0xFF).toString(16);
			var blue:String = (argb & 0xFF).toString(16);
			if(alpha.length==1)
				alpha = "0" + alpha;
			if(red.length==1)
				red = "0" + red;
			if(green.length==1)
				green = "0" + green;
			if(blue.length==1)
				blue = "0" + blue;
			return "#" + alpha + red +  green + blue;
		}
		
		public static function convertFromHtmlColor(str:String, hasAlpha:Boolean=false):uint {
			if(str.length<1)
				return 0;
			
			if(str.charAt(0)=="#")
				str = str.substr(1);
			
			if(str.length==8)
				return (parseInt(str.substr(0, 2), 16)<<24)+parseInt(str.substr(2), 16);
			else if(hasAlpha)
				return 0xFF000000+parseInt(str, 16);
			else
				return parseInt(str, 16);
		}
		
		public static function encodeHTML(str:String):String {
			if(!str)
				return "";
			else
				return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&apos;");
		}
		
		public static var defaultUBBParser:UBBParser = new UBBParser();
		public static function parseUBB(text:String):String {
			return defaultUBBParser.parse(text);
		}
		
		private static var tileIndice:Array = [ -1, 0, -1, 2, 4, 3, -1, 1, -1 ];
		public static function scaleBitmapWith9Grid(source:BitmapData, scale9Grid:Rectangle,
													wantWidth:int, wantHeight:int, smoothing:Boolean=false, tileGridIndice:int=0):BitmapData {
			if(wantWidth==0 || wantHeight==0)
			{
				return new BitmapData(1,1,source.transparent, 0x00000000);
			}
			
			var bmpData : BitmapData = new BitmapData(wantWidth, wantHeight, source.transparent, 0x00000000);
			
			var rows:Array = [0, scale9Grid.top, scale9Grid.bottom, source.height];
			var cols:Array = [0, scale9Grid.left, scale9Grid.right, source.width];
			
			var dRows:Array;
			var dCols:Array;
			if (wantHeight >= (source.height - scale9Grid.height))
				dRows = [0, scale9Grid.top, wantHeight - (source.height - scale9Grid.bottom), wantHeight];
			else
			{
				var tmp:Number = scale9Grid.top / (source.height - scale9Grid.bottom);
				tmp = wantHeight * tmp / (1 + tmp);
				dRows = [ 0, tmp, tmp, wantHeight];
			}
			
			if (wantWidth >= (source.width - scale9Grid.width))
				dCols = [0, scale9Grid.left, wantWidth - (source.width - scale9Grid.right), wantWidth];
			else
			{
				tmp = scale9Grid.left / (source.width - scale9Grid.right);
				tmp = wantWidth * tmp / (1 + tmp);
				dCols = [ 0, tmp, tmp, wantWidth];
			}			
			
			var origin : Rectangle;
			var draw : Rectangle;
			var mat:Matrix = new Matrix();
			
			for (var cx : int = 0;cx < 3; cx++) {
				for (var cy : int = 0 ;cy < 3; cy++) {
					origin = new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
					draw = new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
					
					var i:int = tileIndice[cy*3+cx];
					if(i!=-1 && (tileGridIndice & (1<<i))!=0)
					{
						var tmp2:BitmapData = tileBitmap(source, origin, draw.width, draw.height);
						bmpData.copyPixels(tmp2, tmp2.rect, draw.topLeft);
						tmp2.dispose();
					}
					else
					{
						mat.identity();
						mat.a = draw.width / origin.width;
						mat.d = draw.height / origin.height;
						mat.tx = draw.x - origin.x * mat.a;
						mat.ty = draw.y - origin.y * mat.d;
						bmpData.draw(source, mat, null, null, draw, smoothing);
					}
				}
			}
			return bmpData;
		}
		
		public static function tileBitmap(source:BitmapData, sourceRect:Rectangle,
										  wantWidth:int, wantHeight:int):BitmapData
		{
			if(wantWidth==0 || wantHeight==0)
			{
				return new BitmapData(1,1,source.transparent, 0x00000000);
			}
			
			var result:BitmapData = new BitmapData(wantWidth, wantHeight, source.transparent, 0);
			var hc:int = Math.ceil(wantWidth/sourceRect.width);
			var vc:int = Math.ceil(wantHeight/sourceRect.height);
			var pt:Point = new Point();
			for(var i:int=0;i<hc;i++)
			{
				for(var j:int=0;j<vc;j++)
				{
					pt.x = i*sourceRect.width;
					pt.y = j*sourceRect.height;
					result.copyPixels(source, sourceRect, pt);
				}
			}
			
			return result;
		}
		
		public static function displayObjectToGObject(obj:DisplayObject):GObject
		{
			while (obj != null && !(obj is Stage))
			{
				if (obj is UIDisplayObject)
					return UIDisplayObject(obj).owner;
				
				obj = obj.parent;
			}
			return null;
		}
		
		public static function clamp(value:Number, min:Number, max:Number):Number
		{
			if(value<min)
				value = min;
			else if(value>max)
				value = max;
			return value;
		}
		
		public static function clamp01(value:Number):Number
		{
			if(value>1)
				value = 1;
			else if(value<0)
				value = 0;
			return value;
		}
	}
}