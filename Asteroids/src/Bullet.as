package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Bullet extends Sprite
	{
		private var xMove:Number;
		private var yMove:Number;
		private var bullet:BulletArt = new BulletArt();
		public function Bullet()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void
		{
			addEventListener(Event.ENTER_FRAME, Update);
			addChild(bullet);
		}
		
		public function calculateMovement():void
		{
			var radians:Number = this.rotation * Math.PI / 180;
			xMove = Math.cos(radians);
			yMove = Math.sin(radians);
		} 
		
		public function Update(e:Event):void {
			x += xMove * 10;
			y += yMove * 10;	
		}
		
		public function Destroy():void {
			removeChild(bullet)
		}
	}
}