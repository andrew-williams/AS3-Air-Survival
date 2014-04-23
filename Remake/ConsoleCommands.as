package  {
	
	import flash.system.System;
	import flash.utils.getQualifiedClassName;
	
	public class ConsoleCommands {

		//Commands
		public var CMD_CHANGEMUS:String = "changemus";
		public var CMD_QUIT:String = "quit";
		public var CMD_SET:String = "set";
/*
		public var COMMANDS:String = "commands";
		public var GIVE:String = "give";
		public var GOD:String = "god";
		public var NOCLIP:String = "noclip";
		
		public var RATEOFFIRE:String = "rateoffire";
		public var REVEALMINIMAP:String = "revealminimap";
		public var SPAWN:String = "spawn";
		public var SPEED:String = "speed";
		public var SUMMON:String = "summon";
		public var TRACE:String = "trace";
		public var RESET_PUSH:String = "resetpush";
		public var MEM:String = "mem";
		public var ENDLEVEL:String = "endlevel";
		public var TELEPORT:String = "xteleto";
		*/
		private var sm:StateMachine;
		private var gameData:GameData;
		private var console:Console;
		
		public function ConsoleCommands(sm:StateMachine,gd:GameData,cs:Console): void {
			// constructor code
			this.sm = sm;
			gameData = gd;
			console = cs;
		}

		public function ToConsole(command:String){
			console.ToConsole(command);
		}

		public function PushMessage(command:String){
			console.setMessage("\n"+command);
		}

		public function msg(command:String = "null", attribute:String = "null", attribute2:String = "null", attribute3:String = "null"): void{
			var output:String = "";
			var a:int = 0;
			//var timer:int = 3;
			switch (command){
				case CMD_CHANGEMUS:
					doCmd(command,attribute,attribute2);
					break;
				case CMD_QUIT:
					doCmd(command);
					break;
				case CMD_SET:
					doCmd(command,attribute,attribute2);
					break;
				//case COMMANDS:
					//output = "\nTEST";
					//break;
				
				/*
					switch (attribute){
						case COMMANDS:
						output = "\ncommands: Display available commands and command information";
						break;
						case ENDLEVEL:
						output = "\nendlevel: Ends current level";
						break;
						case GIVE:
						output = "\ngive x y: Gives object x with amount y\ngive all: Gives everything";
						break;
						case GOD:
						output = "\ngod: Toggles Invincibility";
						break;
						case MEM:
						output = "\nmem: Displays current memory usage (Accurate only when standalone)";
						break;
						case NOCLIP:
						output = "\nnoclip: Toggles the ability to walk through walls";
						break;
						case QUIT:
						output = "\nquit: Ends game and returns to main menu";
						break;
						case RATEOFFIRE:
						output = "\nrateoffire x: Changes rate of fire for current weapon where x is between 10 and 2000";
						break;
						case RESET_PUSH:
						output = "\nresetpush: Resets all push blocks to its original location in the current room.";
						break;
						case SPAWN:
						output = "\nspawn z x y: Spawns object z at x and y positions\nspawn list: Displays all available objects to spawn";
						break;
						case SPEED:
						output = "\nspeed x: Changes player movement speed where x is between 1 and 100. Default: 8";
						break;
						case SUMMON:
						output = "\nsummon z x y: Summons object z at x and y positions\nsummon list: Displays all available objects to summon";
						break;
						default:
						output = "\ncommands command to get additional information\ncommands\nendlevel\ngive\ngod\nmem\nrateoffire\nresetpush\nnoclip\nquit\nrevealminimap\nspawn\nspeed\nsummon";
						break;
					}
					break;
					
				case GIVE:
					if (attribute == "all"){output = "\nGiving Everything";}
					break;
				case GOD:
					if (stageParent.player.getGodmode()){output = "\nGod Mode Off";}
					else{output = "\nGod Mode On";}
					break;
				case MEM:
					var tempmem = System.totalMemory/1024/1024;
					output = "\nMemory Usage: "+ tempmem + " Mb";
					break;
				case NOCLIP:
					if (stageParent.player.getNoclip()){output = "\nNoclip Off";}
					else{output = "\nNoclip On";}
					break;
				case RATEOFFIRE:
					output = "\nRate Of Fire = " + stageParent.player.getAttackSpeed();
					break;
				case RESET_PUSH:
					output = "\nResetting All Push Blocks";
					break;
				case REVEALMINIMAP:
					output = "\nRevealing Minimap";
					break;
				case SPAWN:
					if (attribute == "list"){
						output = "\nDisplaying Spawn List\n---------------------";
						for (a = 0; a < ed.getItemNameArray().length; a++){
							output += "\n"+ed.getItemNameArray()[a];
						}
						output += "\nA total of "+a+" objects found in the database";
					}
					output += "\nUsage: spawn object x y";
					break;
				case SPEED:
					output = "\nSpeed = '" + stageParent.player.getMovementSpeed() + "' Default = '8'";
					break;
				case SUMMON:
					if (attribute == "list"){
						output = "\nDisplaying Summon List\n---------------------";
						for (a = 0; a < ed.getEnemyNameArray().length; a++){
							output += "\n"+ed.getEnemyNameArray()[a];
						}
						output += "\nA total of "+a+" objects found in the database";
					}
					output += "\nUsage: summon object x y";
					break;
				case TRACE: //DEBUG ONLY
					if (attribute != null){
						output += "\nTracing: " + attribute;
						trace("Tracing: " + attribute);
						timer = 0;
					}
					else{
						output += "\nUsage: trace message";
					}
					break;
					*/
				default:
					//output += console.returnLastInputCommand();
					//timer = 0;
					break;
			}
			console.setMessage(output);
		}
/*
		public function passConsoleMessage(output:String,timer:int = 0): void{
			console.setMessage(output,timer);
		}*/

		public function doCmd(command:String = "null", attribute1:String = "null", attribute2:String = "null", attribute3:String = "null"): void{
			var tempNum1:Number = Number(attribute1);
			var tempNum2:Number = Number(attribute2);
			var tempNum3:Number = Number(attribute3);
			var a:int = 0;
			var output:String = "";
			switch (command){
				case CMD_CHANGEMUS:
					output += "\nChanging Music Track To: Track #"+tempNum1;
					trace(command+" "+attribute1+" "+tempNum1);
					switch(tempNum1){
						case 0:
						output += "\nStopping Music.";
						gameData.musichandler.stopMusic();
						break;
						case 1:
						gameData.musichandler.setMusicAndPlay(musicHandler.TITLE);
						break;
						case 2:
						gameData.musichandler.setMusicAndPlay(musicHandler.LEVEL1, tempNum2);
						break;
						case 3:
						gameData.musichandler.setMusicAndPlay(musicHandler.BOSS, tempNum2);
						break;
						default:
							output += "\nUndefined Track Number. Stopping music instead.";
							gameData.musichandler.stopMusic();
						break;
					}
					console.setMessage(output);
					break;
				case CMD_QUIT:
					if (getQualifiedClassName(sm.currentState) == "Game")
					{
						output += "Quitting Game.";
						PushMessage(output);
						sm.UnPause();
						sm.main.DisableConsole();
						sm.ChangeState(new MainMenu(sm,gameData));
					}
					break;
				case CMD_SET:
					switch (attribute1){
						case "charge":
							if (tempNum2 < 0){
								tempNum2 = 0;
							}
							else if (tempNum2 > 1000){
								tempNum2 = 1000; 
							}
							output += "Setting Charge To: " + tempNum2;
							gameData.p_Charge = tempNum2;
							PushMessage(output);
							break;
					}
					break;
				/*
				
				case TELEPORT:
					stageParent.player.x = tempNum1 * 32 + 16;
					stageParent.player.y = tempNum2 * 32 + 16;
					break;
				case ENDLEVEL:
				case GIVE:
				case GOD:
				case NOCLIP:
				case RATEOFFIRE:
				case SPEED:
					stageParent.player.checkConsoleInput(command,attribute1,attribute2,attribute3);
					break;
				case QUIT:
					stageParent.endgame();
					break;
				case REVEALMINIMAP:
					stageParent.revealminimap();
					break;
				case SPAWN:
					if (attribute1 != "list"){
						for (a = 0; a < ed.getItemNameArray().length; a++){
							if (ed.getItemNameArray()[a] == attribute1){
								console.setMessage("\nSpawning '" + attribute1 + "' At (" + tempNum2 + "," + tempNum3 + ")");
								stageParent.getCurrentRoomArray().addItemObject(tempNum2,tempNum3,a + 1);
								break;
							}
						}
					}
					break;
					
				case SUMMON:
					if (attribute1 != "list"){
						for (a = 0; a < ed.getEnemyNameArray().length; a++){
							if (ed.getEnemyNameArray()[a] == attribute1){
								stageParent.getCurrentRoomArray().addEnemyObject(tempNum2,tempNum3,a + 1);
								break;
							}
						}
					}
					break;
					
				case RESET_PUSH:
					stageParent.getCurrentRoomArray().resetPushBlocks();
					break;
					*/
			}
		}
		
	}
}
