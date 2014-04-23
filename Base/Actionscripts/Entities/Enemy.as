package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Enemy extends MovieClip {
		
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
		
	}
	
}
