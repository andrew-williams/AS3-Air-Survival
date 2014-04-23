package  {
	
	/*
	Notes:
	Background: make bg
	Powerups: do charge sprite
	Charge: do charge level 2 and level 3 beam sprite, code level 3 bullet breaker
	Drops: Set up drop rates that are balanced
	Bomb: code ENTIRE bomb and sprite
	Bullets: code and sprite homing bullets/container
	
	THEN DO ENEMIES AND BOSSES ATTACK/MOVEMENT SO HARD

	*/
	import flash.display.MovieClip;
	//import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	//import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Game extends Screen{
		private var document;
		
		private var bombshot:bombSkill;
		private var pHitTest:playerHitArea;
		
		var screenParent:Screen;
		var menuTime:Timer;
		var player:Player;
		var bombCounter:int = 0;
		var attackRating:int = 1;
		var scoreCounter:int = 0;
		var chargeRating:int = 0;
		var chargeLevel:int = 0;
		var enemy:Enemy;
		var enemyArray:Array = new Array();
		var frontLayer:Sprite = new Sprite();
		var hud:Hud;
		var bullet:Bullet;
		var bulletArray:Array = new Array();
		var backdrop:Backdrop;
		var statuseffect:statusEffect;
		var enemybullet:EnemyBullet;
		var enemyBulletArray:Array = new Array();
		var powerup:powerupHandler;
		var powerupArray:Array = new Array();
		
		var stageWt:int = 5;
		var stageW:int = 605;
		var stageHt:int = 49;
		var stageH:int = 849;
		var fire:Boolean = false;
		
		var interval:int = 0;
		var seconds:int = 0;
		var gameTime:Timer;
		var bulletTime:Timer;
		
		var chargeShot:ChargePointer;
		var chargeActive:Boolean = false;
		var chargeTimer:Timer;
		var chargeTimerInterval:int = 0;
		
		var level:int = 1;

		// 
		/////////////////////////////////////////////////////////////////////
		// DEBUG FUNCTIONS
		//DEBUG
		public function debug(){
		
			//trace("Enemy Array: " + enemyArray.length);
			//trace("Bullet Array: " + bulletArray.length);
			//trace("Powerup Array: " + powerupArray.length);
			//trace("Enemy Bullet Array: " + enemyBulletArray.length);
		}
		// DEBUG FUNCTIONS
		/////////////////////////////////////////////////////////////////////
		// INPUT EVENT FUNCTIONS
		//INPUT
		
		public function keyrelease(k:KeyboardEvent){
			
			switch (k.keyCode){
				case Keyboard.LEFT:
					player.keyup(k);
					player.gotoAndStop(1);
					break;
				case Keyboard.UP:
					player.keyup(k);
					break;
				case Keyboard.RIGHT:
					player.keyup(k);
					player.gotoAndStop(1);
					break;
				case Keyboard.DOWN:
					player.keyup(k);
					break;
				case Keyboard.X:
					fire = false;
					break;
				case Keyboard.ESCAPE:
					trace("Force Quit");
					endGame();
					player.endGame();
					gameTime.stop();
					
					break;
			}
		}
		
		public function keys(k:KeyboardEvent){
			switch (k.keyCode){
				case Keyboard.LEFT:
					player.keydown(k);
					player.gotoAndStop(2);
					break;
				case Keyboard.UP:
					player.keydown(k);
					break;
				case Keyboard.RIGHT:
					player.keydown(k);
					player.gotoAndStop(3);
					break;
				case Keyboard.DOWN:
					player.keydown(k);
					break;
				case Keyboard.SPACE:
					if ((!chargeActive) && (chargeRating > 150)){
						if ((chargeRating >= 150) && (chargeRating < 400)){
							chargeLevel = 1;
						}
						else if ((chargeRating >= 400) && (chargeRating < 1000)){
							chargeLevel = 2; 
						}
						else if (chargeRating == 1000){
							chargeLevel = 3; 
						}
						chargeRating = 0;
						chargeBar();
						chargeActive = true;
						chargeShot.gotoAndStop(2);

						chargeTimer = new Timer (1000, 5);
						chargeTimer.addEventListener(TimerEvent.TIMER,chargeFunction);
						chargeTimer.addEventListener(TimerEvent.TIMER_COMPLETE,chargeDone);
						chargeTimer.start();
					}
					break;
				case Keyboard.NUMBER_1:
					addEntity(Math.ceil(Math.random() * stageW),Math.ceil(Math.random() * stageH),0,1,powerup,"Powerup");
					break;
				case Keyboard.NUMBER_2:
					addEntity(Math.ceil(Math.random() * stageW),Math.ceil(Math.random() * stageH),0,2,powerup,"Powerup");
					break;
				case Keyboard.NUMBER_3:
					addEntity(Math.ceil(Math.random() * stageW),Math.ceil(Math.random() * stageH),0,3,powerup,"Powerup");
					break;
				case Keyboard.NUMBER_4:
					addEntity(Math.ceil(Math.random() * stageW),Math.ceil(Math.random() * stageH),0,4,powerup,"Powerup");
					break;
				case Keyboard.NUMBER_5:
					addEntity(Math.ceil(Math.random() * stageW),Math.ceil(Math.random() * stageH),0,5,powerup,"Powerup");
					break;
				case Keyboard.NUMBER_6:
					addEntity(Math.ceil(Math.random() * stageW),Math.ceil(Math.random() * stageH),0,6,powerup,"Powerup");
					break;
				case Keyboard.NUMBER_7:
					addEntity(Math.ceil(Math.random() * stageW),-25,0,1,enemy,"Enemy");
					break;
				case Keyboard.X:
					fire = true;
					break;
				case Keyboard.Z:
					if ((bombshot.isBombActive() == false) && (bombCounter > 0)){
						bombCounter--;
						bombshot.x = player.x;
						bombshot.y = player.y;
						bombshot.activateBomb();
					}
					break;
			}
		}
		
		public function chargeFunction(e:TimerEvent){
			
		}
		
		public function chargeDone(e:TimerEvent){
			chargeShot.gotoAndStop(1);
			chargeActive = false;
			chargeTimer.removeEventListener(TimerEvent.TIMER,chargeFunction);
			chargeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,chargeDone);
		}
		
		public function mouseMovement(m:MouseEvent){
			player.x = m.stageX;
			player.y = m.stageY;
		}
		
		public function mouseclick(m:MouseEvent){
			fire = true;
		}
		
		public function mouseup(m:MouseEvent){
			fire = false;
		}
		
		public function rightclick(m:MouseEvent){
			//dropItems(Math.ceil(Math.random() * stageW),Math.ceil(Math.random() * stageH));
		}
		
		// INPUT EVENT FUNCTIONS
		/////////////////////////////////////////////////////////////////////
		// ENTITY FUNCTIONS
		//ENTITY
		
		public function addEntity(xloc, yloc, rot, frame, object, entity:String){
			switch (entity){
				case "Powerup":
					if (powerupArray.length < 5){
					object = new powerupHandler(stageW,stageH,stageWt,stageHt);
					object.x = xloc;
					object.y = yloc;
					object.gotoAndStop(frame);
					entityBorderCollision(object,"Topleft");
					this.addChild(object);
					powerupArray.push(object);
					}
					break;
				case "Background":
					object = new Backdrop();
					object.x = xloc;
					object.y = yloc;
					object.width = stageW;
					object.height = stageH;
					this.addChild(object);
					break;
				case "Bullet":
					object = new Bullet();
					object.x = player.x + xloc;
					object.y = player.y + yloc; 
					object.rotation = rot;
					object.gotoAndStop(frame);
					this.addChild(object);
					bulletArray.push(object);
					break;
				case "Enemy Bullet":
					object = new EnemyBullet();
					object.x = xloc;
					object.y = yloc; 
					object.rotation = rot;
					object.gotoAndStop(frame);
					object.startBullet(xloc,yloc,player.x,player.y);
					this.addChild(object);
					enemyBulletArray.push(object);
					break;
				case "Enemy Bullet Boss":
					object = new EnemyBullet();
					object.x = xloc;
					object.y = yloc; 
					object.rotation = rot;
					object.gotoAndStop(frame);
					object.startAccurateBullet(xloc,yloc,player.x,player.y,8);
					this.addChild(object);
					enemyBulletArray.push(object);
					break
				case "Hud":
					object.x = xloc;
					object.y = yloc;
					this.addChild(object);
					break;
				case "Enemy":
					if (enemyArray.length < 25){
					object = new Enemy(stageW, stageH, stageWt, stageHt);
					object.x = xloc;
					object.y = yloc;
					//object.width = 100;
					//object.height = 200;
					entityBorderCollision(object,"Center");
					object.startMovement();
					this.addChild(object);
					enemyArray.push(object);
					}
					break;
				case "Enemy Boss":
					object = new Enemy(stageW,stageH,stageWt,stageHt,"Boss Test");
					object.x = xloc;
					object.y = yloc;
					object.startBossMovement();
					this.addChild(object);
					enemyArray.push(object);
					break;
				case "No Array":
					object.x = xloc;
					object.y = yloc;
					entityBorderCollision(object,"Topleft");
					this.addChild(object);
					break;
				
			}
		}
		
		public function entityBorderCollision(object,hotspot:String){
			switch(hotspot){
				case "Topleft":
					if (object.x < stageWt){
						object.x = stageWt;
					}
					else if (object.x > (stageW - object.width)){
						object.x = stageW - object.width;
					}
			
					if (object.y < stageHt){
						object.y = stageHt;
					}
					else if (object.y > (stageH - object.height)){
						object.y = stageH - object.height;
					}
					break;
				case "Center":
					if (object.x < (object.width / 2 + stageWt)){
						object.x = object.width / 2 + stageWt;
					}
					else if (object.x > (stageW - object.width / 2)){
						object.x = stageW - object.width / 2;
					}
					if (object.y < (object.height / 2 + stageHt)){
						object.y = object.height / 2 + stageHt;
					}
					else if (object.y > (stageH - object.height)){
						object.y = stageH - object.height / 2;
					}
					break;
			}
		}
		
		// ENTITY ADD FUNCTIONS
		/////////////////////////////////////////////////////////////////////
		// TIMER FUNCTIONS
		//TIMER
		public function gameTimer(e:TimerEvent){
			debug();
			if (interval == 0){
				if (enemyArray.length < 20){
					addEntity(Math.ceil(Math.random() * stageW),-25,0,1,enemy,"Enemy");
				}
				//interval = Math.ceil(Math.random() * 8 + 2);
				interval = 1;
			}
			interval--;
			seconds++;
		}
		
		public function menuTimer(e:TimerEvent){
			menuTime.removeEventListener(TimerEvent.TIMER_COMPLETE,menuTimer);
			document.setMusicAndPlay(musicHandler.TITLE);
			dispatchEvent(new Event(Screen.END));
		}
		
		public function gameOver(e:TimerEvent){
			//trace("Timer Ended");
			//document.stopMusic();
			document.setMusicAndPlay(musicHandler.BOSS,1000);
			gameTime.removeEventListener(TimerEvent.TIMER,gameTimer);
			gameTime.removeEventListener(TimerEvent.TIMER_COMPLETE,gameOver);
			//stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMovement);
			//stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseclick);
			//stage.removeEventListener(MouseEvent.MOUSE_UP,mouseup);
			////////stage.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN,rightclick);
			gameTime = new Timer(5000, 1);
			gameTime.addEventListener(TimerEvent.TIMER_COMPLETE,bossFight);
			gameTime.start();
			//endGame();
		}
		
		private function bossFight(e:TimerEvent){
			gameTime.removeEventListener(TimerEvent.TIMER_COMPLETE,bossFight);
			
			addEntity((stageW / 2),-100,0,2,enemy,"Enemy Boss");
		}
		
		private function endGame(){
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,keys);
			stage.removeEventListener(KeyboardEvent.KEY_UP,keyrelease);
			bulletTime.removeEventListener(TimerEvent.TIMER,bulletTimer);
			player.endGame();
			this.removeChild(player);
			hud.txtTime.text = "Game Over";
			menuTime = new Timer(1000,5);
			menuTime.addEventListener(TimerEvent.TIMER_COMPLETE, menuTimer);
			menuTime.start();
		}
		
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
						*/
				}
			}
		}
		// TIMER FUNCTIONS
		/////////////////////////////////////////////////////////////////////
		// EVENT FUNCTIONS
		//EVENT
		public function hpBar(){
			if (player.getHealth() >= 100){
				hud.hudHPbar.width = 455;
			}
			else if ((player.getHealth() >= 0) && (player.getHealth() < 100)){
				hud.hudHPbar.width = 455 * (player.getHealth() / 100);
			}
			else{
				hud.hudHPbar.width = 0;
			}
		}
		public function chargeBar(){
			if (chargeRating >= 1000){
				hud.hudChargeBar.width = 455;
				hud.hudChargeBar.gotoAndStop(4);
			}
			else if ((chargeRating >= 0) && (chargeRating < 1000)){
				hud.hudChargeBar.width = 455 * (chargeRating / 1000);
				if (chargeRating < 150){
					hud.hudChargeBar.gotoAndStop(1);
				}
				else if ((chargeRating >= 150) && (chargeRating < 400)){
					hud.hudChargeBar.gotoAndStop(2);
				}
				else if ((chargeRating >= 400) && (chargeRating < 1000)){
					hud.hudChargeBar.gotoAndStop(3);
				}
			}
			else{
				hud.hudChargeBar.gotoAndStop(1);
				hud.hudChargeBar.width = 0;
			}
		}
		public function setHud(){
			hud.txtScore.text = scoreCounter.toString();
			hud.txtBomb.text = bombCounter.toString();
			hud.txtLife.text = player.getlife().toString();
			if (player.getHealth() < 0){
				player.setHealth(0);
			}
			hud.txtHealth.text = player.getHealth().toString();
			hpBar();
			hud.txtCharge.text = chargeRating.toString();
			hud.txtAttackRating.text = attackRating.toString();
			hud.txtTime.text = seconds.toString();
			addEntity(0,0,0,1,frontLayer,"Hud");
			
		}
		
		public function entityCollisionCheck(entity,touchingentity){
			switch (entity){
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
				case "Enemy":
					for each (var x:Enemy in enemyArray){
						if (touchingentity.hitTestObject(x)){
							//IF NOT CHARGE LEVEL 3
							if (statuseffect.currentFrame == 1){
								statuseffect.gotoAndStop(2);
								if (attackRating > 1){
									attackRating -= attackRating / 4;
								}
							}
						}
					}
					break;
				case "Powerup":
					for each (var z:powerupHandler in powerupArray){
						if (touchingentity.hitTestObject(z)){
							destroyEntity(z,"Powerup");
							switch(z.currentFrame){
								case 1:
									bombCounter++;
									scoreCounter += 25000 + (1000 * level);
									if (bombCounter > 9){
										bombCounter = 9;
									}
									break;
								case 2://charge
									chargeRating += 100;
									scoreCounter += 250000;
									if (chargeRating > 1000){
										chargeRating = 1000;
									}
									chargeBar();
									break;
								case 3://fire
									attackRating++;
									scoreCounter += attackRating * (level * 500);
									if (attackRating > 11){//21
										attackRating = 11;//21
									}
									break;
								case 4://life
									player.gainlife(1);
									scoreCounter += 250000;
									if (player.getlife() > 9){
										player.setlife(9);
									}
									break;
								case 5://repair
									player.gainHealth(50);
									scoreCounter += 100000;
									if (player.getHealth() > 200){
										player.setHealth(200);
									}
									break;
								case 6://score
									scoreCounter += 5000 + (500 * level);
									break;
							}
							if (scoreCounter > 2147000000){
								scoreCounter = 2147000000;
							}
						}
					}
					break;
			}
		}
		
		public function entityCheckIfOffScreen(object,objectArray:String){
				switch (objectArray){
					case "Bullet":
						if (object.y < 0){
							destroyEntity(object,"Bullet");
						}
						break;
					case "Enemy Bullet":
						if (object.y < -50){
							object.x = 5000;
						}
						if (object.y > stageH + 50){
							object.x = 5000;
						}
						if (object.x < -50){
							object.x = 5000;
						}
						if (object.x > stageW + 50){
							object.x = 5000;
						}
						if (object.x > 4500){
							destroyEntity(object,"Enemy Bullet");
						}
						break;
					case "Enemy":
							if (object.y > stageH + 50){
								destroyEntity(object,"Boss",false);
							}
							
						break;
				}
		}
		
		public function calculateCharge(enemytype,playerkilled:Boolean = true){
			var value1:int;
			var value2:int;
			var value3:int;
			switch (enemytype){
				case "Boss":
					value1 = 16;
					value2 = 8;
					value3 = 4;
					break;
				case "Enemy":
					value1 = 4;
					value2 = 2;
					value3 = 1;
					break;
				case "Miniboss":
					value1 = 8;
					value2 = 4;
					value3 = 2;
					break;
				default:
					value1 = 88;
					value2 = 88;
					value3 = 88;
					
			}
			if (chargeRating < 150){
					chargeRating += value1;
			}
			else if ((chargeRating >= 150) && (chargeRating < 400)){
				chargeRating += value2;
			}
			else if ((chargeRating >= 400) && (chargeRating < 1000)){
				chargeRating += value3;
			}
			chargeBar();
		}
		
		
		public function destroyEntity(object,objectArray:String, includeItem:Boolean = true){
			
			switch (objectArray){
				case "Bullet":
					bulletArray.splice(bulletArray.indexOf(object),1);
					this.removeChild(object);
					break;
				case "Enemy Bullet":
					enemyBulletArray.splice(enemyBulletArray.indexOf(object),1);
					this.removeChild(object);
					break;
				case "Powerup":
					powerupArray.splice(powerupArray.indexOf(object),1);
					this.removeChild(object);
					break;
				case "Boss":
					if (includeItem){
						dropItems(object.x,object.y,"Test");
						dropItems(object.x,object.y,"Test");
						dropItems(object.x,object.y,"Test");
						dropItems(object.x,object.y,"Test");
						dropItems(object.x,object.y,"Test");
						calculateCharge("Boss");
						scoreCounter += 200000 * level;
					}
					enemyArray.splice(enemyArray.indexOf(object),1);
					this.removeChild(object);
					
					break;
				case "Enemy":
					if (includeItem){
						dropItems(object.x,object.y);
						calculateCharge("Enemy");
					}
					enemyArray.splice(enemyArray.indexOf(object),1);
					this.removeChild(object);
					scoreCounter += 1000;
					break;
			}
		}

		public function dropItems(centerX, centerY, droptable:String = "default"){
			var temp : int;
			var type : int = 3;//Default firepower
			temp = Math.ceil(Math.random() * 100);
			//GENERAL DROP TABLE TEST 1=bomb 2=charge 3=firepower 4=life 5=repair 6=score
			switch (droptable){
				case "Player":
					type = 0;
					for (var count:int = 0; count < attackRating / 3; count++){
						if (attackRating != 1){
							addEntity((centerX - 8) + Math.ceil(Math.random() * 16),(centerY - 8) + Math.ceil(Math.random() * 16),0,3,powerup,"Powerup");
						}
					}
					if ((bombCounter > 3) && (bombCounter <= 6)){
						addEntity((centerX - 8) + Math.ceil(Math.random() * 16),(centerY - 8) + Math.ceil(Math.random() * 16),0,1,powerup,"Powerup");
					}
					else if (bombCounter > 6){
						addEntity((centerX - 8) + Math.ceil(Math.random() * 16),(centerY - 8) + Math.ceil(Math.random() * 16),0,1,powerup,"Powerup");
						addEntity((centerX - 8) + Math.ceil(Math.random() * 16),(centerY - 8) + Math.ceil(Math.random() * 16),0,1,powerup,"Powerup");
					}
					bombCounter = 0;
					attackRating = 1;
					break;
				case "Test":
					if ((temp > 0) && (temp <= 1)) {
						type = 1;
					}
					else if ((temp > 1) && (temp <= 2)) {
						type = 2;
					}
					else if ((temp > 2) && (temp <= 3)) {
						type = 6;
					}
					else if ((temp > 3) && (temp <= 4)) {
						type = 4;
					}
					else if ((temp > 4) && (temp <= 5)) {
						type = 5;
					}
					else if ((temp > 5) && (temp <= 10)) {
						type = 3;
					}
					else {
						type = 0;
					}
					break;
				case "Boss":
					if ((temp > 0) && (temp <= 2)) {
						type = 4;
					}
					else if ((temp > 2) && (temp <= 7)) {
						type = 1;
					}
					else if ((temp > 7) && (temp <= 12)) {
						type = 3;
					}
					else if ((temp > 12) && (temp <= 22)) {
						type = 6;
					}
					else{
						type = 0;
					}
					break;
				default:
					if ((temp > 0) && (temp <= 14)) {
						type = 1;
					}
					else if ((temp > 14) && (temp <= 28)) {
						type = 2;
					}
					else if ((temp > 28) && (temp <= 42)) {
						type = 3;
					}
					else if ((temp > 42) && (temp <= 56)) {
						type = 4;
					}
					else if ((temp > 56) && (temp <= 70)) {
						type = 5;
					}
					else if ((temp > 70) && (temp <= 84)) {
						type = 6;
					}
					else if ((temp > 84) && (temp <= 100)) {
						type = 0;
					}
					break;
			}
			if (type != 0){
				addEntity((centerX - 8) + Math.ceil(Math.random() * 16),(centerY - 8) + Math.ceil(Math.random() * 16),0,type,powerup,"Powerup");
			}
		}
		
		public function moveBullet(proj,type){
			switch (type){
				case "Bullet":
					proj.y -= 65;
					switch(proj.rotation){
						case -35:
							proj.x -= 40; //65 * Math.cos(40);
							break;
						case -4:
							proj.x -= 2;
							break;
						case -2:
							proj.x -= 1;
							break;
						case 2:
							proj.x += 1;
							break;
						case 4:
							proj.x += 2;
							break;
						case 35:
							proj.x += 40;//65 * Math.cos(40);
							break;
					}
					break;
	
			}
			
			
		}
		
		public function adjustASpeed(num){
			bulletTime.removeEventListener(TimerEvent.TIMER,bulletTimer);
			bulletTime = new Timer(num, 0);
			bulletTime.addEventListener(TimerEvent.TIMER,bulletTimer);
			bulletTime.start();
			
		}
		// EVENT FUNCTIONS
		/////////////////////////////////////////////////////////////////////
		//
		public function chargeCollision(){
			if (chargeActive){
				for each (var b:Enemy in enemyArray){
					if (chargeShot.hitTestObject(b)){
						switch (chargeLevel){
							case 1:
								b.damage(6);
								break;
							case 2:
								b.damage(7);
								break;
							case 3:
								b.damage(8);
								break;
						}
						if ((b.getHealth() <= 0)&&(!b.isBoss())){
							destroyEntity(b,"Boss");
						}
						else if ((b.getHealth() <= 0) && (b.isBoss())){
						
						
							trace("Killed Boss");
							destroyEntity(b,"Boss");
							endGame();
						}
					}
				}
			}
		}
		
		public function bulletToEnemy(){
			for each (var t:Bullet in bulletArray){
				moveBullet(t,"Bullet");			
				for each (var b:Enemy in enemyArray){
					if (t.hitTestObject(b)){
						t.x = 6000;
						t.y = 6000;
						b.damage(t.currentFrame)
						destroyEntity(t,"Bullet");
						if ((b.getHealth() <= 0)&&(!b.isBoss())){
							destroyEntity(b,"Boss");
						}
						else if ((b.getHealth() <= 0) && (b.isBoss())){
						
						
							trace("Killed Boss");
							destroyEntity(b,"Boss");
							endGame();
						}
					}
				}
				entityCheckIfOffScreen(t,"Bullet");
			}
		}
		
		public function entityAlign(){
			pHitTest.x = player.x;
			pHitTest.y = player.y;
			chargeShot.x = player.x;
			chargeShot.y = player.y;
			statuseffect.x = player.x;
			statuseffect.y = player.y;
		}

		public function checkStatus(){
			if (statuseffect.currentFrame == 2){
				if (statuseffect.powerDown.currentFrame == statuseffect.powerDown.totalFrames){
					statuseffect.gotoAndStop(1);
				}
			}
		}
		
		public function enemyShootRandomly(){
			
			for each (var e:Enemy in enemyArray){
				if (!e.isBoss()){
					if (e.shootRandomly()){
						addEntity(e.x,e.y,0,1,enemybullet,"Enemy Bullet");
					}
				}
				else{
					if (e.shootRandomly(10)){
						addEntity(e.x,(e.y + (e.height / 2 + 5)),0,1,enemybullet,"Enemy Bullet Boss");
					}
					if (e.shootRandomly(20)){
						addEntity(e.x - 54,e.y + 32,0,1,enemybullet,"Enemy Bullet Boss");
						addEntity(e.x + 54,e.y + 32,0,1,enemybullet,"Enemy Bullet Boss");
						
						addEntity(e.x + 80,e.y + 15,0,1,enemybullet,"Enemy Bullet Boss");
						addEntity(e.x - 80,e.y + 15,0,1,enemybullet,"Enemy Bullet Boss");
					}
				}
			}
		}

		public function update(e:Event){
			entityAlign();
			debug();
			setHud();
			bulletToEnemy();
			entityCollisionCheck("Enemy Bullet",pHitTest);
			entityCollisionCheck("Powerup",player);
			entityCollisionCheck("Enemy",pHitTest);
			entityCollisionCheck("BombShot", bombshot);
			for each (var t:Enemy in enemyArray){
				entityCheckIfOffScreen(t,"Enemy");
			}
			for each (var u:EnemyBullet in enemyBulletArray){
				entityCheckIfOffScreen(u, "Enemy Bullet");
			}
			if (player.getHealth() > 0){
				enemyShootRandomly();
			}
			chargeCollision();
			checkStatus();
		}

		public function startGame(){
			//Stop music from previous and start game music
			// document.setMusicAndPlay("NILL");
			document.setMusicAndPlay(musicHandler.LEVEL1,1000);
			pHitTest = new playerHitArea();
			player = new Player(stageW,stageH,stageWt,stageHt);
			player.gotoAndStop(1);
			powerup = new powerupHandler(stageW,stageH,stageWt,stageHt);
			hud = new Hud();
			chargeShot = new ChargePointer();
			chargeShot.gotoAndStop(1);
			
			bombshot = new bombSkill();

			addEntity(stageWt,stageHt,0,1,backdrop,"Background");
			addEntity(stageWt / 2, stageHt / 2,0,1,chargeShot,"No Array");
			addEntity(stageW / 2, stageH / 2,0,1,bombshot,"No Array");
			addEntity(stageW / 2, stageH / 2,0,1,player,"No Array");
			addEntity(stageW / 2, stageH / 2,0,1,pHitTest,"No Array");
			
			statuseffect = new statusEffect();
			statuseffect.gotoAndStop(1);
			
			addEntity(stageWt / 2, stageHt / 2,0,1,statuseffect,"No Array");
			
			frontLayer.addChild(hud);
			addEntity(0,0,0,1,frontLayer,"Hud");
			
			setHud();
			chargeBar();
			//stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMovement);
			//stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseclick);
			//stage.addEventListener(MouseEvent.MOUSE_UP,mouseup);
			////////stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,rightclick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keys);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyrelease);
			stage.addEventListener(Event.ENTER_FRAME,update);
			gameTime = new Timer (1000, 120);
			gameTime.addEventListener(TimerEvent.TIMER,gameTimer);
			gameTime.addEventListener(TimerEvent.TIMER_COMPLETE,gameOver);
			gameTime.start();   
			bulletTime = new Timer(125, 0);
			bulletTime.addEventListener(TimerEvent.TIMER,bulletTimer);
			bulletTime.start();
			
			
			
		}
		
		public function Main(document) {
			this.document = document;
			// constructor code
			//hud = new Hud();
			//addEntity(stageWt,stageHt,0,1,backdrop,"Background");
			//Leon test
			/*
			testIndex = new testing(this);
			testIndex.produceElements(1);
			testIndex.produceElements(2);
			testIndex.produceElements(3);
			testIndex.produceElements(4);
			testIndex.produceElements(5);
			*/
		}
	}
}
