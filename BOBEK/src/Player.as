package  
{
	import org.flixel.*;	
	
	public class Player extends FlxSprite
	{
		[Embed(source = "../media/mini/moving.png")]
		private var BobSkin:Class;
		
		private var _jump:Number;
		private var _walk:Boolean = false;
		private var _shoot:Boolean = false;
		private var _shooting:Boolean = false;
		
		private var _xVelocity:Number;
		
		
		public function Player(x:int, y:int, xVelocity:int = 70) 
		{
			super(x, y);
			
			acceleration.y = 800; //Set the gravity - 1200
            maxVelocity.y = 250; // 300
			
			//hack for putting player foots on ground
			//TODO change this
			offset.y = -2;
			
			//set horizontal velocity
			_xVelocity = xVelocity;
			velocity.x = 0;
			
			//Load graphic
			loadGraphic(BobSkin, true, true, 32, 47);

			//Create basic animations
			addAnimation("walk", [0, 1, 2], 15);
			addAnimation("jump", [0, 3, 4, 5, 6, 7], 7, false);
			addAnimation("fall", [8, 9, 10], 20);
			addAnimation("fall_simple", [9]);
			addAnimation("stay", [0]);
			addAnimation("shoot", [ 11, 12, 13, 14, 14, 15], 30, false );
			addAnimation("shoot_off", [16, 13, 12, 11, 0], 30, false );
		}
		
		override public function update():void
		{
			
			//Move left
			if (FlxG.keys.LEFT || FlxG.keys.A)
			{
				facing = LEFT;
				velocity.x = -_xVelocity;
				_walk = true;
			}
			
			//Move right
			if (FlxG.keys.RIGHT || FlxG.keys.D)
			{
				facing = RIGHT;
				velocity.x = _xVelocity;
				_walk = true;
			}
			
			//Jumping
			if((_jump >= 0) && ((FlxG.keys.UP) || (FlxG.keys.W)))
            {
				_jump += FlxG.elapsed;
					
				//FlxG.log(FlxG.elapsed);
                if(_jump > 0.25) _jump = -1; //You can't jump for more than 0.25 seconds
            }
            else _jump = -1;
			
			if (_jump > 0)
            {
                if(_jump < 0.065)
                    velocity.y = -180; //This is the minimum height of the jump
                else
                    velocity.y = -maxVelocity.y;
            }
			
			//increase velocity if we are falling and still press UP keys
			if (((FlxG.keys.UP) || (FlxG.keys.W)) && _jump < 0)
			{
				if (velocity.y > 0)
				{
					velocity.y /= 1.3;
				}
			}
			
			//Stop moving
			if (FlxG.keys.justReleased("LEFT") || FlxG.keys.justReleased("A") || FlxG.keys.justReleased("RIGHT") || FlxG.keys.justReleased("D"))
			{
				_walk = false;
			}
			
			
			//shooting processing
			if (FlxG.keys.Z)
			{
				_shoot = true;
				_shooting = true;
			}
			
			if (FlxG.keys.justReleased("Z"))
			{
				_shoot = false;
				_shooting = true;
			}
			
			if ( !_shoot && frame == 0)
			{
				_shooting = false;
			}
			
			
			//Display user state
			if (velocity.y > 0)
			{
				if(((FlxG.keys.UP) || (FlxG.keys.W)))
					play("fall");
				else
					play("fall_simple");
			}
			else if (velocity.y != 0)
			{
				play("jump");
			}
			else if (_walk)
			{
				play("walk");
			}
			else if (_shooting)
			{
				if (_shoot)
				{
					play("shoot");
				}
				else {
					play("shoot_off");
				}
			}
			else
			{
				velocity.x = 0;
				//acceleration.x = 0;
				play("stay");
			}
			
			super.update();
		}
		
		override public function hitBottom(Contact:FlxObject, Velocity:Number):void {
            _jump = 0;
            super.hitBottom(Contact, Velocity);
        }
		
	}

}