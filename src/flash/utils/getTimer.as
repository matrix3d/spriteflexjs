package flash.utils
{
	public function getTimer():int
	{
		return Date.now() - SpriteFlexjs.startTime;
	}
}
