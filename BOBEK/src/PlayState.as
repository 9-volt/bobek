package
{
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{ 
		private var Bob:Player;
		
		
		private var map:Map;
		
		public function PlayState()
		{
			super();
			bgColor = 0xff783629;
		}
		
		override public function create():void
		{
			Bob = new Player(100, 200, 136);
			map = new Map;
			map.AddToState(this);
			
			
			add(Bob);
			FlxG.follow(Bob);
			super.create();
		}
		
		override public function update():void 
		{
			map.collide(Bob);
			map.update();
			super.update();
		}
		
	}
}