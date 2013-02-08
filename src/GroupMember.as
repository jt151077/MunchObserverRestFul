package
{
	import comps.Blob;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class GroupMember
	{
		private var _genre:String;
		private var _age:String;
		private var _origin:String;
		private var _originText:String;
		private var _color:Number;
		private var spotsCounter:Number = 0;
		private var _spots:Dictionary = new Dictionary();
		private var initSpot:Blob;
		private var lastBlob:Blob;
		private var _artefacts:ArrayCollection = new ArrayCollection();
		private var lastSpotUid:String;
		
		public function GroupMember() {
		}

		public function get genre():String
		{
			return _genre;
		}

		public function set genre(value:String):void
		{
			_genre = value;
		}

		public function get age():String
		{
			return _age;
		}

		public function set age(value:String):void
		{
			_age = value;
		}

		public function get origin():String
		{
			return _origin;
		}

		public function set origin(value:String):void
		{
			_origin = value;
		}

		public function get color():Number
		{
			return _color;
		}

		public function set color(value:Number):void
		{
			_color = value;
			(spots[lastSpotUid] as Blob).colorCode = color.toString();
		}

		public function get spots():Dictionary
		{
			return _spots;
		}

		public function set spots(value:Dictionary):void
		{
			_spots = value;
		}
		
		public function addNewMemberSpot(xx:Number, yy:Number, uid:String):void {
			lastSpotUid = uid;
			initSpot = new Blob();
			initSpot.colorCode = color.toString();
			initSpot.x = xx;
			initSpot.y = yy;
			initSpot.createdAt = new Date();
			initSpot.counter = spotsCounter;
			spots[lastSpotUid] = initSpot;
			spotsCounter++;
		}
		
		public function retrieveMemberSelectedActions():ArrayCollection {
			return spots[lastSpotUid].selectedActions;
		}
		
		public function retrieveGroupEventNotes():String {
			return spots[lastSpotUid].eventNotes;
		}
		
		public function updateMemberSelectedActions(arr:ArrayCollection):void {
			lastBlob = spots[lastSpotUid];
			lastBlob.selectedActions = arr;
			spots[lastSpotUid] = lastBlob;
		}
		
		public function updateEventNotes(note:String):void {
			lastBlob = spots[lastSpotUid];
			lastBlob.eventNotes = note;
			spots[lastSpotUid] = lastBlob;
		}

		public function get artefacts():ArrayCollection
		{
			return _artefacts;
		}

		public function set artefacts(value:ArrayCollection):void
		{
			_artefacts = value;
		}

		public function get originText():String
		{
			return _originText;
		}

		public function set originText(value:String):void
		{
			_originText = value;
		}
	
		public function deleteLastSpot(uid:String):void {
			if(uid == null) {
				if(spots[lastSpotUid] != null) {
					spotsCounter--;
				}
				delete spots[lastSpotUid];
				
				var spotUids:Array = extractKeysFrom(spots);
				spotUids.sort(Array.NUMERIC);
				lastSpotUid = spotUids[spotUids.length-1];
				
			}
			else {
				if(spots[uid] != null) {
					spotsCounter--;
				}
				delete spots[uid];
			}
		}
		
		private function extractKeysFrom(source : Dictionary):Array {
			var output : Array = [];
			for (var prop : * in source) {
				output.push(prop);
			}
			return output;
		}

	}
}