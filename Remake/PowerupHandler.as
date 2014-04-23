package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	// REMAKE THIS
	
	public class PowerupHandler extends MovieClip {
		
		private var moveLeft:Boolean = false;
		private var moveRight:Boolean = false;
		private var moveDown:Boolean = false;
		private var moveUp:Boolean = false;
		private var sX:int;
		private var sY:int;
		private var sXT:int;
		private var sYT:int;
		private var xSpeed:int;
		private var ySpeed:int;
		
		public function PowerupHandler(stageX, stageY, stageXT, stageYT) {
			// constructor code
			sX = stageX;
			sY = stageY;
			sXT = stageXT;
			sYT = stageYT;
			var temp:int = 0;
			temp = Math.ceil(Math.random() * 8);
			xSpeed = Math.ceil(Math.random() * 6 + 2);
			ySpeed = Math.ceil(Math.random() * 6 + 2);
			switch (temp){
				case 1:
					//moveLeft = true;
					//break;
				case 2:
					moveLeft = true;
					moveUp = true;
					break;
				case 3:
					//moveUp = true;
					//break;
				case 4:
					moveUp = true;
					moveRight = true;
					break;
				case 5:
					//moveRight = true;
					//break;
				case 6:
					moveRight = true;
					moveDown = true;
					break;
				case 7:
					//moveDown = true;
					//break;
				case 8:
					moveDown = true;
					moveLeft = true;
					break;
			}
			//this.addEventListener(Event.ENTER_FRAME,Update,false,0,true);
		}
		
		public function Update(e:Event){
			if (moveLeft){
				this.x -= xSpeed;
				if (this.x < sXT){
					moveLeft = false;
					moveRight = true;
				}
			}
			else if (moveRight){
				this.x += xSpeed;
				if (this.x > (sX - this.width)){
					moveRight = false;
					moveLeft = true;
				}
			}
			if (moveDown){
				this.y += ySpeed;
				if (this.y > (sY - this.height)){
					moveDown = false;
					moveUp = true;
				}
			}
			else if (moveUp){
				this.y -= ySpeed;
				if (this.y < sYT){
					moveUp = false;
					moveDown = true;
				}
			}
		}

	}
	
}

