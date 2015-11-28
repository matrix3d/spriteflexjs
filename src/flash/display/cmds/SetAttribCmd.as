package flash.display.cmds {
public class SetAttribCmd extends Cmd {
	public var target:*;
    public var name: String;
    public var value: *
    public function SetAttribCmd(target:*,name: String, value: *) {
        super(null,null);
		this.target=target;
        this.name = name;
        this.value = value;
		this.update();
    }
	override public function update():void {
        this.target[this.name] = this.value;
    }
}
}	