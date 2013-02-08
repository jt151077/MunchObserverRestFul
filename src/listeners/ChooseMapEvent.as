package listeners
{
	import flash.events.Event;
	
	public class ChooseMapEvent extends Event
	{
		public var map:Number = -1;
		
		public function ChooseMapEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}