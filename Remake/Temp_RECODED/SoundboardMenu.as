package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class SoundboardMenu extends Screen {
		
		private var currentTracks:int = 1;
		private var maxTracks:int;
		
		private var sm:StateMachine;
		private var gameData:GameData;
		
		public function SoundboardMenu(sm:StateMachine,gd:GameData):void {
			this.sm = sm;
			gameData = gd;
			// constructor code
			maxTracks = gameData.musichandler.getMaxTracks();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage,false,0,true);
		}
		private function onAddedToStage(e:Event):void{
			updateHud();
			addListeners();
			gameData.cc.ToConsole("changemus 0");
			//gameData.musichandler.stopMusic();
		}
		private function addListeners():void{
			btnBack.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
			btnPlay.addEventListener(MouseEvent.CLICK,onPlay,false,0,true);
			btnPlayLoop.addEventListener(MouseEvent.CLICK,onPlayLoop,false,0,true);
			btnPrev.addEventListener(MouseEvent.CLICK,onPrev,false,0,true);
			btnNext.addEventListener(MouseEvent.CLICK,onNext,false,0,true);
		}
		
		private function updateHud():void{
			txtCurrent.text = currentTracks.toString();
			txtMax.text = maxTracks.toString();
		}
		
		private function onNext(e:MouseEvent):void{
			gameData.cc.ToConsole("changemus 0");
			//gameData.musichandler.stopMusic();
			if (currentTracks < maxTracks){
				currentTracks++;
			}
			updateHud();
		}
		
		private function onPrev(e:MouseEvent):void{
			gameData.cc.ToConsole("changemus 0");
			//gameData.musichandler.stopMusic();
			if (currentTracks > 1){
				currentTracks--;
			}
			updateHud();
		}
		
		private function onPlay(e:MouseEvent):void{
			switch (currentTracks){
				case 1:
					gameData.cc.ToConsole("changemus 1 0");
					//gameData.musichandler.setMusicAndPlay(musicHandler.TITLE);
					break;
				case 2:
					gameData.cc.ToConsole("changemus 2 1000");
					//gameData.musichandler.setMusicAndPlay(musicHandler.LEVEL1,1000);
					break;
				case 3:
					gameData.cc.ToConsole("changemus 3 1000");
					//gameData.musichandler.setMusicAndPlay(musicHandler.BOSS, 1000);
					break;
			}
		}
		
		private function onPlayLoop(e:MouseEvent):void{
			switch (currentTracks){
				case 1:
					gameData.cc.ToConsole("changemus 1 0");
					//gameData.musichandler.setMusicAndPlay(musicHandler.TITLE, 0);
					break;
				case 2:
					gameData.cc.ToConsole("changemus 2 8350");
					//gameData.musichandler.setMusicAndPlay(musicHandler.LEVEL1,8350);
					break;
				case 3:
					gameData.cc.ToConsole("changemus 3 12250");
					//gameData.musichandler.setMusicAndPlay(musicHandler.BOSS,12250);
					break;
			}
		}
		
		private function clearListeners():void{
			btnBack.removeEventListener(MouseEvent.CLICK,onClick);
			btnPlay.removeEventListener(MouseEvent.CLICK,onPlay);
			btnPlayLoop.removeEventListener(MouseEvent.CLICK,onPlayLoop);
			btnPrev.removeEventListener(MouseEvent.CLICK,onPrev);
			btnNext.removeEventListener(MouseEvent.CLICK,onNext);
		}
		
		private function onClick(e:MouseEvent):void{
			clearListeners();
			dispatchEvent(new Event(Screen.END));
		}
		
	}
	
}
