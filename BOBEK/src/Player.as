package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = "../media/walk.png")]
		private var BobSkin:Class;
		

		
		public function Player(x:int, y:int) 
		{
			super(x, y, BobSkin);
			
			addAnimation("walk", [0, 1, 2]);
		}
		override public function update():void
		{
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
				play("walk");
				x -= 3;
			}
			if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				play("walk");
				x += 3;
			}
		}
		
		
	}

}