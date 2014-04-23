package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class HelpIndex extends MovieClip {
		
		
		public function HelpIndex() {
			// constructor code
			btnHelpBack.visible = false;
			helpItems.visible = false;
			btnHelpItems.addEventListener(MouseEvent.CLICK, itemScreen);
			btnHelpBack.addEventListener(MouseEvent.CLICK, backScreen);
		}
		
		public function itemScreen(e:MouseEvent){
			btnHelpItems.visible = false;
			btnHelpBack.visible = true;
			helpItems.visible = true;
		}
		
		public function backScreen(e:MouseEvent){
			btnHelpBack.visible = false;
			btnHelpItems.visible = true;
			helpItems.visible = false;
		}
		
		
		
	}
	
}
