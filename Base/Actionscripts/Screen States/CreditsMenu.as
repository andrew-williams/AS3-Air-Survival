package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class CreditsMenu extends Screen {
		
		
		public function CreditsMenu() {
			// constructor code
			btnBack.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		public function onClick(e:MouseEvent){
			dispatchEvent(new Event(Screen.END));
		}
		
	}
	
}
