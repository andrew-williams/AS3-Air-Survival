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
	import flash.utils.getQualifiedClassName;
	
	public class Game extends Screen{
		//new stuiff
		private var sm:StateMachine;
		private var gameData:GameData;
		/*
			Layering (1=Bottom 5=Top
			1: Background
			2: Midground
			3: Foreground
			4: ALL GAMEPLAY GOES HERE
			5: HUD
			6: (Not a Layer) Screens
		*/
		private var layerOne:Sprite;
		private var layerTwo:Sprite;
		private var layerThree:Sprite;
		private var layerFour:Sprite;
		private var layerFive:Sprite;

		//Layer 4
		private var enemy:Enemy;
		private var enemyArray:Array = new Array();
		
		private var player:Player;
		private var pHitTest:playerHitArea;
		private var pStatusEffect:statusEffect;
		private var pChargePointer:ChargePointer;
		
		private var powerup:PowerupHandler;
		private var powerupArray:Array = new Array();
		
		private var bombShot:BombSkill;
		
		private var bullet:Bullet;
		private var bulletArray:Array = new Array();
		//Layer 5
		private var hud:Hud;
		
		//Functions
		private var addEntity:AddEntity;
		private var removeEntity:RemoveEntity;
		private var align:AlignWithEntity;
		private var detectEntityCollision:DetectEntityCollision;
		private var playerShootBullets:PlayerShootBullets;
		
		//Timer for shooting
		private var shootingTimer:Timer;
		
		
		public function Game(sm:StateMachine,gd:GameData) {			
			this.sm = sm;
			gameData = gd;
			addEventListener(Event.ADDED_TO_STAGE, Enter,false,0,true);
		}
		
		private function Enter(e:Event):void{
			trace("This should only be run once.");
			gameData.cc.ToConsole("changemus 2");
			gameData.cc.PushMessage("Starting Game...");
			startGame();
		}
		
		public function startGame(){
			//First time the game is started.
			//Initialize Game Layers.
			gameData.cc.PushMessage("Initializing Game...");
			gameData.cc.PushMessage("Initializing Functions...");
			addEntity = new AddEntity();
			removeEntity = new RemoveEntity();
			align = new AlignWithEntity();
			detectEntityCollision = new DetectEntityCollision(gameData,removeEntity);
			gameData.cc.PushMessage("Creating Game Layers...");
			gameData.cc.PushMessage("Creating Layer 1 At (0,0)...");
			addEntity.callFunction(layerOne = new Sprite(),0,0,this);
			gameData.cc.PushMessage("Creating Layer 2 At (0,50)...");
			addEntity.callFunction(layerTwo = new Sprite(),0,50,this);
			gameData.cc.PushMessage("Creating Layer 3 At (0,0)...");
			addEntity.callFunction(layerThree = new Sprite(),0,0,this);
			gameData.cc.PushMessage("Creating Layer 4 At (0,0)...");
			addEntity.callFunction(layerFour = new Sprite(),0,0,this);
			gameData.cc.PushMessage("Creating Layer 5 At (0,0)...");
			addEntity.callFunction(layerFive = new Sprite(),0,0,this);
			gameData.cc.PushMessage("Creating Game Layers Complete!");
			//Initialize Level 1 Backgrounds
			gameData.cc.PushMessage("Creating Background...");
			var test1:MidGroundContainer = new MidGroundContainer();
			var test2:MidGroundContainer = new MidGroundContainer();
			test2.scaleX = -1;
			addEntity.callFunction(test1,-96,0,layerTwo,1);
			addEntity.callFunction(test2,708,0,layerTwo,1);
			
			addEntity.callFunction(gameData.backdrop = new BGContainer(),0,0,layerOne,2);
			//Initialize Level 2 Backgrounds
			/*
			addEntity.callFunction(gameData.midground = new MidGroundContainer(),-84,0,layerTwo,1);
			addEntity.callFunction(gameData.midgroundFlip = new MidGroundContainer(),686,0,layerTwo,1);
			gameData.midgroundFlip.scaleX = -1;
			*/
			//Initialize Level 5 HUD
			gameData.cc.PushMessage("Creating HUD...");
			addEntity.callFunction(hud = new Hud(gameData),0,0,layerFive,0);
			gameData.cc.PushMessage("Initializing HUD...");
			hud.setHud();
			gameData.cc.PushMessage("Creating Player...");
			gameData.cc.PushMessage("Initializing Player Data...");
			addEntity.callFunction(bombShot = new BombSkill(),gameData.stageW/2,gameData.stageH/2,layerFour,1);
			addEntity.callFunction(pChargePointer = new ChargePointer(gameData),100,300,layerFour,1);
			addEntity.callFunction(player = new Player(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt,gameData),gameData.stageW/2,gameData.stageH/2,layerFour,1);
			addEntity.callFunction(pHitTest = new playerHitArea(),100,100,layerFour,1);
			addEntity.callFunction(pStatusEffect = new statusEffect(),100,200,layerFour,1);
			gameData.InitPlayerStats();
			gameData.cc.PushMessage("Initializing Powerups...");
			addEntity.callFunction(powerup = new PowerupHandler(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt),200,200,layerFour,Math.ceil(Math.random() * powerup.totalFrames),0,powerupArray);


			gameData.cc.PushMessage("Adding Test Enemy...");
			//addEntity.callFunction(enemy = new Enemy(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt,gameData),100,100,layerFour,1,0,enemyArray);
//			addEntity.callFunction(enemy = new Enemy(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt,gameData),100,150,layerFour,1,0,enemyArray);
		//	addEntity.callFunction(enemy = new Enemy(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt,gameData),100,200,layerFour,1,0,enemyArray);
			//addEntity.callFunction(enemy = new Enemy(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt,gameData),100,250,layerFour,1,0,enemyArray);
			//addEntity.callFunction(enemy = new Enemy(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt,gameData),100,300,layerFour,1,0,enemyArray);
			
			
			
			/*
			gameTime = new Timer (1000, 120);
			gameTime.addEventListener(TimerEvent.TIMER,gameTimer);
			gameTime.addEventListener(TimerEvent.TIMER_COMPLETE,gameOver);
			gameTime.start();   
			*/
			gameData.seconds = 0;
			
			shootingTimer = new Timer(gameData.p_AttackSpeed,0);
			shootingTimer.addEventListener(TimerEvent.TIMER,ShootingTimer);
			shootingTimer.start();
		}
		override public function Tick(e:TimerEvent):void{
			gameData.seconds++;
			//addEntity.callFunction(powerup = new PowerupHandler(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt),Math.ceil(Math.random() * gameData.stageW),Math.ceil(Math.random() * gameData.stageH),layerFour,Math.ceil(Math.random() * powerup.totalFrames),0,powerupArray);
			addEntity.callFunction(enemy = new Enemy(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt,gameData,1),gameData.stageWt - 10,-20,layerFour,1,0,enemyArray);
			addEntity.callFunction(enemy = new Enemy(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt,gameData,2),gameData.stageW + 10,-20,layerFour,1,0,enemyArray);
		}
		private function ShootingTimer(e:TimerEvent):void{
			if (gameData.p_IsFiring){
				playerShootBullets = new PlayerShootBullets(gameData,addEntity,layerFour,player,bullet,bulletArray);
			}
		}
		
		override public function Update(e:Event):void{
			//trace(enemyArray.length);
			player.Update(e);
			UpdateBullets(e);
			UpdatePowerups(e);
			UpdateEnemies(e);
			align.Align(player,new Array(pHitTest,pStatusEffect,pChargePointer));
			hud.setHud();
			pStatusEffect.CheckStatus();
			detectEntityCollision.CallFunction(player,"Powerup",layerFour,powerupArray);
			detectEntityCollision.EntityToEntity(bullet,enemy,"BulletToEnemy",layerFour,bulletArray,enemyArray);
			detectEntityCollision.CallFunction(pHitTest,"Enemy",layerFour,enemyArray,pStatusEffect);
			
		}
		
		private function UpdateBullets(e:Event):void{
			for each (var u:Bullet in bulletArray){
				u.Update(e);
				if (u.CanDelete()){
					removeEntity.callFunction(u,layerFour,bulletArray);
				}
			}
		}
		private function UpdatePowerups(e:Event):void{
			for each (var u:PowerupHandler in powerupArray){
				u.Update(e);
			}
		}
		
		private function UpdateEnemies(e:Event):void{
			for each (var u:Enemy in enemyArray){
				u.Update(e);
				if (u.IsDead()){
					removeEntity.callFunction(u,layerFour,enemyArray);
				}
			}
		}

			/*
	
			
			debug();
			bulletToEnemy();
			entityCollisionCheck("Enemy Bullet",pHitTest);
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
		}

		
		*/
		
		override public function key_down(e:KeyboardEvent):void{
			player.Key_Down(e);
			switch (e.keyCode){
				case Keyboard.SPACE:
					if ((!gameData.p_ChargeActive) && (gameData.p_Charge > 150)){
						gameData.p_ChargeActive = true;
						if ((gameData.p_Charge >= 150) && (gameData.p_Charge < 400)){
							gameData.p_ChargeLevel = 1;
						}
						else if ((gameData.p_Charge >= 400) && (gameData.p_Charge < 1000)){
							gameData.p_ChargeLevel = 2;
						}
						else if (gameData.p_Charge == 1000){
							gameData.p_ChargeLevel = 3;
						}
						gameData.p_ChargeLevel = 0;
						gameData.cc.ToConsole("set charge 0");
						pChargePointer.ActivateCharge();
						
					}
					break;
				//Quick debug keys without console access
				case Keyboard.NUMBER_1:
					addEntity.callFunction(powerup = new PowerupHandler(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt),200,200,layerFour,1,0,powerupArray);
					break;
				case Keyboard.NUMBER_2:
					addEntity.callFunction(powerup = new PowerupHandler(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt),200,200,layerFour,2,0,powerupArray);
					break;
				case Keyboard.NUMBER_3:
					addEntity.callFunction(powerup = new PowerupHandler(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt),200,200,layerFour,3,0,powerupArray);
					break;
				case Keyboard.NUMBER_4:
					addEntity.callFunction(powerup = new PowerupHandler(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt),200,200,layerFour,4,0,powerupArray);
					break;
				case Keyboard.NUMBER_5:
					addEntity.callFunction(powerup = new PowerupHandler(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt),200,200,layerFour,5,0,powerupArray);
					break;
				case Keyboard.NUMBER_6:
					addEntity.callFunction(powerup = new PowerupHandler(gameData.stageW,gameData.stageH,gameData.stageWt,gameData.stageHt),200,200,layerFour,6,0,powerupArray);
					break;
				case Keyboard.X:
					gameData.p_IsFiring = true;
					break;
				case Keyboard.Z:
					if ((bombShot.isBombActive() == false) && (gameData.p_Bomb > 0)){
						gameData.p_Bomb--;
						align.Align(player,new Array(bombShot));
						bombShot.activateBomb();
					}
					break;
				case 192: // tilde
					player.StopMovement();
					break;
			}
			/*
			public function keys(k:KeyboardEvent){
			switch (k.keyCode){
			
				case Keyboard.NUMBER_7:
					addEntity(Math.ceil(Math.random() * stageW),-25,0,1,enemy,"Enemy");
					break;
				
			}
		}
			*/
		}
		override public function key_up(e:KeyboardEvent):void{
			player.Key_Up(e);
			switch (e.keyCode){
				case Keyboard.X:
					gameData.p_IsFiring = false;
					break;
				case Keyboard.ESCAPE:
					gameData.cc.ToConsole("quit");
					break;
			}
		}
		
		
		/*
		var menuTime:Timer;
		
		var bullet:Bullet;
		var bulletArray:Array = new Array();
		var enemybullet:EnemyBullet;
		var enemyBulletArray:Array = new Array();
		
		var interval:int = 0;
		var gameTime:Timer;
		var bulletTime:Timer;
		

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
		
		
		// TIMER FUNCTIONS
		/////////////////////////////////////////////////////////////////////
		// EVENT FUNCTIONS
		//EVENT
		
		
		
		
		
		
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
*/
		
		
	}
}
