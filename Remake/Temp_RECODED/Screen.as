package  {
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class Screen extends MovieClip{


		public static const START:String = "START";
		public static const CONTROLS:String = "controls";
		public static const END:String = "restartgame";
		public static const HELP:String = "help";
		public static const CREDIT:String = "btnCredit";
		public static const SOUNDBOARD:String = "Soundboard";
		public static const ENDTOPREVIOUS:String = "End to previous state";
		
		public function Screen():void{
			// constructor code
		}
		
		public function Init():void{}

		public function Update(e:Event):void{}
		public function key_down(e:KeyboardEvent) : void{}
		public function key_up(e:KeyboardEvent): void{}/*
		public function mouse_move(e:MouseEvent): void{}
		public function mouse_up(e:MouseEvent): void{}
		public function mouse_down(e:MouseEvent): void{}
		public function right_click(e:MouseEvent): void{}*/
		//public function left_click(e:MouseEvent){}
		public function Tick(e:TimerEvent): void{}
		
		
	}
	
}
