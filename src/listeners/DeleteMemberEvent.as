package listeners
{
	import flash.events.Event;
	
	public class DeleteMemberEvent extends Event
	{
		public var gm:GroupMember;
		
		public function DeleteMemberEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}