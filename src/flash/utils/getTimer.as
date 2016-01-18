package flash.utils
{
	public function getTimer():int
	{
		return (new Date()).getTime() - SpriteFlexjs.startTime;
	}
}
