package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	[SWF(backgroundColor="0x00000")]
	
	public class Main extends Sprite
	{
		private var credits:CreditsButton = new CreditsButton();
		private var start:StartButton = new StartButton();
		private var howToPlay:HowToPlay = new HowToPlay();
		
		private var backButton:Back = new Back(); 
		
		private var buttonClickSound:Sound = new Sound();
		
		private var endImage:String = "Gameover.jpg";
		private var endLoader:Loader = new Loader();
		private var endRequest:URLRequest = new URLRequest(endImage);
		
		private var backToMainMenuButton:MainMenuButton = new MainMenuButton();
		private var playAgainButton:PlayAgainButton = new PlayAgainButton();
		
		private var game:Game;
		public function Main()
		{
			buttonClickSound.load(new URLRequest("buttonpress.mp3"))
			stage.frameRate = 30;
			addMenu();
			start.addEventListener(MouseEvent.CLICK, startGame);
			credits.addEventListener(MouseEvent.CLICK, Credits);
			howToPlay.addEventListener(MouseEvent.CLICK, HowTo);
			backButton.addEventListener(MouseEvent.CLICK, GoBack);
			addEventListener(Event.ENTER_FRAME, Update);
			game  = new Game();
		}
		
		private function Update(e:Event):void {
			if(game.objective.health <= 0) {
				AddEndScreen();
				removeChild(game);
				removeEventListener(Event.ENTER_FRAME, Update);
			}
		}
		
		private function startGame(e:MouseEvent):void {
			addChild(game);
			removeChild(start);
			buttonClickSound.play();
		}
		
		private function HowTo(e:MouseEvent):void {
			buttonClickSound.play();
		}
		
		private function Credits(e:MouseEvent):void {
			var crImage:String = "creditspage.png";
			var crLoader:Loader = new Loader();
			var crRequest:URLRequest = new URLRequest(crImage);
			crLoader.load(crRequest);
			crLoader.scaleX = .125;
			crLoader.scaleY = .11;
			addChild(crLoader);	
			
			addChild(backButton);
			backButton.x = 32;
			backButton.y = 20;
			buttonClickSound.play();
		}
		
		private function addMenu():void	{
			var bgImage:String = "mainBackground.png";
			var bgLoader:Loader = new Loader();
			var bgRequest:URLRequest = new URLRequest(bgImage);
			bgLoader.load(bgRequest);
			bgLoader.scaleX = .625;
			bgLoader.scaleY = .625;
			addChild(bgLoader);
			
			start.scaleX = .7;
			start.scaleY = .7;
			start.x = 100;
			start.y = 100;
			addChild(start);
			
			credits.scaleX = .7;
			credits.scaleY = .7;
			credits.x = 100;
			credits.y = 300;
			addChild(credits);
			
			howToPlay.scaleX = .7;
			howToPlay.scaleY = .7;
			howToPlay.x = 100;
			howToPlay.y = 200;
			addChild(howToPlay);
		}
		
		public function AddEndScreen():void {
			
			
			endLoader.load(endRequest);
			
			endLoader.scaleX = .625;
			endLoader.scaleY = .625;
			
			addChild(endLoader);
			addChild(backToMainMenuButton);
			backToMainMenuButton.x = stage.stageWidth - 65;
			backToMainMenuButton.y = stage.stageHeight - 30;
			backToMainMenuButton.scaleX = .7;
			backToMainMenuButton.scaleY = .7;
			backToMainMenuButton.addEventListener(MouseEvent.CLICK, backToMenu);
			
			addChild(playAgainButton);
			playAgainButton.x = 65;
			playAgainButton.y = stage.stageHeight - 30;
			playAgainButton.scaleX = .7;
			playAgainButton.scaleY = .7;
			playAgainButton.addEventListener(MouseEvent.CLICK, PlayAgain);
		}
		
		private function PlayAgain(e:MouseEvent):void {
			removeChild(playAgainButton);
			game = new Game();
			addChild(game)
		}
		
		private function GoBack(e:MouseEvent):void {
			removeChild(backButton);
			removeChild(credits);
			addMenu();
			buttonClickSound.play();
		}
		
		private function backToMenu(e:MouseEvent):void {
			removeChild(endLoader);
			removeChild(backToMainMenuButton);
			addMenu();
			buttonClickSound.play();
		}
	}
}