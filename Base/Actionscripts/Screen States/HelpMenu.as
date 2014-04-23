package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class HelpMenu extends Screen {
		
		
		public function HelpMenu() {
			// constructor code
			btnBack.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		public function onClick(e:MouseEvent){
			dispatchEvent(new Event(Screen.END));
		}
	}
}
