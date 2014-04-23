package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class HelpIndex extends MovieClip {
		
		
		public function HelpIndex():void{
			// constructor code
			btnHelpBack.visible = false;
			helpItems.visible = false;
			btnHelpItems.addEventListener(MouseEvent.CLICK, itemScreen,false,0,true);
			btnHelpBack.addEventListener(MouseEvent.CLICK, backScreen,false,0,true);
		}
		
		private function itemScreen(e:MouseEvent):void{
			btnHelpItems.visible = false;
			btnHelpBack.visible = true;
			helpItems.visible = true;
		}
		
		private function backScreen(e:MouseEvent):void{
			btnHelpBack.visible = false;
			btnHelpItems.visible = true;
			helpItems.visible = false;
		}
		
		
		
	}
	
}
