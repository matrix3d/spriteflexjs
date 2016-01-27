package flash.net
{
	public function navigateToURL(request:URLRequest, win:String=null):void
	{
		window.open(request.url, win);
	}
}
