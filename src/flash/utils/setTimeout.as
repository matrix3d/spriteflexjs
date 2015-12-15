package flash.utils
{
	public function setTimeout(closure:Function, delay:Number, ... arguments):uint
	{
		return new SetIntervalTimer(closure, delay, false, arguments).id;
	}
}
