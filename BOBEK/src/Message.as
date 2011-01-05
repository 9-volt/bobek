package  
{
	import org.flixel.*;
	public class Message extends FlxSprite
	{
		[Embed(source = "../media/text_bubble.png")] private var bubbleImg:Class;
		public function Message(x:int,y:int) 
		{
			super(x, y);
			loadGraphic(bubbleImg, true, false, 256, 64);
			addAnimation("preload", [0, 1, 2, 3, 4, 5],15);
			addAnimation("loaded", [5, 6, 7, 8],15);
			play("loaded");
		}
		override public function update():void 
		{
			super.update();
		}
		
	}

}