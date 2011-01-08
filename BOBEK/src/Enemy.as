package  
{
	import org.flixel.*;
	
	public class Enemy extends FlxSprite
	{
		[Embed(source = "../media/enemies/broccoli.png")]
		private var EnemySkin:Class;
		
		public function Enemy(x:int, y:int, type:int = 1) 
		{
			super(x, y);
			
			acceleration.y = 800; //Set the gravity
            maxVelocity.y = 250; // 300
			
			velocity.x = -60;
			
			//hack for putting player foots on ground
			//TODO change this
			offset.y = -2;
			
			//Load graphic
			loadGraphic(EnemySkin, true, true, 44, 64);
			
			//Create basic animations
			addAnimation("walk", [0, 1, 2, 3, 4, 5], 15);
		}
		
		override public function update():void
		{
			play("walk");
			
			super.update();
		}
		
		override public function hitBottom(Contact:FlxObject, Velocity:Number):void
		{
            super.hitBottom(Contact, Velocity);
        }
		
	}

}