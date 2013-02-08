package
{
	import comps.Blob;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class VisitorGroup {
		
		private var _members:ArrayCollection = new ArrayCollection();
		private var _spots:Dictionary = new Dictionary();
		private var spotsCounter:Number = 0;
		private var _note:String = "";
		private var _startDate:Date;
		private var _finishDate:Date;
		private var _selectedMember:Number = -1;
		private var initSpot:Blob;
		private var lastBlob:Blob;
		private var targetMember:GroupMember;
		private var lastSpotUid:String;
		private var _firstSpotUid:String;
		private var mapObj:Object;
		private var _startExitDico:Dictionary;
		
		public function VisitorGroup(mapObj:Object, dico:Dictionary) {
			startExitDico = dico;
			this.mapObj = mapObj;
			firstSpotUid = addNewGroupSpot(startExitDico[mapObj.map][4], startExitDico[mapObj.map][5]);
		}
		
		public function get members():ArrayCollection
		{
			return _members;
		}
		
		public function set members(value:ArrayCollection):void
		{
			_members = value;
		}
		
		public function get note():String
		{
			return _note;
		}
		
		public function set note(value:String):void
		{
			_note = value;
		}
		
		public function get startDate():Date
		{
			return _startDate;
		}
		
		public function set startDate(value:Date):void
		{
			_startDate = value;
		}
		
		public function get spots():Dictionary
		{
			return _spots;
		}
		
		public function set spots(value:Dictionary):void
		{
			_spots = value;
		}
		
		public function get selectedMember():Number
		{
			return _selectedMember;
		}
		
		public function set selectedMember(value:Number):void
		{
			_selectedMember = value;
		}
		
		public function addNewGroupSpot(xx:Number, yy:Number):String {
			initSpot = new Blob();
			initSpot.colorCode = MunchObserver.COLOR_GROUP.toString();
			initSpot.x = xx;
			initSpot.y = yy;
			initSpot.createdAt = new Date();
			initSpot.counter = spotsCounter;
			lastSpotUid = new Date().time.toString();
			spots[lastSpotUid] = initSpot;
			spotsCounter++;
			
			//we add the blob for all users
			for each (var mem:GroupMember in members) {
				mem.addNewMemberSpot(xx, yy, lastSpotUid);
			}
			
			return lastSpotUid;
		}
		
		public function updateGroupSelectedActions(arr:ArrayCollection):void {
			lastBlob = spots[lastSpotUid];
			lastBlob.selectedActions = arr;
			spots[lastSpotUid] = lastBlob;
		}
		
		public function updateEventNotes(note:String):void {
			lastBlob = spots[lastSpotUid];
			lastBlob.eventNotes = note;
			spots[lastSpotUid] = lastBlob;
		}
		
		public function retrieveGroupSelectedActions():ArrayCollection {
			lastBlob = getLastBlob();
			return lastBlob.selectedActions;
		}
		
		public function retrieveGroupEventNotes():String {
			lastBlob = getLastBlob();
			return lastBlob.eventNotes;
		}
		
		public function addSpotToMember(xx:Number, yy:Number, uid:String):void {
			targetMember = members.getItemAt(selectedMember) as GroupMember;
			if(targetMember.spots.length == 0) {
				targetMember.addNewMemberSpot(startExitDico[mapObj.map][4], startExitDico[mapObj.map][5], uid);
			}
			targetMember.addNewMemberSpot(xx, yy, uid);
		}
		
		public function getLastBlob():Blob {
			return spots[lastSpotUid];
		}

		public function get finishDate():Date
		{
			return _finishDate;
		}

		public function set finishDate(value:Date):void
		{
			_finishDate = value;
		}
		
		public function deleteLastEvent():void {
			if(lastSpotUid != firstSpotUid) {
				delete spots[lastSpotUid];
				spotsCounter--;
				for each (var mem:GroupMember in members) {
					mem.deleteLastSpot(lastSpotUid);
				}
				
				var spotUids:Array = extractKeysFrom(spots);
				spotUids.sort(Array.NUMERIC);
				lastSpotUid = spotUids[spotUids.length-1];
			}
		}
		
		private function extractKeysFrom(source : Dictionary):Array {
			var output : Array = [];
			for (var prop : * in source) {
				output.push(prop);
			}
			return output;
		}

		public function get firstSpotUid():String
		{
			return _firstSpotUid;
		}

		public function set firstSpotUid(value:String):void
		{
			_firstSpotUid = value;
		}

		public function get startExitDico():Dictionary
		{
			return _startExitDico;
		}

		public function set startExitDico(value:Dictionary):void
		{
			_startExitDico = value;
		}


	}
}