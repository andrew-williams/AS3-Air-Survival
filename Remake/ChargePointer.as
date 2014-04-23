package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class ChargePointer extends MovieClip {

		var chargeShot:ChargePointer;
		var chargeActive:Boolean = false;
		private var chargeTimer:Timer;
		private var gameData:GameData;
		var chargeTimerInterval:int = 0;

		public function ChargePointer(gd:GameData):void {
			gameData = gd;
		}
		
		public function ActivateCharge():void {
			this.gotoAndStop(2);
			chargeTimer = new Timer (1000, 5);
			chargeTimer.addEventListener(TimerEvent.TIMER,chargeFunction,false,0,true);
			chargeTimer.addEventListener(TimerEvent.TIMER_COMPLETE,chargeDone,false,0,true);
			chargeTimer.start();
		}
		
		public function chargeFunction(e:TimerEvent):void {}
		
		public function chargeDone(e:TimerEvent):void {
			this.gotoAndStop(1);
			chargeTimer.removeEventListener(TimerEvent.TIMER,chargeFunction);
			chargeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,chargeDone);
			gameData.p_ChargeActive = false;
		}
		
	}
	
}
