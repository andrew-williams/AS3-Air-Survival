package  {
	import flash.display.MovieClip;
	
	public class Hud extends MovieClip{

		private var gameData:GameData;

		public function Hud(gd:GameData) {
			gameData = gd;
		}
		
		public function setHud(){
			this.txtScore.text = gameData.p_Score.toString();
			this.txtBomb.text = gameData.p_Bomb.toString();
			this.txtLife.text = gameData.p_Life.toString();
			if (gameData.p_Health < 0){
				gameData.p_Health = 0;
			}
			this.txtHealth.text = gameData.p_Health.toString();
			UpdateHPBar();
			this.txtCharge.text = gameData.p_Charge.toString();
			UpdateChargeBar();
			this.txtAttackRating.text = gameData.p_AttackRating.toString();
			this.txtTime.text = gameData.seconds.toString();
			
		}
		
		private function UpdateHPBar(){
			if (gameData.p_Health >= 100){
				this.hudHPbar.width = 455;
			}
			else if ((gameData.p_Health >= 0) && (gameData.p_Health < 100)){
				this.hudHPbar.width = 455 * (gameData.p_Health / 100);
			}
			else{
				this.hudHPbar.width = 0;
			}
		}
		
		private function UpdateChargeBar(){
			if (gameData.p_Charge >= 1000){
				this.hudChargeBar.width = 455;
				this.hudChargeBar.gotoAndStop(4);
			}
			else if ((gameData.p_Charge >= 0) && (gameData.p_Charge < 1000)){
				this.hudChargeBar.width = 455 * (gameData.p_Charge / 1000);
				if (gameData.p_Charge < 150){
					this.hudChargeBar.gotoAndStop(1);
				}
				else if ((gameData.p_Charge >= 150) && (gameData.p_Charge < 400)){
					this.hudChargeBar.gotoAndStop(2);
				}
				else if ((gameData.p_Charge >= 400) && (gameData.p_Charge < 1000)){
					this.hudChargeBar.gotoAndStop(3);
				}
			}
			else{
				this.hudChargeBar.gotoAndStop(1);
				this.hudChargeBar.width = 0;
			}
		}
	}
	
}
