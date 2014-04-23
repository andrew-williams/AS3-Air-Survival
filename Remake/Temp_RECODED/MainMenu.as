package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class MainMenu extends Screen {
		
		private var sm:StateMachine;
		private var gameData:GameData;
		
		public function MainMenu(sm:StateMachine,gd:GameData):void{
			// constructor code
			this.sm = sm;
			gameData = gd;
			gameData.cc.ToConsole("changemus 1");
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage,false,0,true);
			
		}
		
		function onAddedToStage(e:Event):void
		{
			addListeners();
		}
		private function addListeners() : void{
			btnPlay.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
			btnControls.addEventListener(MouseEvent.CLICK,onControls,false,0,true);
			btnHelp.addEventListener(MouseEvent.CLICK,onHelp,false,0,true);
			btnCredit.addEventListener(MouseEvent.CLICK,onCredits,false,0,true);
			btnSoundboard.addEventListener(MouseEvent.CLICK,onSoundboard,false,0,true);
		}
		private function removeListeners() : void{
			btnPlay.removeEventListener(MouseEvent.CLICK,onClick);
			btnControls.removeEventListener(MouseEvent.CLICK,onControls);
			btnHelp.removeEventListener(MouseEvent.CLICK,onHelp);
			btnCredit.removeEventListener(MouseEvent.CLICK,onCredits);
			btnSoundboard.removeEventListener(MouseEvent.CLICK,onSoundboard);
		}
		
		private function onSoundboard(e:MouseEvent):void{
			removeListeners();
			dispatchEvent(new Event(Screen.SOUNDBOARD));
		}
		
		private function onClick(e:MouseEvent):void{
			removeListeners();
			dispatchEvent(new Event(Screen.START));
		}
		
		private function onControls(e:MouseEvent):void{
			removeListeners();
			dispatchEvent(new Event(Screen.CONTROLS));
		}
		
		private function onCredits(e:MouseEvent):void{
			removeListeners();
			dispatchEvent(new Event(Screen.CREDIT));
		}
		
		private function onHelp(e:MouseEvent):void{
			removeListeners();
			dispatchEvent(new Event(Screen.HELP));
		}
		
	}
	
}
