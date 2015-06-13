package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Objective extends Sprite
	{
		public var health:int = 25;
		public var base:ObjectiveArt = new ObjectiveArt();
		public function Objective()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(base);
			base.scaleX = 0.7;
			base.scaleY = 0.7;
		}
		
		public function Destroy():void {
			removeChild(base);
		}
	}
}