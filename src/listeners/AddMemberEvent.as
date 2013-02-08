package listeners
{
	import flash.events.Event;
	
	public class AddMemberEvent extends Event
	{
		public var gm:GroupMember;
		
		public function AddMemberEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}