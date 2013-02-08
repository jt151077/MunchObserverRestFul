package listeners
{
	import flash.events.Event;
	
	import spark.components.Button;
	
	public class DeleteMuseumEvent extends Event
	{
		public var museumEvent:Button;
		
		public function DeleteMuseumEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}