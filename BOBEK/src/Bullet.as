package  
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source = "../media/mini/bullet_1.png")]
		private var Bullet_1:Class;//18x12
		[Embed(source = "../media/mini/bullet_2.png")]
		private var Bullet_2:Class;//35x24
		
		private var visibilityOffset:Number = 20;
		private var _directionLeftRight:int = 1;
		private var _bulletType:int = 1;
		
		//override public var maxVelocity:FlxPoint;
		
		public function Bullet( _type:int = 1 ) 
		{
			super( 0, 0 );
			
			acceleration.x = 0;
			acceleration.y = 0;
			
			maxVelocity.y = 0;
			
			//Load graphic
			switch( _type )
			{
				case 2:
					loadGraphic(Bullet_2, true, true, 35, 12);
					break;
				case 1:
				default:
					loadGraphic(Bullet_1, true, true, 18, 6);
					break;
			}
			
			//Create basic animations
			addAnimation("fly", [0, 1], 15);
		}
		
		override public function update():void
		{
			
			if ( _directionLeftRight > 0 )
			{
				facing = RIGHT;
			}
			else
			{
				facing = LEFT;
			}
			
			//FlxG.log(velocity.x);
			
			play("fly");
			
			if ( !onScreen() )
			{
				kill();
			}
			
			super.update();
		}
		
		public function setType( _x:Number, _y:Number, directionLeftRight:int = 1, _type:int = 1 ):void
		{
			_directionLeftRight = directionLeftRight;
			_bulletType = _type;
			
			y = _y + 28;
			
			if ( _directionLeftRight > 0 )
			{
				x = _x +20;
			}
			else
			{
				x = _x - 30;
			}
			
			//same shit as reset
			exists = true;
			dead = false;
			//reset( x, y );
			
			velocity.x = 100 * _directionLeftRight;
			
		}
		
		
		//public function reset2( _x:Number, _y:Number ):void
		//{
			//var __x:int;
			//
			//
			//super.reset( __x, _y + 28 );
			//
			//velocity.x = 100 * _directionLeftRight;
			//maxVelocity.x = 100;
			//velocity.y = 0;
			//
			//acceleration.x = 0;
			//acceleration.y = 0;
			//
			//play("fly");
		//}
		
		//override public function kill():void
		//{
			//exists = false;
			//dead = true;
			//velocity.x = 0;
		//}
		
	}

}