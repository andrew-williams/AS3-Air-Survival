package  {
	import flash.display.MovieClip;
	
	public class statusEffect extends MovieClip{

		public function statusEffect() {}
		
		public function CheckStatus(){
			if (this.currentFrame == 2){
				if (this.powerDown.currentFrame == this.powerDown.totalFrames){
					this.gotoAndStop(1);
				}
			}
		}

	}
	
}
