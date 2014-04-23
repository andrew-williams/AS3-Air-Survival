package  {
	import flash.display.Sprite;
	
	public class RemoveEntity {

		public function RemoveEntity() {
			// constructor code
		}
		
		public function callFunction(entity, layer:Sprite, entityArray:Array = null): void{
			//this works for all of the old bullets, enemy bullets,powerups
			entityArray.splice(entityArray.indexOf(entity),1);
			layer.removeChild(entity);
		}
	}
	
}
/*
		public function destroyEntity(object,objectArray:String, includeItem:Boolean = true){
			
			switch (objectArray){
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
		}*/