package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Player extends MovieClip {
		
		private var moveLeft:Boolean = false;
		private var moveRight:Boolean = false;
		private var moveUp:Boolean = false;
		private var moveDown:Boolean = false;
		private var sX:int;
		private var sY:int;
		private var sXT:int;
		private var sYT:int;
		private var life:int = 3;
		private var health = 100;
		private var respawn:Timer;
		public function Player(stageX, stageY, stageXT, stageYT) {
			// constructor code
			sX = stageX;
			sY = stageY;
			sXT = stageXT;
			sYT = stageYT;
			this.addEventListener(Event.ENTER_FRAME,movePlayer);
		}
		
		public function getHealth(){
			return health;
		}
		public function gainHealth(amount){
			health += amount;
		}
		public function loseHealth(amount){
			health -= amount;
		}
		public function setHealth(amount){
			health = amount;
		}
		
		public function getlife(){
			return life;
		}
		
		public function gainlife(amount){
			life += amount;
		}
		
		public function loselife(amount){
			life -= amount;
		}
		
		public function setlife(amount){
			life = amount;
		}
		public function keydown(e:KeyboardEvent){
			switch(e.keyCode){
				case Keyboard.LEFT:
					moveLeft = true;
					break;
				case Keyboard.RIGHT:
					moveRight = true;
					break;
				case Keyboard.UP:
					moveUp = true;
					break;
				case Keyboard.DOWN:
					moveDown = true;
					break
			}
		}
		
		public function keyup(e:KeyboardEvent){
			switch(e.keyCode){
				case Keyboard.LEFT:
					moveLeft = false;
					break;
				case Keyboard.RIGHT:
					moveRight = false;
					break;
				case Keyboard.UP:
					moveUp = false;
					break;
				case Keyboard.DOWN:
					moveDown = false;
					break
			}
		}

		public function movePlayer(e:Event){
			if (moveLeft){
				this.x -= 12;
				
			}
			if (moveRight){
				this.x += 12;
				
			}
			if (moveDown){
				this.y += 12;
				
			}
			if (moveUp){
				this.y -= 12;
				
			}

			if (this.x < sXT + this.width/2){
					this.x = sXT + this.width/2;
				}
			if (this.x > (sX - this.width / 2)){
					this.x = sX - this.width / 2;
				}
			if (this.y > (sY - this.width/2)){
					this.y = sY - this.width/2;
				}
			if (this.y < sYT + this.width/2){
					this.y = sYT + this.width/2;
				}
			
		}
		
		public function killandrespawn(){
			respawn = new Timer(1000,5);
			respawn.addEventListener(TimerEvent.TIMER,counting);
			respawn.addEventListener(TimerEvent.TIMER_COMPLETE,respawnme);
			respawn.start();
			this.removeEventListener(Event.ENTER_FRAME,movePlayer);
			this.x = 9999;
			this.y = 9999;
		}
		
		public function respawnme(e:TimerEvent){
			health = 100;
			respawn.removeEventListener(TimerEvent.TIMER,counting);
			respawn.removeEventListener(TimerEvent.TIMER_COMPLETE,respawnme);
			this.x = sX / 2;
			this.y = sY - this.width/2;
			this.addEventListener(Event.ENTER_FRAME,movePlayer);
		}
		
		public function counting(e:TimerEvent){

		}
		
		public function endGame(){
			this.removeEventListener(Event.ENTER_FRAME,movePlayer);
			this.x = 9999;
			this.y = 9999;
		}
		
		
	}
	
}
