package  
{
	import org.flixel.*;
	public class Message
	{
		[Embed(source = "../media/font.ttf", fontFamily = "msgFont")] 	public	var	msgFont:String
		
		private var _text:FlxText;
		public var radius:int = 200;
		
		private var state:PlayState = FlxG.state as PlayState;
		private var player:Player = state.Bob;
		
		public function Message(x:int,y:int, w:int, msg:String) 
		{
			_text = new FlxText(x, y, w, "",true);
			_text.setFormat("msgFont", 42, 0xffff00ff, "center", 0xff0000ff);
			_text.text = msg;
			_text.visible = false;
			
		}
		public function AddToState(st:FlxState):void
		{
			st.add(_text);
		}
		public function update():void 
		{
			_text.update();
		}
		
	}

}