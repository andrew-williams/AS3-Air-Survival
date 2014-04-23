package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class SoundboardMenu extends Screen {
		
		private var musichandler;
		private var currentTracks:int = 1;
		private var maxTracks:int;
		
		public function SoundboardMenu(music) {
			// constructor code
			musichandler = music;
			maxTracks = musichandler.getMaxTracks();
			updateHud();
			btnBack.addEventListener(MouseEvent.CLICK,onClick);
			btnPlay.addEventListener(MouseEvent.CLICK,onPlay);
			btnPlayLoop.addEventListener(MouseEvent.CLICK,onPlayLoop);
			btnPrev.addEventListener(MouseEvent.CLICK,onPrev);
			btnNext.addEventListener(MouseEvent.CLICK,onNext);
		}
		
		private function updateHud(){
			txtCurrent.text = currentTracks.toString();
			txtMax.text = maxTracks.toString();
		}
		
		private function onNext(e:MouseEvent){
			musichandler.stopMusic();
			if (currentTracks < maxTracks){
				currentTracks++;
			}
			updateHud();
		}
		
		private function onPrev(e:MouseEvent){
			musichandler.stopMusic();
			if (currentTracks > 1){
				currentTracks--;
			}
			updateHud();
		}
		
		private function onPlay(e:MouseEvent){
			switch (currentTracks){
				case 1:
					musichandler.setMusicAndPlay(musicHandler.TITLE);
					break;
				case 2:
					musichandler.setMusicAndPlay(musicHandler.LEVEL1,1000);
					break;
				case 3:
					musichandler.setMusicAndPlay(musicHandler.BOSS, 1000);
					break;
			}
		}
		
		private function onPlayLoop(e:MouseEvent){
			switch (currentTracks){
				case 1:
					musichandler.setMusicAndPlay(musicHandler.TITLE, 0);
					break;
				case 2:
					musichandler.setMusicAndPlay(musicHandler.LEVEL1,8350);
					break;
				case 3:
					musichandler.setMusicAndPlay(musicHandler.BOSS,12250);
					break;
			}
		}
		
		private function clearListeners(){
			btnBack.removeEventListener(MouseEvent.CLICK,onClick);
			btnPlay.removeEventListener(MouseEvent.CLICK,onPlay);
			btnPlayLoop.removeEventListener(MouseEvent.CLICK,onPlayLoop);
			btnPrev.removeEventListener(MouseEvent.CLICK,onPrev);
			btnNext.removeEventListener(MouseEvent.CLICK,onNext);
		}
		
		private function onClick(e:MouseEvent){
			clearListeners();
			dispatchEvent(new Event(Screen.END));
		}
		
	}
	
}
