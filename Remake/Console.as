package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import flash.events.*;
	import flash.ui.Keyboard;
	
	public class Console extends Screen {
		
		private var lastInputCommand:String = "";
		private var lastInput:String;
		private var lastAttribute:String;
		private var lastAttribute2:String;
		private var lastAttribute3:String;
		private var lastOutput:String;
		
		private var sm:StateMachine;
		private var gameData:GameData;
		//private var cc:ConsoleCommands;
		
		public function Console(sm:StateMachine,gd:GameData): void {
			this.sm = sm;
			gameData = gd
			
			// constructor code
		}
		public override function Init():void{
			gameData.cc = new ConsoleCommands(sm,gameData,this);
			inputTXT.multiline = false;
			inputTXT.text = "";
			txtOutput.appendText("\n\n\n\n\n\n\n\n\n\n\n\n");
		}
		public function returnLastInputCommand():String{
			return lastInputCommand;
		}
		
		public function getLastInputCommand(): void{
			inputTXT.text = lastInputCommand;
		}
		
		public function getLastInput():String{
			return lastInput;
		}
		
		public function getLastAttribute2():String{
			return lastAttribute2;
		}
		
		public function getLastAttribute():String{
			return lastAttribute;
		}
		
		public function getLastAttribute3():String{
			return lastAttribute3;
		}
		private function splitString(msg:String): void{
			var stringToSplit:String = msg;
     		var splitString:Array = stringToSplit.split(" "); // results == ["","b"]
     		for (var a:int = 0; a < splitString.length; a++){
				if (a == 0){
					lastInput = splitString[a];
					lastAttribute = null;
					lastAttribute2 = null;
				}
				else if (a == 1){
					lastAttribute = splitString[a];
				}
				else if (a == 2){
					lastAttribute2 = splitString[a];
				}
				else if (a == 3){
					lastAttribute3 = splitString[a];
				}
			}
		}
		
		public function setInput(displayCommand:Boolean = false): void{
			if (displayCommand){
				txtOutput.appendText("\n] " + inputTXT.text);
				lastInputCommand = inputTXT.text;
			}
			splitString(inputTXT.text);
			inputTXT.text = "";
			txtOutput.scrollV = txtOutput.maxScrollV;
		}
		public function getLastOutput():String{
			return lastOutput;
		}
		
		public function setMessage(msg:String): void{
			trace(msg);
			lastOutput = msg;
			//MovieClip(parent.parent).setConsoleDisplayTimer(timer);
			txtOutput.appendText(msg);
			txtOutput.scrollV = txtOutput.maxScrollV;
			
		}
		
		public function ToConsole(command:String){
			inputTXT.text = command;
			setInput();
			gameData.cc.msg(lastInput,lastAttribute,lastAttribute2,lastAttribute3);
		}
		
		//Overrides
		
		public override function key_down(e:KeyboardEvent):void{
			switch (e.keyCode){
				case 192:// `/~ key
					//inputTXT.text = "";
					break;
				case Keyboard.ENTER:
					setInput(true);
					gameData.cc.msg(lastInput,lastAttribute,lastAttribute2,lastAttribute3);
					break;
			}
		}
	}
	
}
