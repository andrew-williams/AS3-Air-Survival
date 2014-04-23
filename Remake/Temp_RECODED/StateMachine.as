package  {
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.*;
	import flash.display.MovieClip;
	
	public class StateMachine {
		// States
		public var previousState:Screen;
		public var currentState:Screen;
		public var nextState:Screen;
		
		//Permanent States
		//gameState = This will hold the game data at all times until quit.
		public var gameState:Screen;
		//consoleState = This will hold console data at all times for logging purposes etc.
		public var consoleState:Screen;
		
		public var main:Main;
		
		private var pauseState:Boolean = false;
		
		public function StateMachine(base:Main):void {
			main = base;
			trace("StateMachine.as: This should only be run once.");
			Init();
		}
		
		private function Init():void {
			previousState = null;
			currentState = null;
			nextState = null;
			gameState = null;
			consoleState = new Console(this,main.GetGameData());
			consoleState.Init();
		}
		
		public function SetNextState(newState:Screen):void{
			nextState = newState;
		}
		
		public function GotoNextState():void{
			previousState = currentState;
			currentState = nextState;
			nextState = null;
		}
		
		public function GotoPreviousState():void{
			var tempState:Screen = currentState;
			UnloadState(currentState);
			currentState = previousState;
			previousState = tempState;
			LoadState(currentState);
			AddDispatchers();
		}
		private function AddDispatchers():void{
			main.addListeners();
		}
		
		public function ToggleConsole(isOn:Boolean):void{
			if (isOn){
				LoadState(consoleState);
			}
			else{
				UnloadState(consoleState);
			}
		}
		
		public function ChangeState(newState:Screen, allowNew:Boolean = false):void{
			if (allowNew){
				previousState = currentState;
				UnloadState(currentState);
				currentState = newState;
				LoadState(currentState);
				AddDispatchers();
			}
			else{
				if (getQualifiedClassName(previousState) == getQualifiedClassName(newState)){
					GotoPreviousState();
				}
				else{
					previousState = currentState;
					UnloadState(currentState);
					currentState = newState;
					LoadState(currentState);
					AddDispatchers();
				}
			}
			
		}
		
		public function GetCurrentState():Screen{
			return currentState;
		}
		
		private function UnloadState(checkState:Screen):void{
			if (checkState != null){
				main.removeChild(checkState);
			}
			else{
				trace("No previous state to unload");
			}
		}
		private function LoadState(checkState:Screen):void{
			main.addChild(checkState);
		}
		
		public function Tick(e:TimerEvent):void{
			//trace("Previous:"+previousState+" Current:"+currentState+" Next:"+nextState);
			if (!pauseState){
				currentState.Tick(e);
			}
		}

		public function Update(e:Event):void{
			if (!pauseState){
				currentState.Update(e);
			}
		}
		
		public function Pause():void{
			pauseState = true;
		}
		public function UnPause():void{
			pauseState = false;
		}
		public function IsPaused():Boolean{
			return pauseState;
		}

	}
	
}
