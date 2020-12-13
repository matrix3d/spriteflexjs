
package 
{
	import com.bit101.components.*;
	import flash.__native.WebGLRenderer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	/**
	 * MinimalComps を使って GUI 部品を表示するサンプル
	 * 
	 * MinimalComps は、クリエイティブコモンズの
	 * Attribution-Share Alike 3.0
	 * というライセンスで公開されていますので、
	 * 確認してから使用してください。
	 * http://creativecommons.org/licenses/by-sa/3.0/
	 * 
	 * ・GUI 部品デザイナ
	 * (視覚的に部品を配置してソースコードを出力できます)
	 * http://www.bit-101.com/MinimalDesigner/
	 * 
	 * ・作者の Keith Peters さんのページ
	 * http://www.bit-101.com/blog/?p=1126
	 * 
	 * @author Hikipuro
	 */
	public class TestMinimalComps extends Sprite 
	{
		private var checkBox:CheckBox;
		private var hSlider:HSlider;
		private var labelHSlider:Label;
		private var inputText:InputText;
		private var progressBar:ProgressBar;
		
		/**
		 * コンストラクタ
		 */
		public function TestMinimalComps():void 
		{
			
			
			SpriteFlexjs.wmode = "gpu batch";
			SpriteFlexjs.renderer = new WebGLRenderer;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * 初期化イベント
		 * @param	e
		 */
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// 言語の設定
			// 元に戻す時はコメントアウトしてください。
			//Locale.language = "ja";
			
			// パネルの準備
			//var panel:Panel = new Panel(this, 15, 20);
			//panel.setSize(stage.stageWidth - 30, stage.stageHeight - 40);
			var panel = this;
			
			// チェックボックスの準備
			checkBox = new CheckBox(this, 80, 20, "", onCheckBoxClick);
			checkBox.label = "チェックボックス";
			
			stage.addEventListener(flash.events.MouseEvent.CLICK, function():void{
				trace(checkBox.x);
				trace(checkBox.getChildAt(0).x);
				for (var i:int = 0; i < checkBox.numChildren;i++ ){
					trace(checkBox.getChildAt(i));
					trace(checkBox.getChildAt(i).x);
				}
			});
			//s.x = 20;
			//s.y = 10;
			
			
			
			
			// ラベルの準備
			var label:Label = new Label(panel, 20, 40);
			label.text = "これはラベルです";

			// ボタンの準備
			var pushbutton:PushButton = new PushButton(panel, 20, 60, "", onPushButtonClick);
			pushbutton.label = "押しボタン";
			pushbutton.width = 100;

			// 横方向スライダーの準備
			hSlider = new HSlider(panel, 20, 90);
			hSlider.addEventListener(Event.CHANGE, onHSliderChange);
			labelHSlider = new Label(panel, 60, 100);
			labelHSlider.text = "0.0";

			// 縦方向スライダーの準備
			var vSlider:VSlider = new VSlider(panel, 130, 20);

			// テキスト入力ボックスの準備
			inputText = new InputText(panel, 20, 130);
			inputText.width = 120;
			inputText.text = "テキスト入力";     

			// プログレスバーの準備
			progressBar = new ProgressBar(panel, 160, 130);
			progressBar.maximum = 100;

			// ラジオボタンの準備
			var radio1:RadioButton = new RadioButton(panel, 160, 20, "", false, onRadioButtonClick);
			radio1.label = "ラジオボタン 1";

			var radio2:RadioButton = new RadioButton(panel, 160, 40, "", false, onRadioButtonClick);
			radio2.label = "ラジオボタン 2";

			var radio3:RadioButton = new RadioButton(panel, 160, 60, "", false, onRadioButtonClick);
			radio3.label = "ラジオボタン 3";

			// 色選択ボックスの準備
			var colorchooser:ColorChooser = new ColorChooser(panel, 160, 90);
			colorchooser.value = 0xff0000;
			
			// 作者様の情報
			var labelAuther:Label = new Label(panel, 20, 160);
			labelAuther.text = "Keith Peters さんが作られた MinimalComps というライブラリを\n使用して GUI 部品を表示しています。";
			
			// フレーム開始イベントの登録
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * フレーム開始イベント
		 * @param	e
		 */
		private function onEnterFrame(e:Event):void 
		{
			// プログレスバーの更新
			progressBar.value++;
			if (progressBar.value == progressBar.maximum) {
				progressBar.value = 0;
			}
		}
		
		/**
		 * チェックボックスがクリックされた時のイベント
		 * @param	e
		 */
		private function onCheckBoxClick(e:MouseEvent):void 
		{
			if (checkBox.selected == false) {
				//inputText.text = "チェックが消えました";
			} else {
				//inputText.text = "チェックが付きました";
			}
		}
		
		/**
		 * ラジオボタンがクリックされた時のイベント
		 * @param	e
		 */
		private function onRadioButtonClick(e:MouseEvent):void 
		{
			var radio:RadioButton = e.currentTarget as RadioButton;
			switch (radio.label) {
				case "ラジオボタン 1":
					inputText.text = "ラジオボタン 1 が選択されました";
					break;
				case "ラジオボタン 2":
					inputText.text = "ラジオボタン 2 が選択されました";
					break;
				case "ラジオボタン 3":
					inputText.text = "ラジオボタン 3 が選択されました";
					break;
			}
		}
		
		/**
		 * ボタンがクリックされた時のイベント
		 * @param	e
		 */
		private function onPushButtonClick(e:MouseEvent):void 
		{
			inputText.text = "ボタンがクリックされました";
		}
		
		/**
		 * 横方向のスライダーが変更された時のイベント
		 * @param	e
		 */
		private function onHSliderChange(e:Event):void 
		{
			labelHSlider.text = hSlider.value.toFixed(1);
		}
	}
	
}		