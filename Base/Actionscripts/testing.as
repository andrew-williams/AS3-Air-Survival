package  {
	import flash.display.Sprite;
	
	public class testing {

		private var leonsCircle:produceMana;
		private var stageParent:Sprite;
		
		public function testing(sParent) {
			// constructor code
			stageParent = sParent;
			leonsCircle = new produceMana();
		}
		
		public function produceElements(color){
			leonsCircle.produceElement(stageParent,color);
		}

	}
	
}
