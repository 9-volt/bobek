package  
{
	import org.flixel.*;
	public class Message extends FlxText
	{
		[Embed(source = "../media/fonts/font.ttf", fontFamily = "msgFont")] 	public	var	msgFont:String
		
		private var _text:FlxText;
		public var radiusX:int = 50;
		public var radiusY:int = 150;
		private var startedShowing:Boolean = false;
		private var _width:int;
		
		private var state:PlayState = FlxG.state as PlayState;
		private var player:Player = state.Bob;
		
		public function Message(x:int,y:int, w:int, msg:String) 
		{
			super(x, y, w, "",true);
			setFormat("msgFont", 42, 0xFFFFFF, "center", 0xFF000000);
			text = msg;
			alpha = 0;
			_width = w;
			
		}
		public function AddToState(st:FlxState):void
		{
			st.add(this);
		}
		public override function update():void 
		{
			if (player.x > x + _width/2 - radiusX && player.x < x + _width/2 + radiusX && player.y > y - radiusY && player.y < y + radiusY)
			{
				startedShowing = true;
				}
			if (startedShowing)
			{
				if (alpha < 255)
				{
					alpha += FlxG.elapsed / 2;
				}
			}
		}
	}

}