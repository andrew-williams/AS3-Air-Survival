package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bullet extends MovieClip{
		
		private var gameData:GameData;
		private var canDelete:Boolean;

		public function Bullet(gd:GameData) : void {
			gameData = gd;
			canDelete = false;
		}
		
		public function Update(e:Event):void{
			MoveBullet();
			CheckOOB();
		}
		
		private function MoveBullet(){
			this.y -= 65;
			switch (this.rotation){
				case -35:
					this.x -= 40; //65 * Math.cos(40);
					break;
				case -4:
					this.x -= 2;
					break;
				case -2:
					this.x -= 1;
					break;
				case 2:
					this.x += 1;
					break;
				case 4:
					this.x += 2;
					break;
				case 35:
					this.x += 40;//65 * Math.cos(40);
					break;
			}
		}
		private function CheckOOB():void{
			if (this.x < (gameData.stageWt - 100)){
				SetDelete();
			}
			else if (this.x > (gameData.stageW + 100)){
				SetDelete();
			}
			if (this.y < (gameData.stageHt - 100)){
				SetDelete();
			}
			else if (this.y > (gameData.stageH + 100)){
				SetDelete();
			}
		}
		public function SetDelete():void{
			canDelete = true;
		}
		
		public function CanDelete():Boolean{
			return canDelete;
		}
	}
	
}
