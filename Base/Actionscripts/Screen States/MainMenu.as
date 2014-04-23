package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MainMenu extends Screen {
		
		var test;
		
		public function MainMenu() {
			// constructor code
			btnPlay.addEventListener(MouseEvent.CLICK,onClick);
			btnControls.addEventListener(MouseEvent.CLICK,onControls);
			btnCredit.addEventListener(MouseEvent.CLICK,onCredits);
			btnHelp.addEventListener(MouseEvent.CLICK,onHelp);
			btnSoundboard.addEventListener(MouseEvent.CLICK,onSoundboard);
		}
		
		public function onSoundboard(e:MouseEvent){
			dispatchEvent(new Event(Screen.SOUNDBOARD));
		}
		
		public function onClick(e:MouseEvent){
			dispatchEvent(new Event(Screen.START));
		}
		
		public function onControls(e:MouseEvent){
			dispatchEvent(new Event(Screen.CONTROLS));
		}
		
		public function onCredits(e:MouseEvent){
			dispatchEvent(new Event(Screen.CREDIT));
		}
		
		public function onHelp(e:MouseEvent){
			dispatchEvent(new Event(Screen.HELP));
		}
		
	}
	
}
