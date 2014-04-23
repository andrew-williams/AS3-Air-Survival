package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class ControlsMenu extends Screen {
		
		
		public function ControlsMenu() {
			// constructor code
			btnBack.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		public function onClick(e:MouseEvent){
			dispatchEvent(new Event(Screen.END));
		}
		
	}
	
}
