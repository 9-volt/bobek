package  
{
	import org.flixel.*;
	
	public class Fan extends FlxSprite
	{
		[Embed(source = "../media/fans.png")] private var fanImg:Class;
		
		private var _type:String;
		public var radius:int = 400;
		public function Fan(x:int, y:int ) 
		{
			super(x, y);
			loadGraphic(fanImg, true, false, 54, 36, false);
			addAnimation("forward", [0, 1, 2, 3], 15);
			addAnimation("backward", [3, 2, 1, 0], 15);
			addAnimation("switching", [3, 2, 1, 0, 0, 1, 2, 3], 20);
		}
		public function AddToState(st:FlxState, type:String):void
		{
			st.add(this);
			_type = type;
			this.play(type);
		}
		override public function update():void 
		{
			super.update();
			var state:PlayState = FlxG.state as PlayState;
			var player:Player = state.Bob;
			
			if (player.x > x - 20 && player.x < x + width + 20 && player.y < y && player.y > y - radius)
			{
				if (_type == "forward")
				{
					player.y -= FlxG.elapsed * 200;
				}
				else if (_type == "backward")
				{
					player.velocity.y += 1;
				}
			}
			
			
			
		}
	}

}