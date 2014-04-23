package  {
	/*
	bullet damage and shooting planning
	TOTAL DPS:
1.5 + 6 + 5 = 16
2.6 + 7 + 6 = 19
3.7 + 8 + 7 = 22
4.1 + 7 + 8 + 7 + 1 = 24
5.3 + 7 + 8 + 7 + 3 = 28
6.5 + 7 + 8 + 7 + 5 = 32
7. same + slow rocket = 32 + 10
8.5 + 8 + 8 + 8 + 5 = 34
9.6 + 8 + 8 + 8 + 6 = 36
10.7 + 8 + 8 + 8 + 7 = 38
11.8 + 8 + 8 + 8 + 8 = 40
12.same + 2 slow rockets =  40 + 20


*/
	import flash.display.Sprite;
	
	public class PlayerShootBullets {

		private var addEntity:AddEntity;
		private var shootingLayer:Sprite;
		private var bullet:Bullet;
		private var bulletArray:Array;
		private var gameData:GameData;
		private var player:Player;

		public function PlayerShootBullets(gd:GameData,addentity:AddEntity, layer:Sprite,player:Player, bullet:Bullet,bulletarray:Array):void {
			gameData = gd;
			addEntity = addentity;
			shootingLayer = layer;
			this.player = player;
			this.bullet = bullet;
			bulletArray = bulletarray;
			switch (gameData.p_AttackRating){
				case 1:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					break;
				case 2:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					break;
				case 3:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					break;	
				case 4:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 19,player.y,shootingLayer,5,-4,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 19,player.y,shootingLayer,5,4,bulletArray);
					break;
				case 5:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 19,player.y,shootingLayer,5,-4,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 19,player.y,shootingLayer,5,4,bulletArray);
					break;
				case 6:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 19,player.y,shootingLayer,5,-4,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 19,player.y,shootingLayer,5,4,bulletArray);
					break;
				case 7:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 19,player.y,shootingLayer,5,-4,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 19,player.y,shootingLayer,5,4,bulletArray);
					break;
				case 8:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 19,player.y,shootingLayer,5,-4,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 19,player.y,shootingLayer,5,4,bulletArray);
					break;
				case 9:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 19,player.y,shootingLayer,5,-4,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 19,player.y,shootingLayer,5,4,bulletArray);
					break;
				case 10:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 19,player.y,shootingLayer,5,-4,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 19,player.y,shootingLayer,5,4,bulletArray);
					break;
				case 11:
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 19,player.y,shootingLayer,5,-4,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 19,player.y,shootingLayer,5,4,bulletArray);
					break;
				default:
					//max 12
					addEntity.callFunction(bullet = new Bullet(gameData),player.x,player.y - 20,shootingLayer,5,0,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 13,player.y - 4,shootingLayer,5,-2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 13,player.y - 4,shootingLayer,5,2,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x - 19,player.y,shootingLayer,5,-4,bulletArray);
					addEntity.callFunction(bullet = new Bullet(gameData),player.x + 19,player.y,shootingLayer,5,4,bulletArray);
					break;
			}
		}
	}
}
/*
public function bulletTimer(e:TimerEvent){
			if (fire){
				//trace("MOUSEDOWN");
				switch(attackRating){
					case 1:
						adjustASpeed(60);//125
						//addEntity(0,-20,0,1);
						addEntity(0,-20,0,1,bullet,"Bullet");
						break;
					case 2:
						adjustASpeed(75);
						addEntity(-13,-4,0,1,bullet,"Bullet");
						addEntity(13,-4,0,1,bullet,"Bullet");
						break;
					case 3:
						adjustASpeed(75);
						addEntity(0,-20,0,1,bullet,"Bullet");
						addEntity(-13,-4,-2,1,bullet,"Bullet");
						addEntity(13,-4,2,1,bullet,"Bullet");
						break;
					case 4:
						adjustASpeed(75);//125
						addEntity(0,-20,0,2,bullet,"Bullet");
						addEntity(-13,-4,-2,1,bullet,"Bullet");
						addEntity(13,-4,2,1,bullet,"Bullet");
						break;
					case 5:
						adjustASpeed(100);
						addEntity(0,-20,0,1,bullet,"Bullet");
						addEntity(-13,-4,-2,2,bullet,"Bullet");
						addEntity(13,-4,2,2,bullet,"Bullet");
						break;
					case 6:
						adjustASpeed(100);//100
						addEntity(0,-20,0,2,bullet,"Bullet");
						addEntity(-13,-4,-2,2,bullet,"Bullet");
						addEntity(13,-4,2,2,bullet,"Bullet");
						break;
					case 7:
						adjustASpeed(100);
						addEntity(0,-20,0,2,bullet,"Bullet");
						addEntity(-13,-4,-2,2,bullet,"Bullet");
						addEntity(13,-4,2,2,bullet,"Bullet");
						addEntity(-19,0,-4,1,bullet,"Bullet");
						addEntity(19,0,4,1,bullet,"Bullet");
						break;
					case 8:
						adjustASpeed(125);
						addEntity(0,-20,0,3,bullet,"Bullet");
						addEntity(-13,-4,-2,2,bullet,"Bullet");
						addEntity(13,-4,2,2,bullet,"Bullet");
						addEntity(-19,0,-4,1,bullet,"Bullet");
						addEntity(19,0,4,1,bullet,"Bullet");
						break;
					case 9:
						adjustASpeed(125);
						addEntity(0,-20,0,3,bullet,"Bullet");
						addEntity(-13,-4,-2,2,bullet,"Bullet");
						addEntity(13,-4,2,2,bullet,"Bullet");
						addEntity(-19,0,-4,2,bullet,"Bullet");
						addEntity(19,0,4,2,bullet,"Bullet");
						break;
					case 10:
						adjustASpeed(125);
						addEntity(0,-20,0,2,bullet,"Bullet");
						addEntity(-13,-4,-2,3,bullet,"Bullet");
						addEntity(13,-4,2,3,bullet,"Bullet");
						addEntity(-19,0,-4,2,bullet,"Bullet");
						addEntity(19,0,4,2,bullet,"Bullet");
						break;
					case 11:
						adjustASpeed(125);
						addEntity(0,-20,0,3,bullet,"Bullet");
						addEntity(-13,-4,-2,3,bullet,"Bullet");
						addEntity(13,-4,2,3,bullet,"Bullet");
						addEntity(-19,0,-4,2,bullet,"Bullet");
						addEntity(19,0,4,2,bullet,"Bullet");
						break;
					/*case 12:
						adjustASpeed(75);
						addEntity(0,-20,0,4,bullet,"Bullet");
						addEntity(-13,-4,-2,3,bullet,"Bullet");
						addEntity(13,-4,2,3,bullet,"Bullet");
						addEntity(-19,0,-4,2,bullet,"Bullet");
						addEntity(19,0,4,2,bullet,"Bullet");
						break;
					case 13:
						adjustASpeed(75);
						//homing front
						addEntity(0,-20,0,4,bullet,"Bullet");
						addEntity(-13,-4,-2,3,bullet,"Bullet");
						addEntity(13,-4,2,3,bullet,"Bullet");
						addEntity(-19,0,-4,2,bullet,"Bullet");
						addEntity(19,0,4,2,bullet,"Bullet");
						break;
					case 14:
						adjustASpeed(75);
						//homing front
						addEntity(0,-20,0,4,bullet,"Bullet");
						addEntity(-13,-4,-2,3,bullet,"Bullet");
						addEntity(13,-4,2,3,bullet,"Bullet");
						addEntity(-19,0,-4,3,bullet,"Bullet");
						addEntity(19,0,4,3,bullet,"Bullet");
						break;
					case 15:
						adjustASpeed(75);
						//homing front
						addEntity(0,-20,0,4,bullet,"Bullet");
						addEntity(-13,-4,-2,4,bullet,"Bullet");
						addEntity(13,-4,2,4,bullet,"Bullet");
						addEntity(-19,0,-4,3,bullet,"Bullet");
						addEntity(19,0,4,3,bullet,"Bullet");
						break;
					case 16:
						adjustASpeed(75);
						//homing front
						addEntity(0,-20,0,5,bullet,"Bullet");
						addEntity(-13,-4,-2,4,bullet,"Bullet");
						addEntity(13,-4,2,4,bullet,"Bullet");
						addEntity(-19,0,-4,3,bullet,"Bullet");
						addEntity(19,0,4,3,bullet,"Bullet");
						break;
					case 17:
						adjustASpeed(75);
						//homing left
						addEntity(0,-20,0,5,bullet,"Bullet");
						addEntity(-13,-4,-2,4,bullet,"Bullet");
						addEntity(13,-4,2,4,bullet,"Bullet");
						addEntity(-19,0,-4,3,bullet,"Bullet");
						addEntity(19,0,4,3,bullet,"Bullet");
						//homing right
						break;
					case 18:
						adjustASpeed(75);
						//homing left
						addEntity(0,-20,0,5,bullet,"Bullet");
						addEntity(-13,-4,-2,4,bullet,"Bullet");
						addEntity(13,-4,2,4,bullet,"Bullet");
						addEntity(-19,0,-4,4,bullet,"Bullet");
						addEntity(19,0,4,4,bullet,"Bullet");
						//homing right
						break;
					case 19:
						adjustASpeed(75);
						//homing left
						addEntity(0,-20,0,4,bullet,"Bullet");
						addEntity(-13,-4,-2,5,bullet,"Bullet");
						addEntity(13,-4,2,5,bullet,"Bullet");
						addEntity(-19,0,-4,4,bullet,"Bullet");
						addEntity(19,0,4,4,bullet,"Bullet");
						//homing right
						break;
					case 20:
						//homing left
						adjustASpeed(75);
						addEntity(0,-20,0,5,bullet,"Bullet");
						addEntity(-13,-4,-2,5,bullet,"Bullet");
						addEntity(13,-4,2,5,bullet,"Bullet");
						addEntity(-19,0,-4,4,bullet,"Bullet");
						addEntity(19,0,4,4,bullet,"Bullet");
						//homing right
						break;
					case 21:
						adjustASpeed(60);
						//addEntity(-19,0,-35,4);//homing left
						addEntity(0,-20,0,5,bullet,"Bullet");
						addEntity(-13,-4,-2,5,bullet,"Bullet");
						addEntity(13,-4,2,5,bullet,"Bullet");
						addEntity(-19,0,-4,5,bullet,"Bullet");
						addEntity(19,0,4,5,bullet,"Bullet");
						//addEntity(19,0,35,4);//homing right
						break;
						
				}
			}
		}
*/