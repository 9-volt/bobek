package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = "../media/walk.png")]
		private var BobSkin:Class;
		
		public function Player(x:int, y:int) 
		{
			super(x, y);
			
			loadGraphic(BobSkin, true, true, 68, 96);
			
			addAnimation("walk", [0, 1, 2], 10);
			addAnimation("stay", [0]);
		}
		
		override public function update():void
		{
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
				x -= 1;
				play("walk");
				//frame = 1;
				//velocity.x++;
			}
			
			if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				x += 1;
				play("walk");
				//frame = 2;
			}
			
			if (FlxG.keys.justReleased("LEFT") || FlxG.keys.justReleased("RIGHT"))
			{
				play("stay");
			}
			
			super.update();
		}
		
		
	}

}