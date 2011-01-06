package  
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source = "../media/mini/bullet_1.png")]
		private var Bullet_1:Class;//18x12
		[Embed(source = "../media/mini/bullet_2.png")]
		private var Bullet_2:Class;//35x24
		
		private var framesLife:int = 0;
		private var visibilityOffset:Number = 20;
		private var _directionLeftRight:int = 1;
		private var _bulletType:int = 1;
		
		public function Bullet( x:int, y:int, directionLeftRight:int = 1, _type:int = 1 ) 
		{
			super(x+20, y+28);
			
			_directionLeftRight = directionLeftRight;
			_bulletType = _type;
			
			velocity.x = 100;
			acceleration.x = 0;
			acceleration.y = 0;
			
			//Load graphic
			loadGraphic(Bullet_1, true, true, 18, 6);
			
			//Create basic animations
			addAnimation("fly", [0, 1], 15);
		}
		
		override public function update():void
		{
			velocity.x = 100 * _directionLeftRight;
			
			//FlxG.log(velocity.x);
			
			play("fly");
			framesLife++;
			
			if ( this.getScreenXY().x > (640 + visibilityOffset) || this.getScreenXY().x < -visibilityOffset || this.getScreenXY().y > (480 + visibilityOffset) || this.getScreenXY().y < -visibilityOffset )
			{
				velocity.x = 0;
				kill();
			}
			
			super.update();
		}
		
		public function setType( directionLeftRight:int = 1, _type:int = 1 ):void
		{
			_directionLeftRight = directionLeftRight;
			_bulletType = _type;
		}
		
		
		override public function reset( _x:Number, _y:Number ):void
		{
			super.reset( _x+20, _y+28 );
			velocity.x = 0;
			velocity.y = 0;
			
			acceleration.x = 0;
			acceleration.y = 0;
			
			play("fly");
		}
		
	}

}