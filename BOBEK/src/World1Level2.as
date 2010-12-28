package
{
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
 
	public class World1Level2 extends FlxState
	{ 
		private var Bob:Player;		
		private var OneEnemy:Enemy;		
		private var map:World1Level2Map;
		
		
		public function World1Level2()
		{
			super();
			bgColor = 0xff66b3ad;
		}
		
		override public function create():void
		{
			Bob = new Player(50, 400, 136);
			OneEnemy = new Enemy(700, 400, 1);
			map = new World1Level2Map;
			map.AddToState(this);
			FlxU.setWorldBounds(0,0,map._map.width,map._map.height);
			
			add(Bob);
			add(OneEnemy);
			FlxG.follow(Bob);
			FlxG.followBounds(0, 0, map._map.width, map._map.height);
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
			CheckPosition();
			FlxU.collide(Bob, map._map);
			FlxU.collide(Bob, map._traps);
			FlxU.collide(Bob, map._candies);
			FlxU.collide(OneEnemy, map._map);
			map.collide();
		}
		public function CheckPosition():void {
			if ((Bob.x + Bob.width < 0) || (Bob.y < 0) || (Bob.y > map._map.height)) {
				FlxG.fade.start(0xffffffff, 0.2, restart);
			}
		}
		public function restart():void {
			FlxG.state = new World1Level2();
		}
		
	}
}