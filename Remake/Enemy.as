package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Enemy extends MovieClip {
		
		// Base Variables
		private var moveLeft:Boolean = false;
		private var moveRight:Boolean = false;
		private var moveUp:Boolean = false;
		private var moveDown:Boolean = false;
		private var sX:int;
		private var sY:int;
		private var sXT:int;
		private var sYT:int;
		private var gameData:GameData;
		// Enemy Statistics
		private var e_State:int;
		private var e_Instruction:int;
		private var e_InitInstruction:Boolean;
		private var e_Health:int;
		private var e_IsDead:Boolean;
		
		private var e_TravelDistance:Number;
		private var e_CurrentDistance:Number;
		private var e_AccelerationDistance:Number;
		private var e_Acceleration:Number;
		private const e_AccelDecelRate:Number = 250;
		private var e_SpeedY:Number;
		private var e_SpeedX:Number;
		private var e_MaxSpeed:Number;
		
		
		public function Enemy(stageX:int, stageY:int, stageXT:int, stageYT:int,gd:GameData,eState:int):void{
			gameData = gd;
			sX = stageX;
			sY = stageY;
			sXT = stageXT;
			sYT = stageYT;
			e_Health = Math.ceil(Math.random() * 10);
			//movement stuff
			e_State = eState;
			e_InitInstruction = false;
			e_Instruction = 0;
			e_IsDead = false;
			
			e_TravelDistance = 0;
			e_CurrentDistance = 0;
			e_AccelerationDistance = 0;
			e_SpeedY = 0;
			e_SpeedX = 0;
			e_MaxSpeed = 0;
			e_Acceleration = 0;
		}
		
		public function TakeDamage(damage:int):void{
			e_Health -= damage;
			if (e_Health <= 0){
				e_IsDead = true;
			}
		}
		
		// Update all enemy functions here such as movement,
		// Function called in game so if game is paused, enemies are paused.
		public function Update(e:Event):void{
			Move(e_State);
		}
		
		public function IsDead():Boolean{
			return e_IsDead;
		}
		private function Move(enemyState:int){
			switch (enemyState){
				case 1:
					TestMovement();
					break;
				case 2:
					ReverseTestMovement();
					break;
				default:
					break;
			}
		}
		
		private function MoveY(maxSpeed:Number,isReverse:Boolean, isDecel:Boolean):void{
			var distancePercentage:Number;
			if (isDecel){
				if (e_CurrentDistance >= (e_TravelDistance - e_AccelDecelRate)){
					e_AccelerationDistance = e_CurrentDistance - (e_TravelDistance - e_AccelDecelRate);
					distancePercentage = e_AccelerationDistance / e_AccelDecelRate;
					e_SpeedY = (((maxSpeed * (distancePercentage * distancePercentage)) * -1) + maxSpeed);
					if (e_SpeedY < 1){
						e_SpeedY = 1;
					}
				}
			}
			else{
				e_SpeedY += e_Acceleration;
				if (e_SpeedY > maxSpeed){
					e_SpeedY = maxSpeed;
				}
			}
			if (!isReverse){
				this.y += e_SpeedY;
			}
			else{
				this.y -= e_SpeedY;
			}
		}
		private function MoveX(maxSpeed:Number,isReverse:Boolean, isDecel:Boolean):void{
			var distancePercentage:Number;
			if (isDecel){
				if (e_CurrentDistance >= (e_TravelDistance - e_AccelDecelRate)){
				
					e_AccelerationDistance = e_CurrentDistance - (e_TravelDistance - e_AccelDecelRate);
					distancePercentage = e_AccelerationDistance / e_AccelDecelRate;
					e_SpeedX = (((maxSpeed * (distancePercentage * distancePercentage)) * -1) + maxSpeed);
					if (e_SpeedX < 1){
						e_SpeedX = 1;
					}
				}
			}
			else{
				e_SpeedX += e_Acceleration;
				if (e_SpeedX > maxSpeed){
					e_SpeedX = maxSpeed;
				}
			}
			if (!isReverse){
				this.x += e_SpeedX;
			}
			else{
				this.x -= e_SpeedX;
			}
		}
		private function CalculateDistance():void{
			if (e_SpeedY > e_SpeedX){
				e_CurrentDistance += e_SpeedY;
			}
			else if (e_SpeedY < e_SpeedX){
				e_CurrentDistance += e_SpeedX;
			}
			else{
				e_CurrentDistance += 1;
			}
		}
		private function TestMovement():void{
			var i:int = 0;
			
			switch (e_Instruction){
				case 0: // First Instruction
					//trace("Doing instruction 1");
					//trace("Distance:"+e_CurrentDistance+"/"+e_TravelDistance);
					if (!e_InitInstruction){
						e_InitInstruction = true;
						e_TravelDistance = 400;
						e_CurrentDistance = 0;
						e_MaxSpeed = 10;
						e_SpeedY = 10;
						e_SpeedX = 4;
						e_AccelerationDistance = 0;
					}
					if (e_CurrentDistance < e_TravelDistance){
						MoveY(e_MaxSpeed,false,true);
						MoveX(e_SpeedX,false,false);
						CalculateDistance();
					}
					else{
						//trace("Instruction 1 Complete");
						e_Instruction++;
						e_InitInstruction = false;
					}
					break;
				case 1:
					//trace("Doing instruction 2:");
					if (!e_InitInstruction){
						e_InitInstruction = true;
						e_TravelDistance = 800;
						e_CurrentDistance = 0;
						e_MaxSpeed = 10;
						//e_SpeedY = 10;
						//e_SpeedX = 2;
						e_AccelerationDistance = 0;
						e_Acceleration = 0.1;
					}
					if (e_CurrentDistance < e_TravelDistance){
						MoveY(e_MaxSpeed,true,false);
						MoveX(1,false,false);
						CalculateDistance();
					}
					else{
						//trace("Instruction 2 Complete");
						e_Instruction++;
						e_InitInstruction = false;
						
					}
					break;
				case 2:
					//trace("Doing instruction 3: Go Back Up");
					if (!e_InitInstruction){
						e_InitInstruction = true;
						e_TravelDistance = 0;
						e_CurrentDistance = 0;
						e_MaxSpeed = 0;
						e_SpeedY = 0;
						e_SpeedX = 0;
						e_AccelerationDistance = 0;
					}
						//trace("Instructions Complete");
						e_IsDead = true;
						e_Instruction++;
						e_InitInstruction = false;
					break;
			}
		}
		
		private function ReverseTestMovement():void{
			var i:int = 0;
			
			switch (e_Instruction){
				case 0: // First Instruction
					//trace("Doing instruction 1");
					//trace("Distance:"+e_CurrentDistance+"/"+e_TravelDistance);
					if (!e_InitInstruction){
						e_InitInstruction = true;
						e_TravelDistance = 400;
						e_CurrentDistance = 0;
						e_MaxSpeed = 10;
						e_SpeedY = 10;
						e_SpeedX = 4;
						e_AccelerationDistance = 0;
					}
					if (e_CurrentDistance < e_TravelDistance){
						MoveY(e_MaxSpeed,false,true);
						MoveX(e_SpeedX,true,false);
						CalculateDistance();
					}
					else{
						//trace("Instruction 1 Complete");
						e_Instruction++;
						e_InitInstruction = false;
					}
					break;
				case 1:
					//trace("Doing instruction 2:");
					if (!e_InitInstruction){
						e_InitInstruction = true;
						e_TravelDistance = 800;
						e_CurrentDistance = 0;
						e_MaxSpeed = 10;
						//e_SpeedY = 0;
						//e_SpeedX = 0;
						e_AccelerationDistance = 0;
						e_Acceleration = 0.1;
					}
					if (e_CurrentDistance < e_TravelDistance){
						MoveY(e_MaxSpeed,true,false);
						MoveX(1,true,false);
						CalculateDistance();
					}
					else{
						//trace("Instruction 2 Complete");
						e_Instruction++;
						e_InitInstruction = false;
						
					}
					break;
				case 2:
					//trace("Doing instruction 3: Go Back Up");
					if (!e_InitInstruction){
						e_InitInstruction = true;
						e_TravelDistance = 0;
						e_CurrentDistance = 0;
						e_MaxSpeed = 0;
						e_SpeedY = 0;
						e_SpeedX = 0;
						e_AccelerationDistance = 0;
					}
						//trace("Instructions Complete");
						e_IsDead = true;
						e_Instruction++;
						e_InitInstruction = false;
					break;
			}
		}
		/*
		private var health:int;
		var moveLeft:Boolean = false;
		var moveRight:Boolean = false;
		var moveDown:Boolean = false;
		var moveUp:Boolean = false;
		var sX:int;
		var sY:int;
		var sXT:int;
		var sYT:int;
		var xSpeed:int;
		var ySpeed:int;
		var isboss:Boolean = false;
		//
		public function Enemy(stageX, stageY, stageXT, stageYT, enemyType:String = "Test") {
			// constructor code
			sX = stageX;
			sY = stageY;
			sXT = stageXT;
			sYT = stageYT;
			selectEnemy(enemyType);
		}
		
		private function selectEnemy(enemyType){
			switch (enemyType){
				case "Test":
					health = Math.ceil(Math.random() * 50);
					this.gotoAndStop(1);
					break;
				case "Boss Test":
					health = 20000;
					this.gotoAndStop(2);
					break;
			}
		}
		
		public function startBossMovement(bossNum = 1){
			isboss = true;
			trace("Insert Boss Movement Here");
			for (var i:int = 0; i < 300; i++){
				this.y++;
			}
			var rand:int = Math.ceil(Math.random() * 100);
			if (rand < 50){
					moveLeft = true;
			}
			else if (rand >= 50){
				moveRight = true;
			}
			this.addEventListener(Event.ENTER_FRAME,moveAdvancedEnemy);
		}
		
		private function moveAdvancedEnemy(e:Event){
			
			xSpeed = 4;
			
			
			
			
			if (moveLeft){
				this.x -= xSpeed;
				if (this.x < (sXT + (this.width / 2))){
					moveLeft = false;
					moveRight = true;
				}
			}
			else if (moveRight){
				this.x += xSpeed;
				if (this.x > (sX - this.width / 2)){
					moveRight = false;
					moveLeft = true;
				}
			}
			
			
		}

		
		public function startMovement(){
			var temp :int;
			if (this.x < (sX / 3)){
				temp = 6;
			}
			else if (this.x > ((sX / 3) + (sX / 3))){
				temp = 8;
			}
			else{
				temp = 7;
			}
			xSpeed = Math.ceil(Math.random() * 6 + 2);
			ySpeed = Math.ceil(Math.random() * 8 + 2);
			
			
			switch (temp){
				case 1: // 
					moveLeft = true;
					break;
				case 2:
					moveLeft = true;
					moveUp = true;
					break;
				case 3:
					moveUp = true;
					break;
				case 4:
					moveUp = true;
					moveRight = true;
					break;
				case 5:
					moveRight = true;
					break;
				case 6:
					moveRight = true;
					moveDown = true;
					break;
				case 7: // GO STRAIGHT DOWN
					moveDown = true;
					break;
				case 8:
					moveDown = true;
					moveLeft = true;
					break;
			}
			this.addEventListener(Event.ENTER_FRAME,moveEnemy);
		}
		
		public function moveEnemy(e:Event){
			if (moveLeft){
				this.x -= xSpeed;
			}
			else if (moveRight){
				this.x += xSpeed;
			}
			if (moveDown){
				this.y += ySpeed;
			}
			else if (moveUp){
				this.y -= ySpeed;
			}
		}
		
		public function getX(){
			return this.x;
		}
		
		public function getY(){
			return this.y;
		}
		
		public function damage(tier){
			switch (tier){
				case 1:
					health -= 5;
					break;
				case 2:
					health -= 10;
					break;
				case 3:
					health -= 15;
					break;
				case 4:
					health -= 20;
					break;
				case 5:
					health -= 25;
					break;
				case 6: // CHARGE LV1
					health -= 7;
					
					break;
				case 7: // CHARGE LV2
					health -= 12;
					break;
				case 8: // CHARGE LV3
					health -= 20;
					break;
				case 9: // BOMB SHOT
					health -= 10;
					break;
			}
			//trace("Health: "+ health);
		}
		
		public function shootRandomly(num:int = 0){
			var rand:int;
			if (num == 0){
				rand = Math.ceil(Math.random() * 100)
			}
			else{
				rand = Math.ceil(Math.random() * num);
			}
			//trace("RAND " + rand);
			if (rand < 3){
				return true;
			}
			
			return false;
			
		}
		public function getHealth(){
			return health;
		}
		
		public function isBoss(){
			return isboss;
		}
		*/
	}
	
}
