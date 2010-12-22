package
{
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{ 
		private var Bob:Player;		
		private var OneEnemy:Enemy;		
		private var map:Map;
		
		
		public function PlayState()
		{
			super();
			bgColor = 0xff66b3ad;
		}
		
		override public function create():void
		{
			Bob = new Player(100, 400, 136);
			OneEnemy = new Enemy(600, 400, 1);
			map = new Map;
			map.AddToState(this);
			FlxU.setWorldBounds(0,0,map._map.width,map._map.height);
			
			add(Bob);
			add(OneEnemy);
			FlxG.follow(Bob);
			FlxG.followBounds(0,0,map._map.width,map._map.height);
			super.create();
		}
		
		override public function update():void 
		{
			FlxU.setWorldBounds(0,0,map._map.width,map._map.height);
			
			
			if (FlxG.keys.justPressed("R")) {
				FlxG.fade.start(0xffffffff, 0.2, restart);
			}
			super.update(); 
			map.update();
			FlxU.collide(Bob, map._map);
			FlxU.collide(Bob, map._traps);
			FlxU.collide(OneEnemy, map._map);
			map.collide();
		}
		public function restart():void {
			FlxG.state = new PlayState();
		}
		
	}
}