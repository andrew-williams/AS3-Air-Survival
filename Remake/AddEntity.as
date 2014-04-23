package  {
	//import flash.display.MovieClip;
	import flash.display.Sprite;
	/*
		xloc = the x location of the entity
		yloc = the y location of the entity
		frame = the type of entity in the container
		object = the actual object itself
		objectarray = the object array for the container
		entity = identifier
		*/
	public class AddEntity {

		public function AddEntity(): void {}
		
		public function callFunction(entity, startX:int, startY:int, layer:Sprite,frame:int = 0, entityRotation:int = 0,entityArray:Array = null): void{
			entity.x = startX;
			entity.y = startY;
			entity.rotation = entityRotation;
			if (frame > 0){
				entity.gotoAndStop(frame);
			}
			
			layer.addChild(entity);
			if (entityArray != null){
				entityArray.push(entity);
			}
		}
		/*
		public function createProjectile(xloc,yloc,frame,object,objectArray,crosshairx,crosshairy): void{
			object = new projectileContainer();
			object.x = xloc;
			object.y = yloc;
			object.gotoAndStop(frame);
			sParent.addChild(object);
			object.shootBullet(crosshairx,crosshairy,xloc,yloc);
			objectArray.push(object);
		}
*/
	}
	
}