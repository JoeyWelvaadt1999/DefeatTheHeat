package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Player extends MovieClip
	{
		private var aPressed:Boolean = false;
		private var dPressed:Boolean = false;		
		private var player:PlayerArt = new PlayerArt();
		
		public var speed:int = 6;
		public function Player()
		{
			addChild(player);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop (e:Event):void {
			if (aPressed) {
				rotationZ -= speed;
			}
			if(dPressed) {
				rotationZ += speed;
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			if(e.keyCode == Keyboard.A) {
				aPressed = true;
			}
			
			if(e.keyCode == Keyboard.D) {
				dPressed = true;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void {
			if(e.keyCode == Keyboard.A) {
				aPressed = false;
			}
			
			if(e.keyCode == Keyboard.D) {
				dPressed = false;
			}
		}
	}
}

