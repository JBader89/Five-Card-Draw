package
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.*;
	import flash.utils.Timer;
		
	public class Chips extends Sprite
	{
		private var loader:Loader=new Loader();
		private var dealerButton:Loader=new Loader();
		private var thousandChip:Loader=new Loader();
		private var fiveHundredChip:Loader=new Loader();
		private var hundredChip:Loader=new Loader();
		private var twentyFiveChip:Loader=new Loader();
		private var fiveChip:Loader=new Loader();
		private var oneChip:Loader=new Loader();
		
		private var imagesArray:Array=new Array("dealerButton.gif", "chip_1white.gif", "chip_5red.gif", "chip_25green.gif", "chip_100black.gif", "chip_500pink.gif", "chip_1000blue.gif");
		private var chipArray:Array=new Array();
		private var newButton:Array=new Array();
		
		private var playerStack:Sprite=new Sprite();
		private var computerStack:Sprite=new Sprite();
		private var potStack:Sprite=new Sprite();
		private var foldButton:Sprite=new Sprite();
		private var checkButton:Sprite=new Sprite();
		private var callButton:Sprite=new Sprite();
		private var betButton:Sprite=new Sprite();
		private var raiseButton:Sprite=new Sprite();
		private var drawButton:Sprite=new Sprite();
		
		private var blindsTimer:Timer=new Timer(100);
		private var betTimer:Timer=new Timer(100);
		private var betTimer2:Timer=new Timer(100);
		private var potTimer:Timer=new Timer(100);
		private var potMoveTimer:Timer=new Timer(100);
		
		private var button:int=Math.floor(Math.random()*2)+1;
		private var stackShift:int = 0;
		private var stackHeight:int = 0;
		public var playerBet:int=0;
		public var computerBet:int=0;
		public var potBet:int=0;
		public var playerScore:int=2000;
		public var computerScore:int=2000;
		public var potMove:int=0;
		
		private var leftLimit:Number = 700;
		private var scrollerRange:Number = 100;
		private var rightLimit:Number = 700 + scrollerRange;
		private var scrollPercent:Number = 0;
		private var xOffset:Number = 0;
		
		private var playerTurn:Boolean;
		private var preDraw:Boolean=true;
		private var checked:Boolean=false;
		
		public var scroller:Sprite=new Sprite();

		private var scores:Environment=new Environment;
		private var newCards:Cards=new Cards;
		
		public function Chips()
		{
			var request:URLRequest=new URLRequest(imagesArray[0]);
			dealerButton.load(request);
			var request2:URLRequest=new URLRequest(imagesArray[1]);
			oneChip.load(request2);
			var request3:URLRequest=new URLRequest(imagesArray[2]);
			fiveChip.load(request3);
			var request4:URLRequest=new URLRequest(imagesArray[3]);
			twentyFiveChip.load(request4);
			var request5:URLRequest=new URLRequest(imagesArray[4]);
			hundredChip.load(request5);
			var request6:URLRequest=new URLRequest(imagesArray[5]);
			fiveHundredChip.load(request6);
			var request7:URLRequest=new URLRequest(imagesArray[6]);
			thousandChip.load(request7);
			addChild(playerStack);
			addChild(computerStack);
			addChild(potStack);
			scores.writeHandles();
			addChild(scores);
		}
		
		public function makeButton():void{
			loader.load(new URLRequest(imagesArray[0]));	
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadButton);
		}
		
		public function loadButton(event:Event):void
		{	
			newButton.push(event.target.content);
			if (button==1){
				playerTurn=true;
				newButton[newButton.length-1].x = 215;
				button = 2;
			}
			else if (button==2){
				playerTurn=false;
				newButton[newButton.length-1].x = 720;
				button = 1;
			}
			newButton[newButton.length-1].y = 365;
			addChild(newButton[newButton.length-1]);
		}
		
		public function drawBlinds():void{
			blindsTimer.start();
			blindsTimer.addEventListener(TimerEvent.TIMER, blindsSleep);
		}
		
		private function blindsSleep(e:TimerEvent):void{
			if (blindsTimer.currentCount==10){
				if (button==1){
					displayChips(10, 2);
					scores.playBet();
				}
				else if (button==2){
					displayChips(10, 0);
					scores.playBet();
				}
			}
			else if (blindsTimer.currentCount==11){
				if (button==1){
					displayChips(20, 0);
					scores.playBet();
				}
				else if (button==2){
					displayChips(20, 2);
					scores.playBet();
				}
				blindsTimer.reset();
				preDrawBetting();
			}
		}
		
		public function drawActions():void{
			if (preDraw){
				drawFold();
				drawCall();
				drawRaise();
			}
			else{
				if (playerBet==computerBet && playerBet==0){
					drawCheck();
					drawBet();
				}
				else if (playerBet<computerBet){
					drawFold();
					drawCall();
					drawRaise();
				}
			}
			//drawScrollbar();
		}
		
		public function hideActions():void{
			if (preDraw){
				removeChild(foldButton);
				removeChild(callButton);
				removeChild(raiseButton);
			}
			else{
				if (computerBet==0){
					removeChild(checkButton);
					removeChild(betButton);
				}
				else{
					removeChild(foldButton);
					removeChild(callButton);
					removeChild(raiseButton);
				}
			}
			//removeChild(scroller);
		}
		
		public function hideDraw():void{
			removeChild(drawButton);
		}
		
		public function drawFold():void{
			addChild(foldButton);
			foldButton.graphics.lineStyle(4,0x7D7A7B);
			foldButton.graphics.beginFill(0xA3A2A2);
			foldButton.graphics.drawRoundRect(670,570,80,40,20,20);
			foldButton.graphics.endFill();
			foldButton.buttonMode = true;
			foldButton.mouseChildren = false;
			foldButton.addEventListener(MouseEvent.MOUSE_OVER, onFoldHover);
			foldButton.addEventListener(MouseEvent.MOUSE_OUT, onFoldOut);
			foldButton.addEventListener(MouseEvent.MOUSE_DOWN, onFold);
			
			var myFormat:TextFormat=new TextFormat();
			myFormat.size=20;
			myFormat.font="Geneva";
			myFormat.align=TextFormatAlign.CENTER;
			
			var fold:TextField=new TextField; 
			fold.textColor=0xFFFFFF;
			fold.x=660;
			fold.y=575;
			fold.defaultTextFormat=myFormat;
			fold.text="Fold";
			foldButton.addChild(fold);
		}
		
		private function onFoldHover(event:MouseEvent):void {
			foldButton.alpha=.5;
		}
		
		private function onFoldOut(event:MouseEvent):void {
			foldButton.alpha=1;
		}
		
		private function onFold(event:MouseEvent):void {
			scores.playFold();
			playerTurn=false;
			hideActions();
			makePot();
		}
		
		public function drawCheck():void{
			addChild(checkButton);
			checkButton.graphics.lineStyle(4,0x7D7A7B);
			checkButton.graphics.beginFill(0xA3A2A2);
			checkButton.graphics.drawRoundRect(670,570,80,40,20,20);
			checkButton.graphics.endFill();
			checkButton.buttonMode = true;
			checkButton.mouseChildren = false;
			checkButton.addEventListener(MouseEvent.MOUSE_OVER, onCheckHover);
			checkButton.addEventListener(MouseEvent.MOUSE_OUT, onCheckOut);
			checkButton.addEventListener(MouseEvent.MOUSE_DOWN, onCheck);
			
			var myFormat:TextFormat=new TextFormat();
			myFormat.size=20;
			myFormat.font="Geneva";
			myFormat.align=TextFormatAlign.CENTER;
			
			var check:TextField=new TextField; 
			check.textColor=0xFFFFFF;
			check.x=660;
			check.y=575;
			check.defaultTextFormat=myFormat;
			check.text="Check";
			checkButton.addChild(check);
		}
		
		private function onCheckHover(event:MouseEvent):void {
			checkButton.alpha=.5;
		}
		
		private function onCheckOut(event:MouseEvent):void {
			checkButton.alpha=1;
		}
		
		private function onCheck(event:MouseEvent):void {
			scores.playCheck();
			playerTurn=false;
			hideActions();
			if (checked){
				makePot();
			}
			else{
				checked=true;
				postDrawBetting();
			}
		}
			
		public function drawCall():void{
			addChild(callButton);
			callButton.graphics.lineStyle(4,0x7D7A7B);
			callButton.graphics.beginFill(0xA3A2A2);
			callButton.graphics.drawRoundRect(760,570,80,40,20,20);
			callButton.graphics.endFill();
			callButton.buttonMode = true;
			callButton.mouseChildren = false;
			callButton.addEventListener(MouseEvent.MOUSE_OVER, onCallHover);
			callButton.addEventListener(MouseEvent.MOUSE_OUT, onCallOut);
			callButton.addEventListener(MouseEvent.MOUSE_DOWN, onCall);
			
			var myFormat:TextFormat=new TextFormat();
			myFormat.size=20;
			myFormat.font="Geneva";
			myFormat.align=TextFormatAlign.CENTER;
			
			var call:TextField=new TextField; 
			call.textColor=0xFFFFFF;
			call.x=750;
			call.y=575;
			call.defaultTextFormat=myFormat;
			call.text="Call";
			callButton.addChild(call);
		}
		
		private function onCallHover(event:MouseEvent):void {
			callButton.alpha=.5;
		}
		
		private function onCallOut(event:MouseEvent):void {
			callButton.alpha=1;
		}
		
		private function onCall(event:MouseEvent):void {
			scores.playCall();
			playerTurn=false;
			hideActions();
			displayChips(computerBet, 0);
			makePot();
		}
		
		public function drawBet():void{
			addChild(betButton);
			betButton.graphics.lineStyle(4,0x7D7A7B);
			betButton.graphics.beginFill(0xA3A2A2);
			betButton.graphics.drawRoundRect(760,570,80,40,20,20);
			betButton.graphics.endFill();
			betButton.buttonMode = true;
			betButton.mouseChildren = false;
			betButton.addEventListener(MouseEvent.MOUSE_OVER, onBetHover);
			betButton.addEventListener(MouseEvent.MOUSE_OUT, onBetOut);
			betButton.addEventListener(MouseEvent.MOUSE_DOWN, onBet);
			
			var myFormat:TextFormat=new TextFormat();
			myFormat.size=20;
			myFormat.font="Geneva";
			myFormat.align=TextFormatAlign.CENTER;
			
			var bet:TextField=new TextField; 
			bet.textColor=0xFFFFFF;
			bet.x=750;
			bet.y=575;
			bet.defaultTextFormat=myFormat;
			bet.text="Bet";
			betButton.addChild(bet);
		}
		
		private function onBetHover(event:MouseEvent):void {
			betButton.alpha=.5;
		}
		
		private function onBetOut(event:MouseEvent):void {
			betButton.alpha=1;
		}
		
		private function onBet(event:MouseEvent):void {
			scores.playBet();
			playerTurn=false;
			hideActions();
			displayChips(40, 0);
			postDrawBetting();
		}
		
		public function drawRaise():void{
			addChild(raiseButton);
			raiseButton.graphics.lineStyle(4,0x7D7A7B);
			raiseButton.graphics.beginFill(0xA3A2A2);
			raiseButton.graphics.drawRoundRect(850,570,80,40,20,20);
			raiseButton.graphics.endFill();
			raiseButton.buttonMode = true;
			raiseButton.mouseChildren = false;
			raiseButton.addEventListener(MouseEvent.MOUSE_OVER, onRaiseHover);
			raiseButton.addEventListener(MouseEvent.MOUSE_OUT, onRaiseOut);
			raiseButton.addEventListener(MouseEvent.MOUSE_DOWN, onRaise);
			
			var myFormat:TextFormat=new TextFormat();
			myFormat.size=20;
			myFormat.font="Geneva";
			myFormat.align=TextFormatAlign.CENTER;
			
			var raise:TextField=new TextField; 
			raise.textColor=0xFFFFFF;
			raise.x=840;
			raise.y=575;
			raise.defaultTextFormat=myFormat;
			raise.text="Raise";
			raiseButton.addChild(raise);
		}
		
		private function onRaiseHover(event:MouseEvent):void {
			raiseButton.alpha=.5;
		}
		
		private function onRaiseOut(event:MouseEvent):void {
			raiseButton.alpha=1;
		}
		
		private function onRaise(event:MouseEvent):void {
			scores.playRaise();
			playerTurn=false;
			hideActions();
			if (preDraw){
				displayChips(computerBet+20, 0);
				preDrawBetting();
			}
			else{
				displayChips(computerBet+40, 0);
				postDrawBetting();
			}
		}
		
		public function drawDraw():void{
			addChild(drawButton);
			drawButton.graphics.lineStyle(4,0x7D7A7B);
			drawButton.graphics.beginFill(0xA3A2A2);
			drawButton.graphics.drawRoundRect(760,570,80,40,20,20);
			drawButton.graphics.endFill();
			drawButton.buttonMode = true;
			drawButton.mouseChildren = false;
			drawButton.addEventListener(MouseEvent.MOUSE_OVER, onDrawHover);
			drawButton.addEventListener(MouseEvent.MOUSE_OUT, onDrawOut);
			drawButton.addEventListener(MouseEvent.MOUSE_DOWN, onDraw);
			
			var myFormat:TextFormat=new TextFormat();
			myFormat.size=20;
			myFormat.font="Geneva";
			myFormat.align=TextFormatAlign.CENTER;
			
			var draw:TextField=new TextField; 
			draw.textColor=0xFFFFFF;
			draw.x=750;
			draw.y=575;
			draw.defaultTextFormat=myFormat;
			draw.text="Draw";
			drawButton.addChild(draw);
		}
		
		private function onDrawHover(event:MouseEvent):void {
			drawButton.alpha=.5;
		}
		
		private function onDrawOut(event:MouseEvent):void {
			drawButton.alpha=1;
		}
		
		private function onDraw(event:MouseEvent):void {
			hideDraw();
			FiveCardDraw.hand.exchangePlayerCards();
		}
		
		public function preDrawBetting():void{
			betTimer.start();
			betTimer.addEventListener(TimerEvent.TIMER, betSleep);
		}
		
		public function betSleep(e:TimerEvent):void{
			if (playerTurn){
				betTimer.reset();
				drawActions();
			}
			else if (betTimer.currentCount==10){
				var randChoice:int = Math.floor(Math.random()*3);
//				if (randChoice==0){
//					scores.playFold();
//					playerTurn=true;
//					betTimer.reset();
//					makePot();
//				}
				if (randChoice==1 || randChoice==0){
					displayChips(playerBet, 2);
					scores.playCall();
					playerTurn=true;
					betTimer.reset();
					makePot();
				}
				else if (randChoice==2){
					displayChips(playerBet+20, 2);
					scores.playRaise();
					betTimer.reset();
					playerTurn=true;
					betTimer.reset();
					preDrawBetting();
				}
			}
		}
		
		public function makePot():void{
			potTimer.start();
			potTimer.addEventListener(TimerEvent.TIMER, potSleep);
		}
		
		public function potSleep(e:TimerEvent):void{
			if (potTimer.currentCount==10){
				//scores.playPot();
				if (preDraw){
					displayChips(computerBet+playerBet, 1);
					drawPhase();
				}
				else{
					displayChips(computerBet+playerBet+potBet, 1);
				}
				scores.updateComputerBet(0, 0);
				scores.updatePlayerBet(0, 0);
				potTimer.reset();
			}
		}
		
		public function drawPhase():void{
			if (button==1){
				drawDraw();
				button=2;
			}
			else if(button==2){
				FiveCardDraw.hand.exchangeComputerCards();
				button=1;
			}
		}
		
		public function drawPhase2():void{
			if (button==1){
				drawDraw();
				button=2;
				playerTurn=false;
			}
			else if (button==2){
				FiveCardDraw.hand.exchangeComputerCards();
				button=1;
				playerTurn=true;
			}
			preDraw=false;
		}
		
		public function postDrawBetting():void{
			betTimer2.start();
			betTimer2.addEventListener(TimerEvent.TIMER, betSleep2);
		}
		
		public function betSleep2(e:TimerEvent):void{
			if (playerTurn){
				betTimer2.reset();
				drawActions();
			}
			else if (betTimer2.currentCount==10){
				if (playerBet==computerBet && computerBet==0){
					var randChoice:int = Math.floor(Math.random()*2);
					if (randChoice==0){
						scores.playCheck();
						playerTurn=true;
						betTimer2.reset();
						if (checked){
							makePot();
						}
						else{
							checked=true;
							postDrawBetting();
						}
					}
					else if (randChoice==1){
						displayChips(40, 2);
						scores.playBet();
						playerTurn=true;
						betTimer2.reset();
						postDrawBetting();
					}
				}
				else if (computerBet<playerBet){
					var randChoice:int = Math.floor(Math.random()*3);
					if (randChoice==0){
						scores.playFold();
						playerTurn=true;
						betTimer2.reset();
						makePot();
					}
					else if (randChoice==1){
						displayChips(playerBet, 2);
						scores.playCall();
						playerTurn=true;
						betTimer2.reset();
						makePot();
					}
					else if (randChoice==2){
						displayChips(playerBet+40, 2);
						scores.playRaise();
						betTimer2.reset();
						playerTurn=true;
						betTimer2.reset();
						postDrawBetting();
					}
				}
			}
		}
		
		public function awardWinner():void{
			FiveCardDraw.hand.removeDownCards();
			var winner:int=FiveCardDraw.hand.awardWinner();
			if (winner==1){
				potMoveTimer.start()
				potMoveTimer.addEventListener(TimerEvent.TIMER, potPlayerSleep);
			}
			else if (winner==2){
				potMoveTimer.start()
				potMoveTimer.addEventListener(TimerEvent.TIMER, potComputerSleep);
			}
			else if (winner==3){
				removeChild(potStack);
				scores.updatePlayerStack(potBet/2);
				scores.updateComputerStack(potBet/2);
				scores.updatePot(0, 0, 0);
			}
		}	
		
		public function potPlayerSleep(e:TimerEvent):void{
			potStack.x-=25;
			potMove-=25;
			var differentChips:int=chipCount(potBet);
			scores.updatePot(potBet, differentChips, potMove);
			if (potMoveTimer.currentCount==12){
				potMoveTimer.reset();
				removeChild(potStack);
				scores.updatePlayerStack(potBet);
				scores.updatePot(0, 3, 0);
				//newGame.startGame();
			}
		}
		
		public function potComputerSleep(e:TimerEvent):void{
			potStack.x+=25;
			potMove+=25;
			var differentChips:int=chipCount(potBet);
			scores.updatePot(potBet, differentChips, potMove);
			if (potMoveTimer.currentCount==12){
				potMoveTimer.reset();
				removeChild(potStack);
				scores.updateComputerStack(potBet);
				scores.updatePot(0, 3, 0);
				//newGame.startGame();
			}
		}
		
		public function chipCount(stack:int):int{
			var thousands:int=stack/1000;
			var fiveHundreds:int=(stack-(thousands*1000))/500;
			var hundreds:int=(stack-(thousands*1000)-(fiveHundreds*500))/100;
			var twentyFives:int=(stack-(thousands*1000)-(fiveHundreds*500)-(hundreds*100))/25;
			var fives:int=(stack-(thousands*1000)-(fiveHundreds*500)-(hundreds*100)-(twentyFives*25))/5;
			var ones:int=(stack-(thousands*1000)-(fiveHundreds*500)-(hundreds*100)-(twentyFives*25)-(fives*5));
			
			var differentChips:int=0;
			if (thousands!=0){
				differentChips++;
			}
			if (fiveHundreds!=0){
				differentChips++;
			}
			if (hundreds!=0){
				differentChips++;
			}
			if (twentyFives!=0){
				differentChips++;
			}
			if (fives!=0){
				differentChips++;
			}		
			if (ones!=0){
				differentChips++;
			}
			
			return differentChips;
		}
		
		public function drawScrollbar():void{
			scroller.graphics.lineStyle(2,0x7D7A7B);
			scroller.graphics.beginFill(0xA3A2A2);
			scroller.graphics.drawRoundRect(700,525,5,20,5,5);
			scroller.graphics.endFill();
			//new variable: scrollPercent!
			//myText.text = "0";
			//circle.alpha = 0;
			
			scroller.buttonMode = true;
			scroller.addEventListener(MouseEvent.MOUSE_DOWN, scroller_onMouseDown);
		}
		
		private function scroller_onMouseDown(event:MouseEvent):void {
			leftLimit+=15;
			removeChild(scroller)
			scroller.graphics.lineStyle(2,0x7D7A7B);
			scroller.graphics.beginFill(0xA3A2A2);
			scroller.graphics.drawRoundRect(leftLimit,525,5,20,5,5);
			scroller.graphics.endFill();
			addChild(scroller);
			xOffset = mouseY - scroller.x;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
		}
		
		private function stage_onMouseMove(event:MouseEvent):void {
			scroller.x = mouseY - xOffset;
			//restrict the movement of the scroller:
			if(scroller.x < leftLimit) {
				scroller.x = leftLimit;
			}
			if(scroller.x > rightLimit) {
				scroller.x = rightLimit;
			}
			//calculate scrollPercent and make it do stuff:
			scrollPercent = (scroller.x) / scrollerRange;
			//myText.text = String(scrollPercent);
			//circle.alpha = scrollPercent;
			
			event.updateAfterEvent();
		}
		
		private function stage_onMouseUp(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
		}
		
		private function removePlayerStack():void{
			for (var i:int=0; i<playerStack.numChildren; i++){
				var chip:*=playerStack.getChildAt(i);
				playerStack.removeChild(chip);
				i--;
			}
			playerBet=0;
		}
		
		private function removeComputerStack():void{
			for (var i:int=0; i<computerStack.numChildren; i++){
				var chip:*=computerStack.getChildAt(i);
				computerStack.removeChild(chip);
				i--;
			}
			computerBet=0;
		}
		
		private function removePotStack():void{
			for (var i:int=0; i<potStack.numChildren; i++){
				var chip:*=potStack.getChildAt(i);
				potStack.removeChild(chip);
				i--;
			}
		}
		
		public function displayChips(chipStack:int, shift:int):void{
			var thousands:int=chipStack/1000;
			var fiveHundreds:int=(chipStack-(thousands*1000))/500;
			var hundreds:int=(chipStack-(thousands*1000)-(fiveHundreds*500))/100;
			var twentyFives:int=(chipStack-(thousands*1000)-(fiveHundreds*500)-(hundreds*100))/25;
			var fives:int=(chipStack-(thousands*1000)-(fiveHundreds*500)-(hundreds*100)-(twentyFives*25))/5;
			var ones:int=(chipStack-(thousands*1000)-(fiveHundreds*500)-(hundreds*100)-(twentyFives*25)-(fives*5));
			
			var differentChips:int=0;
			if (thousands!=0){
				differentChips++;
			}
			if (fiveHundreds!=0){
				differentChips++;
			}
			if (hundreds!=0){
				differentChips++;
			}
			if (twentyFives!=0){
				differentChips++;
			}
			if (fives!=0){
				differentChips++;
			}		
			if (ones!=0){
				differentChips++;
			}
			
			stackShift = 0;
			if (shift==1){
				stackShift += 235;
				stackShift -= ((differentChips-1)*24);
				removeComputerStack();
				removePlayerStack();
				removePotStack();
			}
			else if (shift==2){
				stackShift += 450;
				stackShift -= ((differentChips-1)*24);
				removeComputerStack();
			}
			else{
				removePlayerStack();
			}
			
			var totalBet:int=0;
			
			stackHeight = thousands;
			for (var s:int=0; s<thousands; s++){
				var newChip:Bitmap = new Bitmap(Bitmap(thousandChip.content).bitmapData);
				newChip.x=240+stackShift;
				newChip.y=365-s;
				totalBet+=1000;
				if (shift==2){
					computerStack.addChild(newChip);
				}
				else if (shift==1){
					potStack.addChild(newChip);
				}
				else{
					playerStack.addChild(newChip);
				}
			}
			if (thousands>0){
				stackShift+=24;
			}
			
			stackHeight = fiveHundreds;
			for (var t:int=0; t<fiveHundreds; t++){
				var newChip:Bitmap = new Bitmap(Bitmap(fiveHundredChip.content).bitmapData);
				newChip.x=240+stackShift;
				newChip.y=365-t;
				totalBet+=500;
				if (shift==2){
					computerStack.addChild(newChip);
				}
				else if (shift==1){
					potStack.addChild(newChip);
				}
				else{
					playerStack.addChild(newChip);
				}
			}
			if (fiveHundreds>0){
				stackShift+=24;
			}
			
			stackHeight = hundreds;
			for (var u:int=0; u<hundreds; u++){
				var newChip:Bitmap = new Bitmap(Bitmap(hundredChip.content).bitmapData);
				newChip.x=240+stackShift;
				newChip.y=365-u;
				totalBet+=100;
				if (shift==2){
					computerStack.addChild(newChip);
				}
				else if (shift==1){
					potStack.addChild(newChip);
				}
				else{
					playerStack.addChild(newChip);
				}
			}
			if (hundreds>0){
				stackShift+=24;
			}
			
			stackHeight = twentyFives;
			for (var v:int=0; v<twentyFives; v++){
				var newChip:Bitmap = new Bitmap(Bitmap(twentyFiveChip.content).bitmapData);
				newChip.x=240+stackShift;
				newChip.y=365-v;
				totalBet+=25;
				if (shift==2){
					computerStack.addChild(newChip);
				}
				else if (shift==1){
					potStack.addChild(newChip);
				}
				else{
					playerStack.addChild(newChip);
				}
			}
			if (twentyFives>0){
				stackShift+=24;
			}
			
			stackHeight = fives;
			for (var w:int=0; w<fives; w++){
				var newChip:Bitmap = new Bitmap(Bitmap(fiveChip.content).bitmapData);
				newChip.x=240+stackShift;
				newChip.y=365-w;
				totalBet+=5;
				if (shift==2){
					computerStack.addChild(newChip);
				}
				else if (shift==1){
					potStack.addChild(newChip);
				}
				else{
					playerStack.addChild(newChip);
				}
			}
			if (fives>0){
				stackShift+=24;
			}
			
			stackHeight = ones;
			for (var x:int=0; x<ones; x++){
				var newChip:Bitmap = new Bitmap(Bitmap(oneChip.content).bitmapData);
				newChip.x=240+stackShift;
				newChip.y=365-x;
				totalBet+=1;
				if (shift==2){
					computerStack.addChild(newChip);
				}
				else if (shift==1){
					potStack.addChild(newChip);
				}
				else{
					playerStack.addChild(newChip);
				}
			}
			
			if (shift==2){
				computerBet += totalBet;
				scores.updateComputerStack(-computerBet);
				scores.updateComputerBet(computerBet, differentChips);
			}
			else if (shift==1){
				//scores.updatePotStack(-totalBet);
				potBet=totalBet;
				scores.updatePot(totalBet, differentChips, 0);
				if (!preDraw){
					awardWinner();
				}
			}
			else{
				playerBet += totalBet;
				scores.updatePlayerStack(-playerBet);
				scores.updatePlayerBet(playerBet, differentChips);
			}
		}
	}
}