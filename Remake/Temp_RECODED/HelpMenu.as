package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class HelpMenu extends Screen {
		
		private var sm:StateMachine;
		private var gameData:GameData;
		
		public function HelpMenu(sm:StateMachine,gd:GameData):void{
			// constructor code
			this.sm = sm;
			gameData = gd;
			//addListeners();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage,false,0,true);
		}
		
		private function onAddedToStage(e:Event):void{
			addListeners();
		}
		
		private function addListeners():void{
			btnBack.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
		}
		
		private function removeListeners():void{
			btnBack.removeEventListener(MouseEvent.CLICK,onClick);
		}
		private function onClick(e:MouseEvent):void{
			removeListeners();
			dispatchEvent(new Event(Screen.ENDTOPREVIOUS));
		}
	}
}
