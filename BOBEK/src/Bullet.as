package  
{
	import org.flixel.*;
	
	public class Bullet  extends FlxSprite
	{
		[Embed(source = "../media/mini/bullet_1.png")]
		private var Bullet_1:Class;//18x12
		[Embed(source = "../media/mini/bullet_2.png")]
		private var Bullet_2:Class;//35x24
		
		public function Bullet( x:int, y:int, size:int = 1 ) 
		{
			super(x+20, y+28);
			
			velocity.x = 100;
			
			//Load graphic
			loadGraphic(Bullet_1, true, true, 18, 6);
			
			//Create basic animations
			addAnimation("fly", [0, 1], 15);
		}
		
		override public function update():void
		{
			play("fly");
			
			super.update();
		}
		
	}

}