package  
{
	import adobe.utils.CustomActions;
	import flash.utils.Timer;
	import org.flixel.*;
	public class World1Level2Map
	{
		
		[Embed(source = "../media/tiles.png")] private var blocks_img:Class;
		[Embed(source = "../media/levels/World1Level2.txt", mimeType = "application/octet-stream")] private var layer1_string:Class;
		[Embed(source = "../media/mini/cloud.png")] private var cloud_img:Class;
		[Embed(source = "../media/mini/cloud2.png")] private var cloud2_img:Class;
		[Embed(source = "../media/mini/cloud3.png")] private var cloud3_img:Class;
		[Embed(source = "../media/sun.png")] private var sun_img:Class;
		[Embed(source = "../media/hillstest.png")] private var hillsImg:Class;
		
		
		public var _map:FlxTilemap;
		public var _hills:FlxSprite;
		public var _environment:FlxGroup;
		public var _traps:FlxGroup;
		public var _sun:FlxSprite;
		public var _candies:FlxGroup;
		
		 
		public function World1Level2Map()
		{
			
			var grid_size:int = 16;
			
			
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(new layer1_string, blocks_img, grid_size, grid_size);
			
			
			//init _environment
			InitEnv();
			InitCandies();
			InitTraps();
			
		
		}
		private function InitTraps():void {
			_traps = new FlxGroup();
			
			var _trap : Trap;
			_trap = new Trap(320, 672+56);
			_traps.add(_trap);
			
			_trap = new Trap(112, 592+40);
			_traps.add(_trap);
			
			_trap = new Trap(416+48, 768+56);
			_traps.add(_trap);
			
			
		}
		private function InitCandies():void
		{
			_candies = new FlxGroup();
			
			var tempCandy:Kanfeata = new Kanfeata(640, 672);
			_candies.add(tempCandy);
			
			tempCandy = new Kanfeata(240, 783);
			_candies.add(tempCandy);
			
			tempCandy = new Kanfeata(208, 752);
			_candies.add(tempCandy);
			
			tempCandy = new Kanfeata(176, 736);
			_candies.add(tempCandy);
			
			tempCandy = new Kanfeata(640, 672);
			_candies.add(tempCandy);
			
		}
		
		//initializes all the environment: clouds, hills.
		
		private function InitEnv():void 
		{
			_environment = new FlxGroup();
			var scrollFactorX:Number = 0.3;
			var scrollFactorY:Number = 0.8;
			var tempSprite:FlxSprite;
			
			_sun = new FlxSprite(400, 110, sun_img);
			_sun.scrollFactor.x = 0.2;
			_sun.scrollFactor.y = 0.8;
			_environment.add(_sun);
			
			
			_hills = new FlxSprite(0, 460, hillsImg);
			_hills.scrollFactor.x = 0.6;
			_hills.scrollFactor.y = 0.7;
			
			_environment.add(_hills);
			
			
			
			for (var i:int = 0; i < 10; i++) 
			{
				
				var rndX:Number = FlxU.random() * 2000;
				var rndY:Number = FlxU.random() * 120 + 100;
				var rndFactor:Number = FlxU.random() / 5;
				var rndSpeed:Number = FlxU.random() * 5;
				var rndKind:Number = int(FlxU.random()*3); // so that it would generate 0,1 or 2
				
					switch (rndKind)
					{
						case 0:
							tempSprite = new FlxSprite(rndX, rndY, cloud_img);
							break;
						case 1:
							tempSprite = new FlxSprite(rndX, rndY, cloud2_img);
							break;
						case 2:
							tempSprite = new FlxSprite(rndX, rndY, cloud3_img);
							break;
						default:
							
						break;
					}
				tempSprite.velocity.x = -5 - rndSpeed;
				tempSprite.scrollFactor.x = scrollFactorX + rndFactor;
				tempSprite.scrollFactor.y = scrollFactorY;
				_environment.add(tempSprite);
			}
		}
		public function AddToState(st:FlxState):void
		{
			st.add(_environment);
			st.add(_map);
			for (var i:int = 0; i < _traps.members.length; i++) 
			{
				var temptrap:Trap = _traps.members[i] as Trap;
				temptrap.AddToState(st);
				
			}
			for (var j:int = 0; j < _candies.members.length; j++) 
			{
				var tempcandy:Kanfeata = _candies.members[j] as Kanfeata;
				tempcandy.AddToState(st);
			}
		}
		public function update():void
		{
			_map.update();
			for (var i:int = 0; i < _traps.members.length; i++) 
			{
				var temptrap:Trap = _traps.members[i] as Trap;
				if(temptrap.visible)
					temptrap.update();
			}
			
			for (var j:int = 0; j < _candies.members.length; j++) 
			{
				var tempcandy:Kanfeata = _candies.members[j] as Kanfeata;
				if(tempcandy.visible)
					tempcandy.update();
			}
			_environment.update();
		}
		public function collide():void
		{
			for (var i:int = 0; i < _traps.members.length; i++) 
			{
				var temptrap:Trap = _traps.members[i] as Trap;
				FlxU.collide(temptrap.emitter, _map);
				FlxU.collide(temptrap.shakeEmitter, _map);
			}
			
		}
		
	}

}