package flash.display.cmds {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
public	class SetBitmapAttribCmd extends SetAttribCmd {
	public var bmd:BitmapData;
	public var sprite:Object;
	public var worldMatrix:Matrix;
	public var matrix:Matrix;
	public var repeat:Boolean;
    public function SetBitmapAttribCmd(target:*,name: String, bmd: BitmapData,matrix:Matrix,repeat:Boolean,sprite:Object) {
		this.bmd=bmd;
		this.sprite=sprite;
		this.matrix=matrix;
		this.worldMatrix=new Matrix();
        this.repeat=repeat;
		super(target,name,null);
    }
    override public function update():void {
        this.value = repeat;
		super.update();
    }
}
}	