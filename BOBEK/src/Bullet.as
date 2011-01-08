package  
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source = "../media/player/bullet_1.png")]
		private var Bullet_1:Class;//18x12
		[Embed(source = "../media/player/bullet_2.png")]
		private var Bullet_2:Class;//35x24
		
		private var _directionLeftRight:int = 1;
		private var _bulletType:int = 1;
		
		public function Bullet( _x:Number, _y:Number, directionLeftRight:int = 1, _type:int = 1, _speed:int = 100 ) 
		{
			_directionLeftRight = directionLeftRight;
			_bulletType = _type;
			
			var __x:int;
			
			if ( _directionLeftRight > 0 )
			{
				__x = _x +20;
			}
			else
			{
				__x = _x - 30;
			}
			super( __x, _y + 28 );
			
			if ( _directionLeftRight > 0 )
			{
				facing = RIGHT;
			}
			else
			{
				facing = LEFT;
			}
			
			velocity.x = _speed * _directionLeftRight;
			
			acceleration.x = 0;
			acceleration.y = 0;
			
			maxVelocity.y = 0;
			
			//Load graphic
			switch( _type )
			{
				case 2:
					loadGraphic(Bullet_2, true, true, 35, 12);
					width = 35;
					height = 12;
					break;
				case 1:
				default:
					loadGraphic(Bullet_1, true, true, 18, 6);
					width = 18;
					height = 6;
					break;
			}
			
			//Create basic animations
			addAnimation("fly", [0, 1], 15);
		}
		
		override public function update():void
		{
			play("fly");
			
			if ( !onScreen() )
			{
				kill();
			}
			
			super.update();
		}
		
	}

}