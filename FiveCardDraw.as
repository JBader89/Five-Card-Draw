package
{
	import Environment;	
	import Cards;
	import Chips;
	import flash.display.Sprite;
	
	[SWF(width="945", height="625")]
	
	public class FiveCardDraw extends Sprite
	{
		public static var hand:Cards=new Cards;
		public static var gameplay:Chips=new Chips;
		public function FiveCardDraw()
		{
			var environment:Environment=new Environment;
			environment.drawBackground();
			environment.playShuffle();
			addChild(environment);
			
			hand.playHand();
			addChild(hand);
			
			gameplay.makeButton();
			gameplay.drawBlinds();
			addChild(gameplay);		
		}
	}
}