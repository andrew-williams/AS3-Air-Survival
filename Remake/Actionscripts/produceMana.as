package  {
	import flash.display.MovieClip;
	
	public class produceMana extends MovieClip{

		private var orb:circleLALA;		

		public function produceMana() {
			// constructor code
		}
		
		public function produceElement(sParent,sElementColor){
			orb = new circleLALA();
			orb.x = Math.ceil(Math.random() * 300);
			orb.y = Math.ceil(Math.random() * 300);
			if(sElementColor == 1){orb.gotoAndStop(1);}
			if(sElementColor == 2){orb.gotoAndStop(2);}
			if(sElementColor == 3){orb.gotoAndStop(3);}
			if(sElementColor == 4){orb.gotoAndStop(4);}
			if(sElementColor == 5){orb.gotoAndStop(5);}
			this.addChild(orb);
			sParent.addChild(this);
			trace("TEST");
		}

	}
	
}
