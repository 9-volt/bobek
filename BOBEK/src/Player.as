package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = "../media/Bob.png")]
		private var BobSkin:Class;
		

		
		public function Player(x:int, y:int) 
		{
			super(x, y, BobSkin);
		}
		override public function update():void
		{
			if (FlxG.keys.LEFT)
			{
				x -= 5;
			}
			if (FlxG.keys.RIGHT)
			{
				x += 5;
			}
		}
		
		
	}

}