package
{
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{ 
		private var Bob:Player;		
		private var map:Map;
		
		private var hasFlashed:Boolean = false;
		
		public function PlayState()
		{
			super();
			bgColor = 0xff66b3ad;
		}
		
		override public function create():void
		{
			Bob = new Player(100, 450, 136);
			map = new Map;
			map.AddToState(this);
			FlxU.setWorldBounds();
			
			add(Bob);
			FlxG.follow(Bob);
			FlxG.followBounds(0,0,map._map.width,map._map.height);
			super.create();
		}
		
		override public function update():void 
		{
			FlxU.setWorldBounds(Bob.x - 400, Bob.y - 400, 800, 800);
			
			if (!hasFlashed) {
				FlxG.flash.start();
				hasFlashed = true;
			}
			
			super.update();
			map.update();
			FlxU.collide(Bob, map._map);
		}
		
	}
}