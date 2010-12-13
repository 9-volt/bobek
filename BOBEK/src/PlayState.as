package
{
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		public var level:Map;
		private var Bob:Player;
		
		override public function create():void
		{
			bgColor = 0xff783629;
			
			level = new Map();
			
			Bob = new Player(100, 200, 136);
			add(Bob);
		}
	}
}