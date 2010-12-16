package  
{
	import org.flixel.*;	
	
	public class Player extends FlxSprite
	{
		[Embed(source = "../media/mini/moving.png")]
		private var BobSkin:Class;
		
		private var _jump:Number;
		private var _walk:Boolean = false;
		
		private var _xVelocity:Number;
		
		
		public function Player(x:int, y:int, xVelocity:int = 70) 
		{
			super(x, y);
			
			acceleration.y = 800; //Set the gravity - 1200
            maxVelocity.y = 250; // 300
			
			//set horizontal velocity
			_xVelocity = xVelocity;
			velocity.x = 0;
			
			//Load graphic
			loadGraphic(BobSkin, true, true, 32, 47);
			/*
			 * 0 - staing in place
			 * 1 - moving frame 1
			 * 2 - moving frame 2
			 * */
			
			//Create basic animations
			addAnimation("walk", [0, 1, 2], 10);
			addAnimation("jump", [0, 3, 4, 5, 6, 7], 10);
			addAnimation("fall", [8, 9, 10], 20);
			addAnimation("stay", [0]);
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
			if (((FlxG.keys.UP) || (FlxG.keys.W)) && _jump < 0 && _walk)
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
			
			
			//Display user state
			if (velocity.y > 0)
			{
				play("fall");
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