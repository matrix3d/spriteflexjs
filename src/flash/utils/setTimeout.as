package flash.utils
{
	public function setTimeout(closure:Function, delay:Number, ... args):uint
	{
		return new SetIntervalTimer(closure, delay, false, args).id;
	}
}
