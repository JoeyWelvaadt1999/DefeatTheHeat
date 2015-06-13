package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.setInterval;
	
	public class Game extends Sprite
	{
		private var healthBar:HealthBarArt = new HealthBarArt();
		
		private var score:int = 0;
		private var scoreText:TextField = new TextField();
		
		private var bullets:Array = new Array();
		private var enemies:Array = new Array();
		private var spawnPoints:Array = [];
		
		private var player:Player = new Player();
		public var objective:Objective = new Objective();
		
		private var shootSound:Sound = new Sound();
		
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			shootSound.load(new URLRequest("waterpistol_shoot.mp3"));
		}
		
		private function init(e:Event):void {
			spawnPoints.push(new Point(Math.random() * stage.stageWidth, -100));
			spawnPoints.push(new Point(stage.stageWidth + 100, Math.random() * stage.stageHeight));
			spawnPoints.push(new Point(Math.random() * stage.stageWidth, stage.stageHeight + 100));
			spawnPoints.push(new Point(-100, Math.random() * stage.stageHeight));
			
			setInterval(AddEnemies, 750);
			
			AddImages();
			
			addChild(healthBar);
			healthBar.x = 43;
			healthBar.y = 10;
			healthBar.scaleX = 0.6;
			healthBar.scaleY = 0.5;
			
			addPlayer();
			
			addChild(objective);
			objective.x = stage.stageWidth/2;
			objective.y = stage.stageHeight/2;
			
			scoreText.x = stage.stageWidth - 60;
			scoreText.y = -5;
			scoreText.scaleX = 2.5;
			scoreText.scaleY = 2.5;
			scoreText.textColor = 0xF6CEE3;
			addChild(scoreText);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, Shoot);
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		private function Update(e:Event):void {
			CheckCollision();
			healthBar.scaleX = objective.health / 25 * .6;
			scoreText.text = "" + score;
		}
		
		private function addPlayer():void {
			addChild(player);
			player.x = stage.stageWidth / 2;
			player.y = stage.stageHeight / 2;
			player.scaleX = 1;
			player.scaleY = 1;
		}
		
		private function AddEnemies():void {
			var enemy:Enemy = new Enemy(spawnPoints[Math.floor(Math.random() * spawnPoints.length)].x, spawnPoints[Math.floor(Math.random() * spawnPoints.length)].y, objective.x, objective.y);
			
			addChild(enemy);
			
			enemies.push(enemy);		
			
		}
		
		private function Shoot(e:KeyboardEvent):void {
			if(e.keyCode == Keyboard.SPACE){
				var bullet:Bullet = new Bullet();
				addChild(bullet);
				bullets.push(bullet);
				bullet.scaleY = 0.25;
				bullet.scaleX = 0.25;
				bullet.x = player.x;
				bullet.y = player.y;
				bullet.rotationZ = player.rotationZ;
				bullet.calculateMovement();	
				shootSound.play();
			}
		}
		
		private function CheckCollision():void {
			var l:int = bullets.length;
			var l2:int = enemies.length;
			
			for(var i:int = 0; i < l; i++) {
				for(var j:int = 0; j < l2; j++) {
					//Enemies start
					
 					if(enemies[j].hitTestObject(bullets[i])) {
						enemies[j].health--;
						score++;
						enemies[j].DestroyZeroHealth();
						bullets[i].Destroy(); 
					}
					
					//Enemies end
					
					//Objective start
					
					if(objective.hitTestObject(enemies[j])) {
						objective.health -= enemies[j].health;
						enemies[j].Destroy();
					}
					
					//Objective end
				}
			}
		}
		
		private function AddImages():void {			
			var bgImage:String = "Background.png";
			var bgLoader:Loader = new Loader();
			var bgRequest:URLRequest = new URLRequest(bgImage);
			
			bgLoader.scaleX = .625;
			bgLoader.scaleY = .625;
			
			bgLoader.load(bgRequest);
			
			addChildAt(bgLoader,0);
			
			var treesImage:String = "Trees.png";
			var treesLoader:Loader = new Loader();
			var treesRequest:URLRequest = new URLRequest(treesImage);
			
			treesLoader.scaleX = .625;
			treesLoader.scaleY = .625;
			
			treesLoader.load(treesRequest);	
			
			addChildAt(treesLoader,1);
			
			var uiImage:String = "UserInterface.png";
			var uiLoader:Loader = new Loader();
			var uiRequest:URLRequest = new URLRequest(uiImage);
			
			uiLoader.scaleX = .625;
			uiLoader.scaleY = .625;
			
			uiLoader.load(uiRequest);
			
			addChild(uiLoader);
		}
 	}
}