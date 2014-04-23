package 
{

	import flash.display.MovieClip;
	import flash.events.*;

	public class screenManager extends MovieClip
	{

		private var screen:Screen;
		private var musichandler:musicHandler;
		private var currentScreen:String;
		
		public function screenManager()
		{
			currentScreen = "Main Menu";
			// constructor code
			musichandler = new musicHandler(musicHandler.TITLE);
			//musichandler.displaySoundTrack();
			//trace (musichandler.getMaxTracks());
			stage.stageFocusRect = false;
			screen = new MainMenu();
			this.addChild(screen);
			screen.addEventListener(Screen.START, onScreenChange);
			screen.addEventListener(Screen.CONTROLS, onScreenChange);
			screen.addEventListener(Screen.CREDIT, onScreenChange);
			screen.addEventListener(Screen.HELP, onScreenChange);
			screen.addEventListener(Screen.SOUNDBOARD, onScreenChange);
		}

		public function onScreenChange(e:Event)
		{
			this.removeChild(screen);
			switch (e.type)
			{
				case Screen.CREDIT :
					currentScreen = "Credits";
					screen = new CreditsMenu();
					screen.addEventListener(Screen.END,onScreenChange);
					this.addChild(screen);
					break;
				case Screen.START :
					currentScreen = "Game";
					screen = new Main(musichandler);
					screen.addEventListener(Screen.END, onScreenChange);
					this.addChild(screen);
					MovieClip(screen).startGame();
					break;
				case Screen.END :
					if (currentScreen == "Soundboard"){
						musichandler.setMusicAndPlay(musicHandler.TITLE);
					}
					currentScreen = "Main Menu";
					screen = new MainMenu();
					screen.addEventListener(Screen.START, onScreenChange);
					screen.addEventListener(Screen.CONTROLS, onScreenChange);
					screen.addEventListener(Screen.CREDIT, onScreenChange);
					screen.addEventListener(Screen.HELP, onScreenChange);
					screen.addEventListener(Screen.SOUNDBOARD, onScreenChange);
					this.addChild(screen);
					break;
				case Screen.CONTROLS :
					currentScreen = "Controls";
					screen = new ControlsMenu();
					screen.addEventListener(Screen.END, onScreenChange);
					this.addChild(screen);
					break;
				case Screen.HELP :
					currentScreen = "Help";
					screen = new HelpMenu();
					screen.addEventListener(Screen.END, onScreenChange);
					this.addChild(screen);
					break;
				case Screen.SOUNDBOARD:
					currentScreen = "Soundboard";
					musichandler.stopMusic();
					screen = new SoundboardMenu(musichandler);
					screen.addEventListener(Screen.END, onScreenChange);
					this.addChild(screen);
					break;
			}
			stage.focus = screen;

		}

	}

}