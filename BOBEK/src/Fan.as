package  
{
	import org.flixel.*;
	
	public class Fan extends FlxSprite
	{
		[Embed(source = "../media/elements/fans.png")] private var fanImg:Class;
		[Embed(source = "../media/elements/fans_side.png")] private var fanSideImg:Class;
		[Embed(source = "../media/elements/fans_down.png")] private var fanDownImg:Class;
		
		
		private var _type:String;
		private var _dir:String;
		public var radius:int = 400;
		public var power:int = 100;
		
		private var state:PlayState = FlxG.state as PlayState;
		private var player:Player = state.Bob;
		
		public function Fan(x:int, y:int, direction:String, type:String) 
		{
			super(x, y);
			fixed = true;
			if (direction == "up")
				loadGraphic(fanImg, true, false, 54, 36);
				
			else if(direction == "right")
				loadGraphic(fanSideImg, true, true, 36, 53);
				
			else if(direction == "left")
				loadGraphic(fanSideImg, true, true, 36, 53);
				
			else 
				loadGraphic(fanDownImg, true, false, 54, 36);
			
			switch (type) 
			{
				case "forward":
					addAnimation("forward", [0, 1, 2, 3], 15);
				break;
				case "backward":
					addAnimation("backward", [3, 2, 1, 0], 15);
				break;
				//TODO: add switching!!
				default:
				break;
			}
				
			_type = type;
			_dir = direction;
		}
		public function AddToState(st:FlxState):void
		{
			st.add(this);
			this.play(_type);
		}
		override public function update():void 
		{
			super.update();
			
			if (_dir == "up") 
			{
				if (player.x > x - 20 && player.x < x + width + 20 && player.y < y && player.y > y - radius)
				{
					if (_type == "forward")
					{
						player.y -= FlxG.elapsed * power;
					}
					else if (_type == "backward")
					{
						player.y += FlxG.elapsed * power;
					}
				}
			}
			else if (_dir == "right")
			{
				if (player.x > x + width && player.x < x + radius && player.y < y + 20 && player.y > y - 20)
				{
					if (_type == "forward")
					{
						player.x += FlxG.elapsed * power;
					}
					else if (_type == "backward")
					{
						player.x -= FlxG.elapsed * power;
					}
				}
			}
			else if (_dir == "left")
			{
				if (player.x > x - radius && player.x + player.width < x && player.y < y + 20 && player.y > y - 20)
				{
					if (_type == "forward")
						player.x -= FlxG.elapsed * power;
						
					else if (_type == "backward")
						player.y += FlxG.elapsed * power;
				}
			}
			else
			{
				if (player.x > x - 20 && player.x < x + width + 20 && player.y < y - radius && player.y > y - height)
				{
					if (_type == "forward")
							player.y += FlxG.elapsed * power;
						
					else if (_type == "backward")
							player.y -= FlxG.elapsed * power;		
				}
			}
			
			player.collide(this);			
		}
	}

}