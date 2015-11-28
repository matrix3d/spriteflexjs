package flash.display.cmds{
public class SetColorAttribCmd extends SetAttribCmd {
	public var color:Number;
	public var alpha:Number;
	public var sprite:Object;
    public function SetColorAttribCmd(target:*,name: String, color: uint,alpha:Number,sprite:Object) {
		this.color=color;
		this.alpha=alpha;
		this.sprite=sprite;
        super(target,name,null);
    }
    override public function update():void {
        this.value="rgba("+(this.color>>16&0xff)+","+(this.color>>8&0xff)+","+(this.color&0xff)+","+this.alpha*this.sprite.alpha+")";
		super.update();
    }
}
}