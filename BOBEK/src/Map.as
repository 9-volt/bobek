package  
{
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
		//public var _foreground:FlxTilemap;
		
		 
		public function Map()
		{
			
			var grid_size:int = 16;
			
			
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(new layer1_string, blocks_img, grid_size, grid_size);
			
			//init _environment
			InitEnv();
			
		
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
			
			
			
			tempSprite = new FlxSprite(400, 80, cloud_img);
			tempSprite.velocity.x = -5;
			tempSprite.scrollFactor.x = scrollFactorX;
			tempSprite.scrollFactor.y = scrollFactorY;
			_environment.add(tempSprite);
			
			
			
			tempSprite = new FlxSprite(900, 55, cloud2_img);
			tempSprite.velocity.x = -7;
			tempSprite.scrollFactor.x = scrollFactorX;
			tempSprite.scrollFactor.y = scrollFactorY;

			_environment.add(tempSprite);
			
			
			//we put hills in the middle so that a couple of clouds will be rendered amongst them
			_hills = new FlxSprite(0, 360, hillsImg);
			_hills.scrollFactor.x = 0.6;
			_hills.scrollFactor.y = 0.7;
			
			_environment.add(_hills);
			
			
			
			
			
			tempSprite = new FlxSprite(1100, 75, cloud2_img);
			tempSprite.velocity.x = -3;
			tempSprite.scrollFactor.x = scrollFactorX;
			tempSprite.scrollFactor.y = scrollFactorY;
			tempSprite.facing = FlxSprite.LEFT;
			_environment.add(tempSprite);
			
			tempSprite = new FlxSprite(200, 82, cloud3_img);
			tempSprite.velocity.x = -8;
			tempSprite.scrollFactor.x = scrollFactorX;
			tempSprite.scrollFactor.y = scrollFactorY;
			_environment.add(tempSprite);
			
			tempSprite = new FlxSprite(600, 100, cloud3_img);
			tempSprite.velocity.x = -6;
			tempSprite.scrollFactor.x = scrollFactorX;
			tempSprite.scrollFactor.y = scrollFactorY;
			tempSprite.facing = FlxSprite.LEFT;
			_environment.add(tempSprite);
			
			
			tempSprite = new FlxSprite(1300, 75, cloud_img);
			tempSprite.velocity.x = -7;
			tempSprite.scrollFactor.x = scrollFactorX;
			tempSprite.scrollFactor.y = scrollFactorY;
			_environment.add(tempSprite);
			
			
		}
		public function AddToState(st:FlxState):void
		{
			st.add(_environment);
			st.add(_map);
		}
		public function update():void
		{
			_map.update();
			_environment.update();
		}
		
	}

}