package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class EnemyBullet extends MovieClip {
		
		var initialX:int;
		var initialY:int;
		var targetX:int;
		var targetY:int;
		var speed:int;
		var coords:int; // 0 = topleft of player // 1 = topright 2 = bottlm left 3 = bottom right
		var angle:Number;
		
		public function EnemyBullet() {
			// constructor code
		}
		
		public function startAccurateBullet(ix,iy,px,py,thespeed:int = 0, bulletDir:String = "Player"){
			// On X axis use the cosinus angle
			angle = Math.atan2(py - iy,px - ix);
			speed = thespeed;
			switch(bulletDir){
				case "Player":
					selectBullet(2);
					break;
			}
		}
		
		public function startBullet(ix, iy, px, py, thespeed:int = 0){
			if (thespeed == 0){
				speed = Math.ceil(Math.random() * 3 + 3);
			}
			else{
				speed = thespeed;
			}
			
			initialX = ix;
			initialY = iy;
			targetX = px;
			targetY = py;
			if ((initialX <= targetX - 50) && (initialY <= targetY - 50)){
				coords = 0;
			}
			else if ((initialX > targetX + 50) && (initialY <= targetY - 50)){
				coords = 1;
			}
			else if ((initialX <= targetX - 50) && (initialY > targetY + 50)){
				coords = 2;
			}
			else if ((initialX > targetX + 50) && (initialY > targetY + 50)){
				coords = 3;
			}
			else if ((initialX > targetX - 50) && (initialX <= targetX + 50)){
				if (initialX <= targetY){
					coords = 4;//shoot down
				}
				else if (initialX > targetY){
					coords = 5; //shoot up
				}
			}
			else if ((initialY > targetY - 50) && (initialY <= targetY + 50)){
				if (initialY <= targetX){
					coords = 6; // shoot right
				}
				else if (initialY > targetX){
					coords = 7;
				}
			}
			
			selectBullet(1);
		}
		
		private function selectBullet(id){
			if (id == 1){
				this.addEventListener(Event.ENTER_FRAME,moveBullet);
			}
			else if (id == 2){
				this.addEventListener(Event.ENTER_FRAME,moveAccurateBullet);
			}
		}
		
		private function moveAccurateBullet(e:Event){
			this.x +=  Math.cos(angle) * speed;
		    // On Y axis use the sinus angle
    		this.y +=  Math.sin(angle) * speed;
		}
		
		public function moveBullet(e:Event){
			switch (coords){
				case 0:
					this.x += speed;
					this.y += speed;
					break;
				case 1:
					this.x -= speed;
					this.y += speed;
					break;
				case 2:
					this.x += speed;
					this.y -= speed;
					break;
				case 3:
					this.x -= speed;
					this.y -= speed;
					break;
				case 4:
					this.y += speed;
					break;
				case 5:
					this.y -= speed;
					break;
				case 6:
					this.x += speed;
					break;
				case 7:
					this.y -= speed;
					break;
			}
		}
	}
	
}
