package
{
	import Environment;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;

	public class Cards extends Sprite
	{
		private var url:String;
		private var loader:Loader=new Loader();
		private var loader2:Loader=new Loader();
		private var loader3:Loader=new Loader();
		private var loader4:Loader=new Loader();
		private var loader5:Loader=new Loader();
		private var loader6:Loader=new Loader();
		private var loader7:Loader=new Loader();
		private var loader8:Loader=new Loader();
		private var loader9:Loader=new Loader();
		private var loader10:Loader=new Loader();
		private var loader11:Loader=new Loader();
		private var loader12:Loader=new Loader();
		private var imagesArrayOriginal:Array=new Array("c1.gif", "c2.gif", "c3.gif", "c4.gif", "c5.gif", "c6.gif", "c7.gif", "c8.gif", "c9.gif", "c10.gif", "c11.gif", "c12.gif", "c13.gif", "d1.gif", "d2.gif", "d3.gif", "d4.gif", "d5.gif", "d6.gif", "d7.gif", "d8.gif", "d9.gif", "d10.gif", "d11.gif", "d12.gif", "d13.gif", "h1.gif", "h2.gif", "h3.gif", "h4.gif", "h5.gif", "h6.gif", "h7.gif", "h8.gif", "h9.gif", "h10.gif", "h11.gif", "h12.gif", "h13.gif", "s1.gif", "s2.gif", "s3.gif", "s4.gif", "s5.gif", "s6.gif", "s7.gif", "s8.gif", "s9.gif", "s10.gif", "s11.gif", "s12.gif", "s13.gif");
		private var imagesArray:Array=new Array("c1.gif", "c2.gif", "c3.gif", "c4.gif", "c5.gif", "c6.gif", "c7.gif", "c8.gif", "c9.gif", "c10.gif", "c11.gif", "c12.gif", "c13.gif", "d1.gif", "d2.gif", "d3.gif", "d4.gif", "d5.gif", "d6.gif", "d7.gif", "d8.gif", "d9.gif", "d10.gif", "d11.gif", "d12.gif", "d13.gif", "h1.gif", "h2.gif", "h3.gif", "h4.gif", "h5.gif", "h6.gif", "h7.gif", "h8.gif", "h9.gif", "h10.gif", "h11.gif", "h12.gif", "h13.gif", "s1.gif", "s2.gif", "s3.gif", "s4.gif", "s5.gif", "s6.gif", "s7.gif", "s8.gif", "s9.gif", "s10.gif", "s11.gif", "s12.gif", "s13.gif");
		private var cardArray:Array=new Array();
		private var downCardArray:Array=new Array();
		private var playerArray:Array=new Array();
		private var computerArray:Array=new Array();
		private var downCard:String="downCard.gif";
		private var counter:int = 0;
		private var cardNumber:int = 0;
		private var cPair:int = 0;
		private var pPair:int = 0;
		private var cPair2:int = 0;
		private var pPair2:int = 0;
		private var cExtra:int = 0;
		private var pExtra:int = 0;
		private var p1Num:int = 0;
		private var p2Num:int = 0;
		private var p3Num:int = 0;
		private var p4Num:int = 0;
		private var p5Num:int = 0;
		private var c1Num:int = 0;
		private var c2Num:int = 0;
		private var c3Num:int = 0;
		private var c4Num:int = 0;
		private var c5Num:int = 0;
		private var p1Suit:String = "";
		private var p2Suit:String = "";
		private var p3Suit:String = "";
		private var p4Suit:String = "";
		private var p5Suit:String = "";
		private var c1Suit:String = "";
		private var c2Suit:String = "";
		private var c3Suit:String = "";
		private var c4Suit:String = "";
		private var c5Suit:String = "";
		
		private var firstDraw:Boolean=false;
		private var currentCard:int=Math.floor(Math.random()*52) - counter;
		private var playerCard1:Sprite = new Sprite();
		private var playerCard2:Sprite = new Sprite();
		private var playerCard3:Sprite = new Sprite();
		private var playerCard4:Sprite = new Sprite();
		private var playerCard5:Sprite = new Sprite();
		private var computerCard1:Sprite = new Sprite();
		private var computerCard2:Sprite = new Sprite();
		private var computerCard3:Sprite = new Sprite();
		private var computerCard4:Sprite = new Sprite();
		private var computerCard5:Sprite = new Sprite();
		private var cardTimer:Timer=new Timer(100);
		private var cardTimer2:Timer=new Timer(100);
		
		private var nameplates:Environment=new Environment;

		
		public function Cards()
		{
		}
		
		public function playHand():void
		{
			loadDownCard();
			dealHand();
		}
		
		public function loadDownCard():void
		{
			loader2.load(new URLRequest(downCard));	
			loader2.contentLoaderInfo.addEventListener(Event.COMPLETE, loadDown);
		}
		
		public function loadDown(event:Event):void
		{
			for (var i:int=0; i<5; i++){
				var duplicationBitmap:Bitmap = new Bitmap(Bitmap(loader2.content).bitmapData);
				duplicationBitmap.scaleX=1.4;
				duplicationBitmap.scaleY=1.35;
				downCardArray.push(duplicationBitmap);
			}
		}
		
		public function dealHand():void
		{
			if (cardArray.length % 2 == 0)
			{
				playerArray.push(imagesArray[currentCard]);
			}
			else if (cardArray.length % 2 == 1)
			{
				computerArray.push(imagesArray[currentCard]);
			}
			loader.load(new URLRequest(imagesArray[currentCard]));	
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			imagesArray.splice(currentCard, 1);
		}
		
		public function loaded(event:Event):void
		{	
			cardArray.push(event.target.content);
			
			if (cardArray.length % 2 == 1)
			{
				cardArray[cardArray.length-1].x = 55 + cardArray.length * 8;
			}
			else if (cardArray.length % 2 == 0)
			{
				cardArray[cardArray.length-1].x = 745 + cardArray.length * 8;
				downCardArray[(cardArray.length/2)-1].x = 745 + cardArray.length * 8;
				downCardArray[(cardArray.length/2)-1].y = 300;
			}
			cardArray[cardArray.length-1].y = 300;
			addCard();
			counter++;
			if (counter < 10){
				currentCard=Math.floor(Math.random()*(52-counter));
				dealHand();
			}
			else{
				nameplates.drawNameplates();
				addChild(nameplates);
			}
		}
		
		public function addCard():void
		{
			if (cardArray.length==1 || cardNumber==1)
			{
				playerCard1.addChild(cardArray[cardArray.length-1]);
				playerCard1.addEventListener(MouseEvent.CLICK, onClickP1);
				playerCard1.buttonMode = true; 
				playerCard1.mouseChildren = false;
				addChild(playerCard1);
			}
			else if (cardArray.length==2)
			{
				computerCard1.addChild(cardArray[cardArray.length-1]);
				addChild(computerCard1);
				addChild(downCardArray[(cardArray.length/2)-1]);
			}
			else if (cardArray.length==3 || cardNumber==2)
			{
				playerCard2.addChild(cardArray[cardArray.length-1]);
				playerCard2.addEventListener(MouseEvent.CLICK, onClickP2);
				playerCard2.buttonMode = true; 
				playerCard2.mouseChildren = false;
				addChild(playerCard2);
			}
			else if (cardArray.length==4)
			{
				computerCard2.addChild(cardArray[cardArray.length-1]);
				addChild(computerCard2);
				addChild(downCardArray[(cardArray.length/2)-1]);
			}
			else if (cardArray.length==5 || cardNumber==3)
			{
				playerCard3.addChild(cardArray[cardArray.length-1]);
				playerCard3.addEventListener(MouseEvent.CLICK, onClickP3);
				playerCard3.buttonMode = true; 
				playerCard3.mouseChildren = false;
				addChild(playerCard3);
			}
			else if (cardArray.length==6)
			{
				computerCard3.addChild(cardArray[cardArray.length-1]);
				addChild(computerCard3);
				addChild(downCardArray[(cardArray.length/2)-1]);
			}
			else if (cardArray.length==7 || cardNumber==4)
			{
				playerCard4.addChild(cardArray[cardArray.length-1]);
				playerCard4.addEventListener(MouseEvent.CLICK, onClickP4);
				playerCard4.buttonMode = true; 
				playerCard4.mouseChildren = false;
				addChild(playerCard4);
			}
			else if (cardArray.length==8)
			{
				computerCard4.addChild(cardArray[cardArray.length-1]);
				addChild(computerCard4);
				addChild(downCardArray[(cardArray.length/2)-1]);
			}
			else if (cardArray.length==9 || cardNumber==5)
			{
				playerCard5.addChild(cardArray[cardArray.length-1]);
				playerCard5.addEventListener(MouseEvent.CLICK, onClickP5);
				playerCard5.buttonMode = true; 
				playerCard5.mouseChildren = false;
				addChild(playerCard5);
			}
			else if (cardArray.length==10)
			{
				computerCard5.addChild(cardArray[cardArray.length-1]);
				addChild(computerCard5);
				addChild(downCardArray[(cardArray.length/2)-1]);
			}
		}
		
		private function onClickP1(event:MouseEvent):void {
			if (playerCard1.alpha==1)
			{
				playerCard1.alpha=.75;
				playerCard1.y-=20;
			}
			else if (playerCard1.alpha==.75)
			{
				playerCard1.alpha=1;
				playerCard1.y+=20;
			}
		}
		
		private function onClickP2(event:MouseEvent):void {
			if (playerCard2.alpha==1)
			{
				playerCard2.alpha=.75;
				playerCard2.y-=20;
			}
			else if (playerCard2.alpha==.75)
			{
				playerCard2.alpha=1;
				playerCard2.y+=20;
			}
		}
		
		private function onClickP3(event:MouseEvent):void {
			if (playerCard3.alpha==1)
			{
				playerCard3.alpha=.75;
				playerCard3.y-=20;
			}
			else if (playerCard3.alpha==.75)
			{
				playerCard3.alpha=1;
				playerCard3.y+=20;
			}
		}
		
		private function onClickP4(event:MouseEvent):void {
			if (playerCard4.alpha==1)
			{
				playerCard4.alpha=.75;
				playerCard4.y-=20;
			}
			else if (playerCard4.alpha==.75)
			{
				playerCard4.alpha=1;
				playerCard4.y+=20;
			}
		}
		
		private function onClickP5(event:MouseEvent):void {
			if (playerCard5.alpha==1)
			{
				playerCard5.alpha=.75;
				playerCard5.y-=20;
			}
			else if (playerCard5.alpha==.75)
			{
				playerCard5.alpha=1;
				playerCard5.y+=20;
			}
		}
		
		public function exchangePlayerCards():void{
			cardTimer.start();
			cardTimer.addEventListener(TimerEvent.TIMER, exchangePlayerSleep);
		}
		
		private function exchangePlayerSleep(e:TimerEvent):void{
			if (cardTimer.currentCount==1){
				nameplates.playDealPlayerCard();
				if (playerCard1.y==-20){
					removeChild(playerCard1)
					counter++;
					cardNumber=1;
					playerCard1.y=0;
					playerCard1.alpha=1;
					currentCard=Math.floor(Math.random()*(52-counter));
					playerArray[0]=(imagesArray[currentCard]);
					loader3.load(new URLRequest(imagesArray[currentCard]));	
					loader3.contentLoaderInfo.addEventListener(Event.COMPLETE, loadOne);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(playerCard1);
					addChild(playerCard1);
				}
			}
			else if (cardTimer.currentCount==2){
				nameplates.playDealPlayerCard();
				if (playerCard2.y==-20){
					removeChild(playerCard2)
					counter++;
					cardNumber=2;
					playerCard2.y=0;
					playerCard2.alpha=1;
					currentCard=Math.floor(Math.random()*(52-counter));
					playerArray[1]=(imagesArray[currentCard]);
					loader4.load(new URLRequest(imagesArray[currentCard]));	
					loader4.contentLoaderInfo.addEventListener(Event.COMPLETE, loadTwo);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(playerCard2);
					addChild(playerCard2);
				}
			}
			if (cardTimer.currentCount==3){
				nameplates.playDealPlayerCard();
				if (playerCard3.y==-20){
					removeChild(playerCard3)
					counter++;
					cardNumber=3;
					playerCard3.y=0;
					playerCard3.alpha=1;
					currentCard=Math.floor(Math.random()*(52-counter));
					playerArray[2]=(imagesArray[currentCard]);
					loader5.load(new URLRequest(imagesArray[currentCard]));	
					loader5.contentLoaderInfo.addEventListener(Event.COMPLETE, loadThree);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(playerCard3);
					addChild(playerCard3);
				}
			}
			if (cardTimer.currentCount==4){
				nameplates.playDealPlayerCard();
				if (playerCard4.y==-20){
					removeChild(playerCard4)
					counter++;
					cardNumber=4;
					playerCard4.y=0;
					playerCard4.alpha=1;
					currentCard=Math.floor(Math.random()*(52-counter));
					playerArray[3]=(imagesArray[currentCard]);
					loader6.load(new URLRequest(imagesArray[currentCard]));	
					loader6.contentLoaderInfo.addEventListener(Event.COMPLETE, loadFour);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(playerCard4);
					addChild(playerCard4);
				}
			}
			if (cardTimer.currentCount==5){
				nameplates.playDealPlayerCard();
				if (playerCard5.y==-20){
					removeChild(playerCard5)
					counter++;
					cardNumber=5;
					playerCard5.y=0;
					playerCard5.alpha=1;
					currentCard=Math.floor(Math.random()*(52-counter));
					playerArray[4]=(imagesArray[currentCard]);
					loader7.load(new URLRequest(imagesArray[currentCard]));	
					loader7.contentLoaderInfo.addEventListener(Event.COMPLETE, loadFive);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(playerCard5);
					addChild(playerCard5);
				}
			}
			if (cardTimer.currentCount==6){
				removeChild(nameplates);
				addChild(nameplates);
				cardTimer.reset();
				if (!firstDraw){
					firstDraw=true;
					FiveCardDraw.gameplay.drawPhase2();
				}
				else{
					FiveCardDraw.gameplay.postDrawBetting();
				}
			}
		}
		
		public function loadOne(event:Event):void
		{
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 47 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			playerCard1.removeChildren(0);
			playerCard1.addChild(cardArray[cardArray.length-1]);
			addChild(playerCard1);
		}
		
		public function loadTwo(event:Event):void
		{	
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 47 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			playerCard2.removeChildren(0);
			playerCard2.addChild(cardArray[cardArray.length-1]);
			addChild(playerCard2);
		}
		
		public function loadThree(event:Event):void
		{	
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 47 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			playerCard3.removeChildren(0);
			playerCard3.addChild(cardArray[cardArray.length-1]);
			addChild(playerCard3);
		}
		
		public function loadFour(event:Event):void
		{	
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 47 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			playerCard4.removeChildren(0);
			playerCard4.addChild(cardArray[cardArray.length-1]);
			addChild(playerCard4);
		}
		
		public function loadFive(event:Event):void
		{	
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 47 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			playerCard5.removeChildren(0);
			playerCard5.addChild(cardArray[cardArray.length-1]);
			addChild(playerCard5);
		}
		
		public function exchangeComputerCards():void{
			cardTimer2.start();
			cardTimer2.addEventListener(TimerEvent.TIMER, exchangeComputerSleep);
		}
		
		private function exchangeComputerSleep(e:TimerEvent):void{
			if (cardTimer2.currentCount==1){
				var rand:Number=Math.random();
				if (rand>.4){
					computerCard1.y-=20;
					downCardArray[0].y-=20;
				}
				rand=Math.random();
				if (rand>.4){
					computerCard2.y-=20;
					downCardArray[1].y-=20;
				}
				rand=Math.random();
				if (rand>.4){
					computerCard3.y-=20;
					downCardArray[2].y-=20;
				}
				rand=Math.random();
				if (rand>.4){
					computerCard4.y-=20;
					downCardArray[3].y-=20;
				}
				rand=Math.random();
				if (rand>.4){
					computerCard5.y-=20;
					downCardArray[4].y-=20;
				}
				removeChild(computerCard1);
				removeChild(downCardArray[0]);
				addChild(computerCard1);
				addChild(downCardArray[0]);
				removeChild(computerCard2);
				removeChild(downCardArray[1]);
				addChild(computerCard2);
				addChild(downCardArray[1]);
				removeChild(computerCard3);
				removeChild(downCardArray[2]);
				addChild(computerCard3);
				addChild(downCardArray[2]);
				removeChild(computerCard4);
				removeChild(downCardArray[3]);
				addChild(computerCard4);
				addChild(downCardArray[3]);
				removeChild(computerCard5);
				removeChild(downCardArray[4]);
				addChild(computerCard5);
				addChild(downCardArray[4]);
				removeChild(nameplates);
				addChild(nameplates);
			}
			if (cardTimer2.currentCount==16){
				nameplates.playDealPlayerCard();
				if (computerCard1.y==-20 || true){
					removeChild(computerCard1)
					removeChild(downCardArray[0]);
					counter++;
					cardNumber=1;
					computerCard1.y=0;
					downCardArray[0].y=300;
					computerCard1.alpha=1;
					currentCard=Math.floor(Math.random()*(52-counter));
					computerArray[0]=(imagesArray[currentCard]);
					loader8.load(new URLRequest(imagesArray[currentCard]));	
					loader8.contentLoaderInfo.addEventListener(Event.COMPLETE, loadSix);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(computerCard1);
					removeChild(downCardArray[0]);
					addChild(computerCard1);
					addChild(downCardArray[0]);
				}
			}
			else if (cardTimer2.currentCount==17){
				nameplates.playDealPlayerCard();
				if (computerCard2.y==-20 || true){
					removeChild(computerCard2)
					removeChild(downCardArray[1]);
					counter++;
					cardNumber=2;
					computerCard2.y=0;
					downCardArray[1].y=300;
					computerCard2.alpha=1;
					currentCard=Math.floor(Math.random()*(52-counter));
					computerArray[1]=(imagesArray[currentCard]);
					loader9.load(new URLRequest(imagesArray[currentCard]));	
					loader9.contentLoaderInfo.addEventListener(Event.COMPLETE, loadSeven);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(computerCard2);
					removeChild(downCardArray[1]);
					addChild(computerCard2);
					addChild(downCardArray[1]);
				}
			}
			else if (cardTimer2.currentCount==18){
				nameplates.playDealPlayerCard();
				if (computerCard3.y==-20 || true){
					removeChild(computerCard3)
					removeChild(downCardArray[2]);
					counter++;
					cardNumber=3;
					computerCard3.y=0;
					downCardArray[2].y=300;
					computerCard3.alpha=1;
					currentCard=Math.floor(Math.random()*(52-counter));
					computerArray[2]=(imagesArray[currentCard]);
					loader10.load(new URLRequest(imagesArray[currentCard]));	
					loader10.contentLoaderInfo.addEventListener(Event.COMPLETE, loadEight);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(computerCard3);
					removeChild(downCardArray[2]);
					addChild(computerCard3);
					addChild(downCardArray[2]);
				}
			}
			else if (cardTimer2.currentCount==19){
				nameplates.playDealPlayerCard();
				if (computerCard4.y==-20 || true){
					removeChild(computerCard4)
					removeChild(downCardArray[3]);
					counter++;
					cardNumber=4;
					computerCard4.y=0;
					downCardArray[3].y=300;
					computerCard4.alpha=1;
					currentCard=Math.floor(Math.random()*(52-counter));
					computerArray[3]=(imagesArray[currentCard]);
					loader11.load(new URLRequest(imagesArray[currentCard]));	
					loader11.contentLoaderInfo.addEventListener(Event.COMPLETE, loadNine);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(computerCard4);
					removeChild(downCardArray[3]);
					addChild(computerCard4);
					addChild(downCardArray[3]);
				}
			}
			else if (cardTimer2.currentCount==20){
				nameplates.playDealPlayerCard();
				if (computerCard5.y==-20 || true){
					removeChild(computerCard5)
					removeChild(downCardArray[4]);
					counter++;
					cardNumber=5;
					computerCard5.y=0;
					downCardArray[4].y=300;
					computerCard5.alpha=5;
					currentCard=Math.floor(Math.random()*(52-counter));
					computerArray[4]=(imagesArray[currentCard]);
					loader12.load(new URLRequest(imagesArray[currentCard]));	
					loader12.contentLoaderInfo.addEventListener(Event.COMPLETE, loadTen);
					imagesArray.splice(currentCard, 1);
				}
				else{
					removeChild(computerCard5);
					removeChild(downCardArray[4]);
					addChild(computerCard5);
					addChild(downCardArray[4]);
				}
			}
			if (cardTimer2.currentCount==21){
				removeChild(nameplates);
				addChild(nameplates);
				cardTimer2.reset();
				if (!firstDraw){
					firstDraw=true;
					FiveCardDraw.gameplay.drawPhase2();
				}
				else{
					FiveCardDraw.gameplay.postDrawBetting();
				}
			}
		}
		
		public function loadSix(event:Event):void
		{
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 747 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			computerCard1.removeChildren(0);
			computerCard1.addChild(cardArray[cardArray.length-1]);
			addChild(computerCard1);
			addChild(downCardArray[0]);
		}
		
		public function loadSeven(event:Event):void
		{	
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 747 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			computerCard2.removeChildren(0);
			computerCard2.addChild(cardArray[cardArray.length-1]);
			addChild(computerCard2);
			addChild(downCardArray[1]);
		}
		
		public function loadEight(event:Event):void
		{	
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 747 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			computerCard3.removeChildren(0);
			computerCard3.addChild(cardArray[cardArray.length-1]);
			addChild(computerCard3);
			addChild(downCardArray[2]);
		}
		
		public function loadNine(event:Event):void
		{	
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 747 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			computerCard4.removeChildren(0);
			computerCard4.addChild(cardArray[cardArray.length-1]);
			addChild(computerCard4);
			addChild(downCardArray[3]);
		}
		
		public function loadTen(event:Event):void
		{	
			cardArray.push(event.target.content);
			cardArray[cardArray.length-1].x = 747 + cardNumber * 16;
			cardArray[cardArray.length-1].y = 300;
			computerCard5.removeChildren(0);
			computerCard5.addChild(cardArray[cardArray.length-1]);
			addChild(computerCard5);
			addChild(downCardArray[4]);
		}
		
		public function removeDownCards():void
		{
			for (var i:int=0; i<5; i++){
				removeChild(downCardArray[i]);
			}
		}
		
		public function awardWinner():int
		{
			for (var i:int=0; i<5; i++){
				trace(playerArray[i],computerArray[i]);
			}
			if (playerArray[0].substring(2,3)==".")
			{
				p1Num=playerArray[0].substring(1,2);
			}
			else
			{
				p1Num=playerArray[0].substring(1,3);
			}
			p1Suit=playerArray[0].substring(0,1);
			
			if (playerArray[1].substring(2,3)==".")
			{
				p2Num=playerArray[1].substring(1,2);
			}
			else
			{
				p2Num=playerArray[1].substring(1,3);
			}
			p2Suit=playerArray[1].substring(0,1);
			
			if (playerArray[2].substring(2,3)==".")
			{
				p3Num=playerArray[2].substring(1,2);
			}
			else
			{
				p3Num=playerArray[2].substring(1,3);
			}
			p3Suit=playerArray[2].substring(0,1);
			
			if (playerArray[3].substring(2,3)==".")
			{
				p4Num=playerArray[3].substring(1,2);
			}
			else
			{
				p4Num=playerArray[3].substring(1,3);
			}
			p4Suit=playerArray[3].substring(0,1);
			
			if (playerArray[4].substring(2,3)==".")
			{
				p5Num=playerArray[4].substring(1,2);
			}
			else
			{
				p5Num=playerArray[4].substring(1,3);
			}
			p5Suit=playerArray[4].substring(0,1);
			
			if (computerArray[0].substring(2,3)==".")
			{
				c1Num=computerArray[0].substring(1,2);
			}
			else
			{
				c1Num=computerArray[0].substring(1,3);
			}
			c1Suit=computerArray[0].substring(0,1);
			
			if (computerArray[1].substring(2,3)==".")
			{
				c2Num=computerArray[1].substring(1,2);
			}
			else
			{
				c2Num=computerArray[1].substring(1,3);
			}
			c2Suit=computerArray[1].substring(0,1);
			
			if (computerArray[2].substring(2,3)==".")
			{
				c3Num=computerArray[2].substring(1,2);
			}
			else
			{
				c3Num=computerArray[2].substring(1,3);
			}
			c3Suit=computerArray[2].substring(0,1);
			
			if (computerArray[3].substring(2,3)==".")
			{
				c4Num=computerArray[3].substring(1,2);
			}
			else
			{
				c4Num=computerArray[3].substring(1,3);
			}
			c4Suit=computerArray[3].substring(0,1);
			
			if (computerArray[4].substring(2,3)==".")
			{
				c5Num=computerArray[4].substring(1,2);
			}
			else
			{
				c5Num=computerArray[4].substring(1,3);
			}
			c5Suit=computerArray[4].substring(0,1);
			trace(p1Num, p1Suit, p2Num, p2Suit, p3Num, p3Suit, p4Num, p4Suit, p5Num, p5Suit, c1Num, c1Suit, c2Num, c2Suit, c3Num, c3Suit, c4Num, c4Suit, c5Num, c5Suit);
			
			return compareHands();
		}
		
		public function compareHands():int
		{
			var playerNums:Array=new Array(p1Num, p2Num, p3Num, p4Num, p5Num);
			var computerNums:Array=new Array(c1Num, c2Num, c3Num, c4Num, c5Num);
			var playerSuits:Array=new Array(p1Suit, p2Suit, p3Suit, p4Suit, p5Suit);
			var computerSuits:Array=new Array(p1Suit, p2Suit, p3Suit, p4Suit, p5Suit);
			playerNums.sort(Array.NUMERIC);
			computerNums.sort(Array.NUMERIC);
			trace(playerNums[0],playerNums[1],playerNums[2],playerNums[3],playerNums[4]);
			trace(computerNums[0],computerNums[1],computerNums[2],computerNums[3],computerNums[4]);
			var playerRank:int=0;
			var computerRank:int=0;
			if (playerNums[0]==1 && playerNums[4]==13 && playerNums[4]==playerNums[3]+1 && playerNums[3]==playerNums[2]+1 && playerNums[2]==playerNums[1]+1 && (playerSuits[0]==playerSuits[1] && playerSuits[1]==playerSuits[2] && playerSuits[2]==playerSuits[3] && playerSuits[3]==playerSuits[4])){
				playerRank=10;
				trace("royal flush");
			}
			else if (playerNums[4]==playerNums[3]+1 && playerNums[3]==playerNums[2]+1 && playerNums[2]==playerNums[1]+1 && playerNums[1]==playerNums[0]+1 && (playerSuits[0]==playerSuits[1] && playerSuits[1]==playerSuits[2] && playerSuits[2]==playerSuits[3] && playerSuits[3]==playerSuits[4])){
				playerRank=9;
				trace("straight flush");
			}
			else if ((playerNums[4]==playerNums[3] && playerNums[3]==playerNums[2] && playerNums[2]==playerNums[1]) || (playerNums[3]==playerNums[2] && playerNums[2]==playerNums[1] && playerNums[1]==playerNums[0]))
			{
				playerRank=8;
				trace("quads");
			}
			else if ((playerNums[4]==playerNums[3] && playerNums[3]==playerNums[2] && playerNums[1]==playerNums[0]) || (playerNums[4]==playerNums[3] && playerNums[2]==playerNums[1] && playerNums[1]==playerNums[0]))
			{
				playerRank=7;
				trace("full house");
			}
			else if (playerSuits[0]==playerSuits[1] && playerSuits[1]==playerSuits[2] && playerSuits[2]==playerSuits[3] && playerSuits[3]==playerSuits[4])
			{
				playerRank=6;
				trace("flush");
			}
			else if ((playerNums[4]==playerNums[3]+1 && playerNums[3]==playerNums[2]+1 && playerNums[2]==playerNums[1]+1 && playerNums[1]==playerNums[0]+1) || (playerNums[0]==1 && playerNums[4]==13 && playerNums[4]==playerNums[3]+1 && playerNums[3]==playerNums[2]+1 && playerNums[2]==playerNums[1]+1))
			{
				playerRank=5;
				trace("straight");
			}
			else if ((playerNums[4]==playerNums[3] && playerNums[3]==playerNums[2]) || (playerNums[3]==playerNums[2] && playerNums[2]==playerNums[1]) || (playerNums[2]==playerNums[1] && playerNums[1]==playerNums[0]))
			{
				playerRank=4;
				trace("trips");
			}
			else if ((playerNums[4]==playerNums[3] && playerNums[2]==playerNums[1]) || (playerNums[4]==playerNums[3] && playerNums[1]==playerNums[0]) || (playerNums[3]==playerNums[2] && playerNums[1]==playerNums[0]))
			{
				playerRank=3;
				trace("two pair");
			}
			else if (playerNums[4]==playerNums[3] || playerNums[3]==playerNums[2] || playerNums[2]==playerNums[1] || playerNums[1]==playerNums[0])
			{
				playerRank=2;
				trace("pair");
			}
			else{
				playerRank=1;
				trace("high card");
			}
			
			if (computerNums[0]==1 && computerNums[4]==13 && computerNums[4]==computerNums[3]+1 && computerNums[3]==computerNums[2]+1 && computerNums[2]==computerNums[1]+1 && (computerSuits[0]==computerSuits[1] && computerSuits[1]==computerSuits[2] && computerSuits[2]==computerSuits[3] && computerSuits[3]==computerSuits[4])){
				computerRank=10;
				trace("royal flush");
			}
			else if (computerNums[4]==computerNums[3]+1 && computerNums[3]==computerNums[2]+1 && computerNums[2]==computerNums[1]+1 && computerNums[1]==computerNums[0]+1 && (computerSuits[0]==computerSuits[1] && computerSuits[1]==computerSuits[2] && computerSuits[2]==computerSuits[3] && computerSuits[3]==computerSuits[4])){
				computerRank=9;
				trace("straight flush");
			}
			else if ((computerNums[4]==computerNums[3] && computerNums[3]==computerNums[2] && computerNums[2]==computerNums[1]) || (computerNums[3]==computerNums[2] && computerNums[2]==computerNums[1] && computerNums[1]==computerNums[0]))
			{
				computerRank=8;
				trace("quads");
			}
			else if ((computerNums[4]==computerNums[3] && computerNums[3]==computerNums[2] && computerNums[1]==computerNums[0]) || (computerNums[4]==computerNums[3] && computerNums[2]==computerNums[1] && computerNums[1]==computerNums[0]))
			{
				computerRank=7;
				trace("full house");
			}
			else if (computerSuits[0]==computerSuits[1] && computerSuits[1]==computerSuits[2] && computerSuits[2]==computerSuits[3] && computerSuits[3]==computerSuits[4])
			{
				computerRank=6;
				trace("flush");
			}
			else if ((computerNums[4]==computerNums[3]+1 && computerNums[3]==computerNums[2]+1 && computerNums[2]==computerNums[1]+1 && computerNums[1]==computerNums[0]+1) || (computerNums[0]==1 && computerNums[4]==13 && computerNums[4]==computerNums[3]+1 && computerNums[3]==computerNums[2]+1 && computerNums[2]==computerNums[1]+1))
			{
				computerRank=5;
				trace("straight");
			}
			else if ((computerNums[4]==computerNums[3] && computerNums[3]==computerNums[2]) || (computerNums[3]==computerNums[2] && computerNums[2]==computerNums[1]) || (computerNums[2]==computerNums[1] && computerNums[1]==computerNums[0]))
			{
				computerRank=4;
				trace("trips");
			}
			else if ((computerNums[4]==computerNums[3] && computerNums[2]==computerNums[1]) || (computerNums[4]==computerNums[3] && computerNums[1]==computerNums[0]) || (computerNums[3]==computerNums[2] && computerNums[1]==computerNums[0]))
			{
				computerRank=3;
				trace("two pair");
			}
			else if (computerNums[4]==computerNums[3] || computerNums[3]==computerNums[2] || computerNums[2]==computerNums[1] || computerNums[1]==computerNums[0])
			{
				computerRank=2;
				trace("pair");
			}
			else{
				computerRank=1;
				trace("high card");
			}
			if (playerRank>computerRank){
				return 1;
			}
			else if (playerRank<computerRank){
				return 2;
			}
			else if (playerRank==computerRank){
				if (computerRank==9){
					if (computerNums[4]<playerNums[4]){
						return 1;
					}
					else if (computerNums[4]>playerNums[4]){
						return 2;
					}
				}
				else if (computerRank==8){
					if (computerNums[2]<playerNums[2]){
						return 1;
					}
					else if (computerNums[2]>playerNums[2]){
						return 2;
					}
				}
				else if (computerRank==7){
					if (computerNums[2]<playerNums[2]){
						return 1;
					}
					else if (computerNums[2]>playerNums[2]){
						return 2;
					}
				}
				else if (computerRank==6){
					if (computerNums[4]<playerNums[4] || (playerNums[0]==1 && computerNums[0]!=1)){
						return 1;
					}
					else if (computerNums[4]>playerNums[4] || (computerNums[0]==1 && playerNums[0]!=1)){
						return 2;
					}
				}
				else if (computerRank==5){
					if (computerNums[0]<playerNums[0] || (playerNums[0]==1 && computerNums[0]!=1)){
						return 1;
					}
					else if (computerNums[0]>playerNums[0] || (computerNums[0]==1 && playerNums[0]!=1)){
						return 2;
					}
				}
				else if (computerRank==4){
					if (computerNums[2]<playerNums[2]){
						return 1;
					}
					else if (computerNums[2]>playerNums[2]){
						return 2;
					}
				}
				else if (computerRank==3){
					if (computerNums[0]==computerNums[1] && computerNums[0]===1){
						cPair=computerNums[0];
						cPair2=computerNums[3];
					}
					else if (computerNums[4]==computerNums[3] || computerNums[2]==computerNums[3]){
						cPair=computerNums[3];
						cPair2=computerNums[1];
					}
					if (computerNums[4]==computerNums[3] && computerNums[2]==computerNums[1]){
						cExtra=computerNums[0];
					}
					else if (computerNums[4]==computerNums[3] && computerNums[1]==computerNums[0]){
						cExtra=computerNums[2];
					}
					else if (computerNums[3]==computerNums[2] && computerNums[1]==computerNums[0]){
						cExtra=computerNums[4];
					}
					if (playerNums[0]==playerNums[1] && playerNums[0]===1){
						pPair=playerNums[0];
						pPair2=playerNums[3];
					}
					else if (playerNums[4]==playerNums[3] || playerNums[2]==playerNums[3]){
						pPair=playerNums[3];
						pPair2=playerNums[1];
					}
					if (playerNums[4]==playerNums[3] && playerNums[2]==playerNums[1]){
						pExtra=playerNums[0];
					}
					else if (playerNums[4]==playerNums[3] && playerNums[1]==playerNums[0]){
						pExtra=playerNums[2];
					}
					else if (playerNums[3]==playerNums[2] && playerNums[1]==playerNums[0]){
						pExtra=playerNums[4];
					}
					if (cPair<pPair || (pPair==1 && cPair!=1)){
						return 1;
					}
					else if (cPair>pPair || (cPair==1 && pPair!=1)){
						return 2;
					}
					else{
						if (cPair2<pPair2 || (pPair2==1 && cPair2!=1)){
							return 1;
						}
						else if (cPair2>pPair2 || (cPair2==1 && pPair2!=1)){
							return 2;
						}
						else{
							if (cExtra<pExtra || (pExtra==1 && cExtra!=1)){
								return 1;
							}
							else if (cExtra>pExtra || (cExtra==1 && pExtra!=1)){
								return 2;
							}
						}
					}
				}
				else if (computerRank==2){
					var cExtras:Array = new Array();
					var pExtras:Array = new Array();
					if (computerNums[4]==computerNums[3]){
						cPair=computerNums[3];
						cExtras.push(computerNums[0]);
						cExtras.push(computerNums[1]);
						cExtras.push(computerNums[2]);
					}
					else if (computerNums[2]==computerNums[3]){
						cPair=computerNums[3];
						cExtras.push(computerNums[0]);
						cExtras.push(computerNums[1]);
						cExtras.push(computerNums[4]);
					}
					else if (computerNums[2]==computerNums[1]){
						cPair=computerNums[1];
						cExtras.push(computerNums[0]);
						cExtras.push(computerNums[3]);
						cExtras.push(computerNums[4]);
					}
					else if (computerNums[1]==computerNums[0]){
						cPair=computerNums[1];
						cExtras.push(computerNums[2]);
						cExtras.push(computerNums[3]);
						cExtras.push(computerNums[4]);
					}
					if (playerNums[4]==playerNums[3]){
						pPair=playerNums[3];
						pExtras.push(playerNums[0]);
						pExtras.push(playerNums[1]);
						pExtras.push(playerNums[2]);
					}
					else if (playerNums[2]==playerNums[3]){
						pPair=playerNums[3];
						pExtras.push(playerNums[0]);
						pExtras.push(playerNums[1]);
						pExtras.push(playerNums[4]);
					}
					else if (playerNums[2]==playerNums[1]){
						pPair=playerNums[1];
						pExtras.push(playerNums[0]);
						pExtras.push(playerNums[3]);
						pExtras.push(playerNums[4]);
					}
					else if (playerNums[1]==playerNums[0]){
						pPair=playerNums[1];
						pExtras.push(playerNums[2]);
						pExtras.push(playerNums[3]);
						pExtras.push(playerNums[4]);
					}
					if (cPair<pPair || (pPair==1 && cPair!=1)){
						return 1;
					}
					else if (cPair>pPair || (cPair==1 && pPair!=1)){
						return 2;
					}
					else{
						if (cExtras[2]<pExtras[2] || (pExtras[0]==1 && cExtras[0]!=1)){
							return 1;
						}
						else if (cExtras[2]>pExtras[2] || (cExtras[0]==1 && pExtras[0]!=1)){
							return 2;
						}
						else{
							if (cExtras[1]<pExtras[1]){
								return 1;
							}
							else if (cExtras[1]>pExtras[1]){
								return 2;
							}
							else{
								if (cExtras[0]<pExtras[0]){
									return 1;
								}
								else if (cExtras[0]>pExtras[0]){
									return 2;
								}
							}
						}
					}
				}
				else if (computerRank==1){
					if (playerNums[0]==1 && computerNums[0]!=1){
						return 1;
					}
					else if (playerNums[0]!=1 && computerNums[0]==1){
						return 2;
					} 
					else if (computerNums[4]<playerNums[4]){
						return 1;
					}
					else if (computerNums[4]>playerNums[4]){
						return 2;
					}
					else{
						if (computerNums[3]<playerNums[3]){
							return 1;
						}
						else if (computerNums[3]>playerNums[3]){
							return 2;
						}
						else{
							if (computerNums[2]<playerNums[2]){
								return 1;
							}
							else if (computerNums[2]>playerNums[2]){
								return 2;
							}
							else{
								if (computerNums[1]<playerNums[1]){
									return 1;
								}
								else if (computerNums[1]>playerNums[1]){
									return 2;
								}
								else{
									if (computerNums[0]<playerNums[0]){
										return 1;
									}
									else if (computerNums[0]>playerNums[0]){
										return 2;
									}
								}
							}
						}
					}
				}
			}
			return 3;
		}
	}
}