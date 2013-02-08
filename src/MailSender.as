package
{
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import org.bytearray.smtp.mailer.SMTPMailer;

	public class MailSender
	{
		private var _arrToSend:Array;
		private var sendInterval:Number;
		private var _sending:Boolean;
		
		public function MailSender(arr:Array):void {
			arrToSend = arr;
			sending = true;
		}
		
		private function send(content:Object):void {
			var sender:SMTPMailer = new SMTPMailer(MunchObserver.para.server, new Number(MunchObserver.para.port));
			sender.authenticate(MunchObserver.para.login, MunchObserver.para.pass);
			
			sender.sendAttachedMail("jeremy@ifelse.no", content.email, "MunchObserver1/4_"+content.time, "", content.img, "map_"+content.time+".jpg");
			sender.sendAttachedMail("jeremy@ifelse.no", content.email, "MunchObserver2/4_"+content.time, "", content.ba1, "munchspots_"+content.time+".csv");
			sender.sendAttachedMail("jeremy@ifelse.no", content.email, "MunchObserver3/4_"+content.time, "", content.ba2, "members_"+content.time+".csv");
			sender.sendAttachedMail("jeremy@ifelse.no", content.email, "MunchObserver4/4_"+content.time, "", content.ba3, "groupNote_"+content.time+".txt");
		}
		
		public function resumeSending():void {
			clearInterval(sendInterval);
			if(arrToSend.length > 0) {
				var lastObj:Object = arrToSend.pop();
				send(lastObj);
				sendInterval = setInterval(resumeSending, 5000);
			}
			else {
				sending = false;
			}
		}

		public function get sending():Boolean
		{
			return _sending;
		}

		public function set sending(value:Boolean):void
		{
			_sending = value;
		}

		public function get arrToSend():Array
		{
			return _arrToSend;
		}

		public function set arrToSend(value:Array):void
		{
			_arrToSend = value;
		}


	}
}