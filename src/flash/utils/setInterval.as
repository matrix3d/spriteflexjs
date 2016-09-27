package flash.utils
{
	import flash.utils.__js.setIntervalJS;
	public function setInterval(closure:Function, delay:Number):int
	{
		return setIntervalJS(closure,delay);
	}
}
