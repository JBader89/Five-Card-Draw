package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.text.*;
	
	public class Environment extends Sprite
	{
		private var url:String;
		
		private var loader:Loader=new Loader();
		private var loader2:Loader=new Loader();
		
		private var imagesArray:Array=new Array("table.big.2.jpg", "nameplate-bounty.nocards.png", "nameplate-bounty.nocards.png");
		private var loadedArray:Array=new Array();
		
		private var counter:int = 0;
		private var playerStack:int=2000;
		private var computerStack:int=2000;
		private var pStartingStack:int=2000;
		private var cStartingStack:int=2000;
		private var playerBet:int=0;	
		private var computerBet:int=0;	
		private var pot:int=0;	
		
		private var pStack:TextField=new TextField;
		private var cStack:TextField=new TextField;
		private var player:TextField=new TextField;
		private var computer:TextField=new TextField;
		private var playerBetText:TextField=new TextField;
		private var computerBetText:TextField=new TextField;
		private var potText:TextField=new TextField;
		
		private var shuffleSound:Sound=new Sound();
		private var dealFlopSound:Sound=new Sound();
		private var dealTurnRiverSound:Sound=new Sound();
		private var checkSound:Sound=new Sound();
		private var callSound:Sound=new Sound();
		private var betSound:Sound=new Sound();
		private var raiseSound:Sound=new Sound();
		private var foldSound:Sound=new Sound();
		private var potSound:Sound=new Sound();
		
		public function Environment()
		{
			shuffleSound.load(new URLRequest("shuffle.mp3"));
			dealFlopSound.load(new URLRequest("deal_board_card.mp3"));
			dealTurnRiverSound.load(new URLRequest("deal_player_card.mp3"));
			checkSound.load(new URLRequest("check.mp3"));
			callSound.load(new URLRequest("call.mp3"));
			betSound.load(new URLRequest("bet.mp3"));
			raiseSound.load(new URLRequest("raise.mp3"));
			foldSound.load(new URLRequest("fold.mp3"));
			potSound.load(new URLRequest("pot.mp3"));
		}
		
		public function drawBackground():void
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			loader.load(new URLRequest(imagesArray[0]));	
		}

		public function loaded(event:Event):void
		{		
			loadedArray.push(event.target.content);
			
			loadedArray[0].scaleX=1.35;
			loadedArray[0].scaleY=1.25;
			addChild(loadedArray[0]);		
		}
		
		public function drawNameplates():void
		{
			loader2.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded2);
			loader2.load(new URLRequest(imagesArray[counter+1]));	
		}
		
		public function loaded2(event:Event):void
		{		
			loadedArray.push(event.target.content);
			
			loadedArray[counter].y=325;
			loadedArray[counter].scaleX=1.5;
			loadedArray[counter].scaleY=1.75;
			
			if (counter == 0){
				loadedArray[counter].x=45;
				addChild(loadedArray[counter]);
				counter++;
				drawNameplates();
			}
			else if (counter == 1){
				loadedArray[counter].x=740;
				addChild(loadedArray[counter]);
			}
			
		}
		
		public function playShuffle():void{
			shuffleSound.play();
		}
		
		public function playDealBoardCard():void{
			dealFlopSound.play();
		}
		
		public function playDealPlayerCard():void{
			dealTurnRiverSound.play();
			pStartingStack=playerStack;
			cStartingStack=computerStack;
			trace(pStartingStack + " " + playerStack + " " + cStartingStack + " " + computerStack);
		}
		
		public function playCheck():void{
			checkSound.play();
		}

		public function playCall():void{
			callSound.play();
		}

		public function playBet():void{
			betSound.play();
		}
		
		public function playRaise():void{
			raiseSound.play();
		}
		
		public function playFold():void{
			foldSound.play();
		}
		
		public function playPot():void{
			potSound.play();
		}
		
		public function writeHandles():void{
			var format:TextFormat=new TextFormat();
			format.size=20;
			format.bold;
			format.font="Geneva";
			format.color=0xFFFFFF;
			format.align=TextFormatAlign.CENTER;
			
			pStack.x=80;
			pStack.y=370;
			pStack.defaultTextFormat=format;
			addChild(pStack);
			updatePlayerStack(playerStack-pStartingStack);
			
			cStack.x=775;
			cStack.y=370;
			cStack.defaultTextFormat=format;
			addChild(cStack);
			updateComputerStack(computerStack-cStartingStack);
			
			player.x=80;
			player.y=345;
			player.defaultTextFormat=format;
			player.text="Jeremy";
			addChild(player);

			computer.x=775;
			computer.y=345;
			computer.defaultTextFormat=format;
			computer.text="BaderBot";
			addChild(computer);
			
			var myFormat:TextFormat=new TextFormat();
			myFormat.size=12;
			myFormat.font="Geneva";
			myFormat.align=TextFormatAlign.CENTER;
			
			playerBetText.textColor=0xFFFFFF;
			playerBetText.x=205;
			playerBetText.y=390;
			playerBetText.defaultTextFormat=myFormat;
			addChild(playerBetText);
			
			computerBetText.textColor=0xFFFFFF;
			computerBetText.x=655;
			computerBetText.y=390;
			computerBetText.defaultTextFormat=myFormat;
			addChild(computerBetText);
			
			potText.textColor=0xFFFFFF;
			potText.x=430;
			potText.y=390;
			potText.defaultTextFormat=myFormat;
			addChild(potText);
		}
		
		public function updatePlayerStack(one:int):void {
			playerStack=pStartingStack+one;
			pStack.text="$"+playerStack.toString();
		}
		
		public function updateComputerStack(two:int):void {
			computerStack=cStartingStack+two;
			cStack.text="$"+computerStack.toString();
		}
		
		public function updatePlayerBet(one:int, differentChips:int):void {
			playerBet=one;
			if (playerBet==0){
				playerBetText.visible=false;
			}
			else{
				playerBetText.text="$"+playerBet.toString();
				playerBetText.x=193+(differentChips*12);
				playerBetText.visible=true;
			}
		}
		
		public function updateComputerBet(two:int, differentChips:int):void {
			computerBet=two;
			if (computerBet==0){
				computerBetText.visible=false;
			}
			else{
				computerBetText.text="$"+computerBet.toString();
				computerBetText.x=667-(differentChips*12);
				computerBetText.visible=true;
			}
		}
		
		public function updatePot(three:int, differentChips:int, potMove:int):void {
			pot=three;
			if (pot==0){
				potText.visible=false;
			}
			else{
				potText.text="$"+pot.toString();
				potText.x=452-(differentChips*12)+potMove;
				potText.visible=true;
			}
			pStartingStack=playerStack;
			cStartingStack=computerStack;
		}
	}
}