package  
{
	import org.flixel.*;	
	
	public class Player extends FlxSprite
	{
		[Embed(source = "../media/walk.png")]
		private var BobSkin:Class;
		
		private var _jump:int;
		
		private var _xVelocity:Number;
		

		
		//protected ArrayList levelBlocks = new ArrayList();
		//protected Player player = null;

		public function Player(x:int, y:int, xVelocity:int = 120) 
		{
			super(x, y);
			//acceleration.x = 100;
			acceleration.y = 00; //Set the gravity - 1200
            //maxVelocity.x = 00; // 300
            maxVelocity.y = 00; // 300
			
			_xVelocity = xVelocity;
			velocity.x = 0;
			velocity.y = 0;
			
			
			//Load graphic
			loadGraphic(BobSkin, true, true, 68, 96);
			
			//Create basic animations
			addAnimation("walk", [0, 1, 2], 10);
			addAnimation("stay", [0]);
		}
		
		override public function update():void
		{
				
			this.y = Math.min(this.y, FlxG.height - this.height);
			
			FlxG.log(this.y);
			
			if (this.y >= 384)
			{
				acceleration.y = 0;				
			}
			
			//Move left
			if (FlxG.keys.LEFT || FlxG.keys.A)
			{
				facing = LEFT;
				velocity.x = -_xVelocity;
				play("walk");
			}
			
			//Move right
			if (FlxG.keys.RIGHT || FlxG.keys.D)
			{
				facing = RIGHT;
				velocity.x = _xVelocity;
				play("walk");
			}
			
			//Jumping
			if((_jump >= 0) && ((FlxG.keys.UP) || (FlxG.keys.W)))
            {
                _jump += FlxG.elapsed;
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
			
			//Stop moving
			if (FlxG.keys.justReleased("LEFT") || FlxG.keys.justReleased("A") || FlxG.keys.justReleased("RIGHT") || FlxG.keys.justReleased("D"))
			{
				velocity.x = 0;
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