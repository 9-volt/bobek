package
{
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{ 
		
		[Embed(source = "../media/levels/Level1Layer1.txt", mimeType = "application/octet-stream")] private var layer1_string:Class;
		
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
			Bob = new Player(100, 600, 136);
				//edit this to enable player shooting
			Bob._canShoot = true;
			OneEnemy = new Enemy(900, 600, 1);
			map = new Map(layer1_string);
			map.AddToState(this);
			FlxU.setWorldBounds(0,0,map._map.width,map._map.height);
			
			add(Bob);
			add(OneEnemy);
			
			map.AddFrontLayer(this);
			//should be added last for right z-index (visibility)
			Bob.addCandyBar( 20 );
			
			FlxG.follow(Bob);
			FlxG.followBounds(0, 0, map._map.width, map._map.height);
			
			super.create();
			
			FlxG.flash.start(0xffffffff, 0.2);
		}
		
		override public function update():void 
		{
			FlxU.setWorldBounds(0,0,map._map.width,map._map.height);
			
			
			if (FlxG.keys.justPressed("R")) {
				restart();
			}
			super.update(); 
			map.update();
			CheckPosition();
			FlxU.collide(Bob, map._map);
			FlxU.collide(Bob, map._traps);
			FlxU.collide(OneEnemy, map._map);
			map.collide();
		}
		public function CheckPosition():void {
			if ((Bob.x + Bob.width < 0) || (Bob.y < 0) || (Bob.y > map._map.height)) {
				FlxG.fade.start(0xffffffff, 0.2, restart);
			}
		}
		public function restart():void {
			FlxG.state = new PlayState();
		}
		
	}
}