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
		private var _shoted:Boolean = false;
		private var _shooting:Boolean = false;
		
		private var _frameWidth:uint = 32;
		private var _frameHeight:uint= 47;
		private var _collideWidth:uint = 8;
		private var _collideHeight:uint = 45;
		
		private var _xVelocity:Number;
		private var _gameState:FlxState;

		public function Player(x:int, y:int, xVelocity:int = 70) 
		{
			super(x, y);
			
			acceleration.y = 800; //Set the gravity - 1200
            maxVelocity.y = 250; // 300
			
			//Load graphic
			loadGraphic(BobSkin, true, true, _frameWidth, _frameHeight);
			
			// bounding box tweaks
			width = _collideWidth;
			height = _collideHeight;
			offset.x = 12;
			offset.y = 0;
			
			//set horizontal velocity
			_xVelocity = xVelocity;
			velocity.x = 0;

			//Create basic animations
			addAnimation("walk", [0, 1, 2], 15);
			addAnimation("jump", [0, 3, 4, 5, 6, 7], 7, false);
			addAnimation("fall", [8, 9, 10], 30);
			addAnimation("fall_simple", [9]);
			addAnimation("stay", [0]);
			addAnimation("shoot", [ 11, 12, 13, 14, 14, 15], 40, false );
			addAnimation("shoot_off", [16, 13, 12, 11, 0], 40, false );
		}
		
		override public function update():void
		{
			
			//Move left
			if ( buttonPressed('left') )
			{
				facing = LEFT;
				velocity.x = -_xVelocity;
				_walk = true;
				
			}
			
			//Move right
			if ( buttonPressed('right') )
			{
				facing = RIGHT;
				velocity.x = _xVelocity;
				_walk = true;
			}
			
			//Jumping
			if( (_jump >= 0) && buttonPressed('up') )
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
			if ( buttonPressed('up') && _jump < 0)
			{
				if (velocity.y > 0)
				{
					velocity.y /= 1.3;
				}
			}
			
			//Stop moving
			if ( buttonReleased('left') || buttonReleased('right') )
			{
				_walk = false;
			}
			
			//Start shooting processing
			if ( buttonPressed('shoot') )
			{
				_shooting = true;
			}
			
			if ( _shooting && !_shoted && frame == 15 )
			{
				_gameState.add( new Bullet(x, y, 1) );
				_shoted = true;
			}
			
			if ( _shooting && _shoted && frame == 0)
			{
				_shooting = false;
				_shoted = false;
			}
			
			
			//Display user state
			if (_shooting)
			{
				if (!_shoted)
				{
					play("shoot");
				}
				else {
					play("shoot_off");
				}
			}
			else if (velocity.y > 0)
			{
				if( buttonPressed('up') )
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
			else
			{
				velocity.x = 0;
				play("stay");
			}
			
			super.update();
		}
		
		public function shareHandler(st:FlxState):void
		{
			_gameState = st;
		}
		
		override public function hitBottom(Contact:FlxObject, Velocity:Number):void {
            _jump = 0;
            super.hitBottom(Contact, Velocity);
        }
		
				private function buttonPressed( button:String ) : Boolean
		{
			switch(button)
			{
				case 'up':
					if ( FlxG.keys.UP || FlxG.keys.W || FlxG.keys.X )
						return true;
					break;
				case 'down':
					if ( FlxG.keys.DOWN || FlxG.keys.S )
						return true;
					break;
				case 'left':
					if ( FlxG.keys.LEFT || FlxG.keys.A )
						return true;
					break;
				case 'right':
					if ( FlxG.keys.RIGHT || FlxG.keys.D)
						return true;
					break;
				case 'shoot':
					if (FlxG.keys.SPACE || FlxG.keys.Z)
						return true;
					break;
			}
			return false;
		}
		
		private function buttonReleased( button:String ) : Boolean
		{
			switch(button)
			{
				case 'up':
					if ( FlxG.keys.justReleased("UP") || FlxG.keys.justReleased("W") || FlxG.keys.justReleased("X"))
						return true;
					break;
				case 'down':
					if ( FlxG.keys.justReleased("DOWN") || FlxG.keys.justReleased("S") )
						return true;
					break;
				case 'left':
					if ( FlxG.keys.justReleased("LEFT") || FlxG.keys.justReleased("A") )
						return true;
					break;
				case 'right':
					if ( FlxG.keys.justReleased("RIGHT") || FlxG.keys.justReleased("D") )
						return true;
					break;
				case 'shoot':
					if ( FlxG.keys.justReleased("SPACE") || FlxG.keys.justReleased("Z") )
						return true;
					break;
			}
			return false;
		}
		
	}

}