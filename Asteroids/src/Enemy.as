package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Enemy extends MovieClip
	{
		private var enemy:Monster_1_walk = new Monster_1_walk();
		private var secondEnemy:Monster_2_walk = new Monster_2_walk();
		private var thirdEnemy:Monster_3_walk = new Monster_3_walk(); 
		private var fourthEnemy:Monster_4_walk = new Monster_4_walk(); 
		
		private var totalEnemies:Array = [enemy, secondEnemy, thirdEnemy, fourthEnemy];
		
		public var health:int;
		private var randomSpawn:Number
		
		private var _moveSpeedMax:Number = 6;
		private var _moveSpeedCurrent:Number = 2;
		private var _acceleration:Number = 0;
		
		private var _rotateSpeedMax:Number = 10;
		
		private var _destinationX:int;
		private var _destinationY:Number;
		
		private var _minX:Number = 0;
		private var _minY:Number = 0;
		private var _maxX:Number = 550;
		private var _maxY:Number = 400;
		
		
		private var _directionChangeProximity:Number = 5;
		private var _distance:Number;
		
		
		// global		
		private var _dx:Number = 0;
		private var _dy:Number = 0;		
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		
		private var _trueRotation:Number = 0;
		
		private var xPos:Number;
		private var yPos:Number;
		
		public function Enemy(thisX, thisY, objectiveX, objectiveY)
		{
			xPos = objectiveX;
			yPos = objectiveY;
			
			randomSpawn = Math.floor(Math.random() * totalEnemies.length);
			
			switch(randomSpawn) {
				case (0): 
					addChild(totalEnemies[0]);
					enemy.scaleX = .05;
					enemy.scaleY = .05;
					health = 1;
					break;
				case (1): 
					addChild(totalEnemies[1]);
					secondEnemy.scaleX = .1;
					secondEnemy.scaleY = .1;
					health = 2;
					break;
				case (2): 
					addChild(totalEnemies[2]);
					thirdEnemy.scaleX = .1;
					thirdEnemy.scaleY = .1;
					health = 3;
					break;
				case (3): 
					addChild(totalEnemies[3]);
					fourthEnemy.scaleX = .1;
					fourthEnemy.scaleY = .1;
					health = 4;
					break;
			}	
			
			this.x = thisX;
			this.y = thisY;
			
			if(this.x < 800 && this.x > 0 && this.y < 600 && this.y > 0) {
				removeChild(totalEnemies[randomSpawn]);
			} 
			
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init (e:Event):void {
			addEventListener(Event.ENTER_FRAME, Update);
			_destinationX = xPos;
			_destinationY = yPos;			
		}
		
		private function Update (e:Event):void {
			updatePosition();
			updateRotation();
			
			switch(randomSpawn){
				case(2):
					totalEnemies[2].play(); 
					break;
			}
		}
		
		public function DestroyZeroHealth():void {
			if(health <= 0) {
				removeChild (totalEnemies[randomSpawn]);
			}
		}
		
		public function Destroy():void {
			removeChild (totalEnemies[randomSpawn]);
		}
		
		private function updateRotation():void
		{
			// calculate rotation
			_dx = this.x - _destinationX;
			_dy = this.y - _destinationY;
			
			// which way to rotate
			var rotateTo:Number = getDegrees(getRadians(_dx, _dy));	
			
			// keep rotation positive, between 0 and 360 degrees
			if (rotateTo > this.rotation + 180) rotateTo -= 360;
			if (rotateTo < this.rotation - 180) rotateTo += 360;
			
			// ease rotation
			_trueRotation = (rotateTo - this.rotation) / _rotateSpeedMax;
			
			// update rotation
			this.rotation += _trueRotation;
		}
		
		private function updatePosition():void
		{
			
			// get distance
			_distance = getDistance(_destinationX - this.x, _destinationY - this.y);
			
			// update speed (accelerate/slow down) based on distance
			if (_distance >= 50)
			{
				_moveSpeedCurrent += _acceleration;
				
				if (_moveSpeedCurrent > _moveSpeedMax)
				{
					_moveSpeedCurrent = _moveSpeedMax;
				}
			}
			else if (_distance < 30)
			{
				_moveSpeedCurrent *= .90;
			}
			
			// update velocity
			_vx = (_destinationX - this.x) / _distance * _moveSpeedCurrent;
			_vy = (_destinationY - this.y) / _distance * _moveSpeedCurrent;
			
			// update position
			this.x += _vx;
			this.y += _vy;
		}
		
		
		/**
		 * Get distance
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		
		/**
		 * Get radians
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
			
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		
		/**
		 * Get degrees
		 * @param	radians
		 * @return
		 */
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
		
	}
}