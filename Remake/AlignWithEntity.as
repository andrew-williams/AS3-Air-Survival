package  {
	
	public class AlignWithEntity {

		public function AlignWithEntity() {}

		public function Align(baseEntity, listOfEntities:Array){
			for each (var entity in listOfEntities){
				entity.x = baseEntity.x;
				entity.y = baseEntity.y;
			}
		}
		
	}
	
}
