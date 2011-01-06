package
{
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{ 
		public var Bob:Player;		
		private var OneEnemy:Enemy;		
		private var map:Map;
		
		
		public function PlayState()
		{
			super();
			bgColor = 0xff66b3ad;
		}
		
		override public function create():void
		{
			Bob = new Player(100, 600, 136, this);
			OneEnemy = new Enemy(900, 600, 1);
			map = new Map;
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
			if (FlxG.keys.justPressed("N")) {
				FlxG.fade.start(0xffffffff, 0.2, NextLevel);
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
			if (Bob.x > map._map.width)
				FlxG.state = new World1Level2();
		}
		public function restart():void {
			FlxG.state = new PlayState();
		}
		public function NextLevel():void {
			FlxG.state = new World1Level2;
		}
		
	}
}