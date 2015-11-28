package flash.display.cmds {

import flash.display.Graphics;
public class Cmd {
	private static var _ctx:CanvasRenderingContext2D;
    public var cmd: Function;
    public var args: Array;
    public function Cmd(cmd: Function, args: Array) {
        this.cmd = cmd;
        this.args= args;
    }
    public function update():void {
        this.cmd.apply(ctx, this.args);
    }
	
	static public function get ctx():CanvasRenderingContext2D 
	{
		if (_ctx==null) {
			var g:Graphics = new Graphics;
			_ctx = g.getCanvas();
		}
		return _ctx;
	}
}
}