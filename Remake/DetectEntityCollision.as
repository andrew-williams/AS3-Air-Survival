package  {
	import flash.display.Sprite;
	
	public class DetectEntityCollision {

		private var gameData:GameData;
		private var removeEntity:RemoveEntity;

		public function DetectEntityCollision(gd:GameData, re:RemoveEntity):void{
			gameData = gd;
			removeEntity = re;
		}
		
		public function EntityToEntity(tEntityOne,tEntityTwo,entity:String,layer:Sprite,eArrayOne:Array = null,eArrayTwo:Array = null):void{
			//bullet to enemy
			switch (entity){
				case "BulletToEnemy":
					for each (var bullet:Bullet in eArrayOne){
						for each (var enemy:Enemy in eArrayTwo){
							if (enemy.hitTestObject(bullet)){
								enemy.TakeDamage(1);
								bullet.SetDelete();
							}
						}
					}
					break;
			}
			
		}
		
		public function CallFunction(touchingEntity, entity:String, layer:Sprite, entityArray:Array = null, statuseffect:statusEffect = null):void{
			switch (entity){
				case "Powerup":
					for each (var powerups:PowerupHandler in entityArray){
						if (touchingEntity.hitTestObject(powerups)){
							removeEntity.callFunction(powerups,layer,entityArray);
							switch(powerups.currentFrame){
								case 1: // Bomb
									gameData.p_Bomb++;
									gameData.p_Score += 25000 + (1000 * gameData.currentLevel);
									if (gameData.p_Bomb > 9){
										gameData.p_Bomb = 9;
									}
									break;
								case 2: // Charge
									gameData.p_Charge += 100;
									gameData.p_Score += 250000;
									if (gameData.p_Charge > 1000){
										gameData.p_Charge = 1000;
									}
									break;
								case 3: // Firepower
									gameData.p_AttackRating++;
									gameData.p_Score += gameData.p_AttackRating * (gameData.currentLevel * 500);
									if (gameData.p_AttackRating > 12){//21
										gameData.p_AttackRating = 12;//21
									}
									break;
								case 4: // Life
									gameData.p_Life++;
									gameData.p_Score += 250000;
									if (gameData.p_Life > 9){
										gameData.p_Life = 9;
									}
									break;
								case 5: // Repair
									gameData.p_Health += 50;
									gameData.p_Score += 100000;
									if (gameData.p_Health > 200){
										gameData.p_Health = 200;
									}
									break;
								case 6: // Score
									gameData.p_Score += 5000 + (500 * gameData.currentLevel);
									break;
							}
							if (gameData.p_Score > 2147000000){
								gameData.p_Score = 2147000000;
							}
						}
					}
					break;
				case "Enemy":
					for each (var enemy:Enemy in entityArray){
						if (touchingEntity.hitTestObject(enemy)){
							//IF NOT CHARGE LEVEL 3
							if (statuseffect.currentFrame == 1){
								statuseffect.gotoAndStop(2);
								if (gameData.p_AttackRating > 1){
									gameData.p_AttackRating -= gameData.p_AttackRating / 4;
								}
							}
						}
					}
					break;
			}
		}

	}
	
}
/*
public function entityCollisionCheck(entity,touchingentity){
			
				/*
				case "Enemy Bullet":
					for each (var w:EnemyBullet in enemyBulletArray){
						if (touchingentity.hitTestObject(w)){
							w.x = 6000;
							w.y = 6000;
							player.loseHealth(10);
							if (player.getHealth() <= 0){
								if (player.getlife() > 0){
									chargeRating = 0;
									dropItems(player.x,player.y,"Player");
									player.loselife(1);
									player.killandrespawn();
									
								}
								else if (player.getlife() <= 0){
									chargeRating = 0;
									player.endGame();
									gameTime.repeatCount = gameTime.currentCount + 1;
									gameTime.delay = 1;
								}
							}
							chargeBar();

						}
					}
					break;
				case "BombShot":
					if(touchingentity.currentFrame == 3){
						for each (var f:Enemy in enemyArray){
							if (touchingentity.hitTestObject(f)){
								f.damage(9);
								if ((f.getHealth() <= 0)&&(!f.isBoss())){
									destroyEntity(f,"Boss");
								}
								else if ((f.getHealth() <= 0) && (f.isBoss())){
									trace("Killed Boss");
									destroyEntity(f,"Boss");
									endGame();
								}
							}
						}
						for each (var g:EnemyBullet in enemyBulletArray){
							if (touchingentity.hitTestObject(g)){
								destroyEntity(g,"Enemy Bullet");
							}
						}
					}
					break;
				
					
			}
		}*/