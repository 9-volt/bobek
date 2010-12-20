package  
{
	import adobe.utils.CustomActions;
	import flash.utils.Timer;
	import org.flixel.*;
	public class Map
	{
		
		[Embed(source = "../media/tiles.png")] private var blocks_img:Class;
		[Embed(source = "../media/Level1Layer1.txt", mimeType = "application/octet-stream")] private var layer1_string:Class;
		[Embed(source = "../media/mini/cloud.png")] private var cloud_img:Class;
		[Embed(source = "../media/mini/cloud2.png")] private var cloud2_img:Class;
		[Embed(source = "../media/mini/cloud3.png")] private var cloud3_img:Class;
		[Embed(source = "../media/sun.png")] private var sun_img:Class;
		[Embed(source = "../media/hillstest.png")] private var hillsImg:Class;
		
		
		public var _map:FlxTilemap;
		public var _hills:FlxSprite;
		public var _environment:FlxGroup;
		public var _sun:FlxSprite;
		public var _trap:Trap;
		public var _candies:FlxGroup;
		//public var _foreground:FlxTilemap;
		
		 
		public function Map()
		{
			
			var grid_size:int = 16;
			
			
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(new layer1_string, blocks_img, grid_size, grid_size);
			
			
			_trap = new Trap(784,400);
			
			//init _environment
			InitEnv();
			InitCandies();
			
		
		}
		private function InitCandies():void
		{
			_candies = new FlxGroup();
			
			var tempCandy:Kanfeata = new Kanfeata(920, 240);
			_candies.add(tempCandy);
			
			tempCandy = new Kanfeata(950, 260);
			_candies.add(tempCandy);
		}
		
		//initializes all the environment: clouds, hills.
		
		private function InitEnv():void 
		{
			_environment = new FlxGroup();
			var scrollFactorX:Number = 0.3;
			var scrollFactorY:Number = 0.8;
			var tempSprite:FlxSprite;
			
			_sun = new FlxSprite(400, 10, sun_img);
			_sun.scrollFactor.x = 0.2;
			_sun.scrollFactor.y = 0.8;
			_environment.add(_sun);
			
			
			_hills = new FlxSprite(0, 360, hillsImg);
			_hills.scrollFactor.x = 0.6;
			_hills.scrollFactor.y = 0.7;
			
			_environment.add(_hills);
			
			
			
			for (var i:int = 0; i < 10; i++) 
			{
				
				var rndX:Number = FlxU.random() * 2000;
				var rndY:Number = FlxU.random() * 120;
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
			st.add(_trap);
			st.add(_candies);
		}
		public function update():void
		{
			_map.update();
			_candies.update();
			_trap.update();
			_environment.update();
		}
		
	}

}