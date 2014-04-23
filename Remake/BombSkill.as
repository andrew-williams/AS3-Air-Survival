package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	public class BombSkill extends MovieClip {
		
		private var bombActive:Boolean;
		private var bombTimer:Timer;
		
		public function BombSkill(bState:Boolean = false) {
			// constructor code
			bombActive = bState;
			this.gotoAndStop(1);
		}
		
		public function activateBomb(){
			bombActive = true;
			this.gotoAndStop(2);
			bombTimer = new Timer(1000,1);
			bombTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endBombDrop);
			bombTimer.start();
		}
		
		private function endBombDrop(e:TimerEvent){
			bombTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, endBombDrop);
			this.gotoAndStop(3);
			bombTimer = new Timer(3000,1);
			bombTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endBombExplosion);
			bombTimer.start();
		}
		
		private function endBombExplosion(e:TimerEvent){
			deactivateBomb();
		}
		
		private function deactivateBomb(){
			bombTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, endBombExplosion);
			this.gotoAndStop(1);
			bombActive = false;
		}
		
		public function isBombActive(){
			return bombActive;
		}
	}
	
}
