package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.utils.getQualifiedClassName;

	public class Main extends MovieClip
	{
		private var stateMachine:StateMachine;
		private var gameData:GameData;
		private var consoleActive:Boolean = false;

		private var screen:Screen;
		private var debugmode:Boolean = false;
		private var tick:Timer; //for timers that count up/down per second
		
		private function forceGC(): void{
			System.gc();
		}
		private function debug(): void{
			trace("Memory Used: "+System.totalMemory / 1024 / 1024 + " Mb");
			//forceGC();
		}
		
		public function DisableConsole():void{
			consoleActive = false;
		}
		
		public function GetGameData():GameData{
			return gameData;
		}
		public function Main():void
		{
			trace("Main.as: This should only be run once.");
			gameData = new GameData();
			
			stateMachine = new StateMachine(this);

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.focus = this;
			stage.stageFocusRect = false;
			stateMachine.ChangeState(new MainMenu(stateMachine,gameData));
			addListeners();
			addInputListeners();
		}
		public function addListeners():void{
			stateMachine.GetCurrentState().addEventListener(Screen.START, onScreenChange,false,0,true);
			stateMachine.GetCurrentState().addEventListener(Screen.CONTROLS,onScreenChange,false,0,true);
			stateMachine.GetCurrentState().addEventListener(Screen.END,onScreenChange,false,0,true);
			stateMachine.GetCurrentState().addEventListener(Screen.HELP,onScreenChange,false,0,true);
			stateMachine.GetCurrentState().addEventListener(Screen.CREDIT,onScreenChange,false,0,true);
			stateMachine.GetCurrentState().addEventListener(Screen.SOUNDBOARD,onScreenChange,false,0,true);
			stateMachine.GetCurrentState().addEventListener(Screen.ENDTOPREVIOUS,onScreenChange,false,0,true);
		}
		private function removeListeners():void{
			stateMachine.GetCurrentState().removeEventListener(Screen.START, onScreenChange);
			stateMachine.GetCurrentState().removeEventListener(Screen.CONTROLS, onScreenChange);
			stateMachine.GetCurrentState().removeEventListener(Screen.END, onScreenChange);
			stateMachine.GetCurrentState().removeEventListener(Screen.HELP, onScreenChange);
			stateMachine.GetCurrentState().removeEventListener(Screen.CREDIT, onScreenChange);
			stateMachine.GetCurrentState().removeEventListener(Screen.SOUNDBOARD, onScreenChange);
			stateMachine.GetCurrentState().removeEventListener(Screen.ENDTOPREVIOUS, onScreenChange);
		}
		private function addInputListeners():void{
			stage.addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_UP, key_up, false, 0, true);/*
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouse_move, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouse_down, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouse_up, false, 0, true);
			stage.addEventListener(MouseEvent.RIGHT_CLICK,right_click, false, 0, true);//disable rightclick
			stage.addEventListener(MouseEvent.CLICK,left_click,false,0,true);*/
			tick = new Timer(1000,0);
			tick.addEventListener(TimerEvent.TIMER,tickTimer,false,0,true);
			tick.start();
		}
		/*
		private function mouse_move(e:MouseEvent){screen.mouse_move(e);}
		private function mouse_up(e:MouseEvent){screen.mouse_up(e);}
		private function mouse_down(e:MouseEvent){screen.mouse_down(e);}
		private function right_click(e:MouseEvent){screen.right_click(e);}
		private function left_click(e:MouseEvent){}*/
		private function key_down(e:KeyboardEvent){
			
			if (e.keyCode == 192){
				MovieClip(stateMachine.consoleState).inputTXT.text = "";
				if (!consoleActive){
					gameData.p_IsFiring = false;// temp solution
					consoleActive = true;
					stateMachine.ToggleConsole(true);
					stateMachine.Pause();
				}
				else{
					stateMachine.ToggleConsole(false);
					consoleActive = false;
					stateMachine.UnPause();
					stage.focus = stateMachine.GetCurrentState();
				}
			}
			if (!consoleActive){
				stateMachine.GetCurrentState().key_down(e);
			}
			else{
				stateMachine.consoleState.key_down(e);
			}
		}
		private function key_up(e:KeyboardEvent){
			if (!consoleActive){
				stateMachine.GetCurrentState().key_up(e);
			}
			else{
				stage.focus = MovieClip(stateMachine.consoleState).inputTXT;
			}
			
		}
		private function Update(e:Event){
			stateMachine.Update(e);
		}
		private function tickTimer(e:TimerEvent):void{
			stateMachine.Tick(e);
			if (debugmode){
				debug();
			}
		}

		public function onScreenChange(e:Event):void
		{
			removeListeners();
			switch (e.type)
			{
				case Screen.CREDIT :
					stateMachine.ChangeState(new CreditsMenu(stateMachine,gameData),true);
					break;
				case Screen.START :
					stateMachine.ChangeState(new Game(stateMachine,gameData),true);
					break;
				case Screen.END :
					stateMachine.ChangeState(new MainMenu(stateMachine,gameData),true);
					break;
				case Screen.ENDTOPREVIOUS :
					stateMachine.GotoPreviousState();
					break;
				case Screen.CONTROLS :
					stateMachine.ChangeState(new ControlsMenu(stateMachine,gameData),true);
					break;
				case Screen.HELP :
					stateMachine.ChangeState(new HelpMenu(stateMachine,gameData),true);
					break;
				case Screen.SOUNDBOARD:
					stateMachine.ChangeState(new SoundboardMenu(stateMachine,gameData),true);
					break;
			}
			stage.focus = stateMachine.GetCurrentState();

		}

	}

}