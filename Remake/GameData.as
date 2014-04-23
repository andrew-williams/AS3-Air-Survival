package  {
	
	public class GameData {

		public var musichandler:musicHandler;
		public var cc:ConsoleCommands;
		
		//Game Dimensions For Playable Area
		public const stageW:int = 605;
		public const stageWt:int = 5;
		public const stageHt:int = 49;
		public const stageH:int = 849;
		
		//Background Data
		public var backdrop:BGContainer;
		public var midground:MidGroundContainer;
		public var midgroundFlip:MidGroundContainer;
		
		//Player Data
		public var p_Health:int;
		public var p_Charge:int;
		public var p_ChargeLevel:int;
		public var p_ChargeActive:Boolean;
		public var p_AttackRating:int;
		public var p_AttackSpeed:Number;
		public var p_Score:int;
		public var p_Life:int;
		public var p_Bomb:int;
		public var p_AllowAttack:Boolean;
		public var p_IsFiring:Boolean;
		
		//Enemy Data
		
		public var currentLevel:int;
		
		//Timer Data
		public var seconds:int = 0;
		
		public function GameData():void{
			// constructor code
			trace("GameData.as: This should only be run once.");
			Init();
		}
		
		private function Init():void{
			musichandler = new musicHandler();
		}
		
		public function InitPlayerStats():void{
			p_Health = 100;
			p_Charge = 0;
			p_ChargeLevel = 0;
			p_AttackRating = 1;
			p_AttackSpeed = 125;
			p_Score = 0;
			p_Life = 2;
			p_Bomb = 0;
			p_AllowAttack = true;
			p_ChargeActive = false;
			p_IsFiring = false;
			currentLevel = 0;
		}

	}
	
}
