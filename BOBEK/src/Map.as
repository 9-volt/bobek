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
		[Embed(source = "../media/hillstest.png")] private var hillsImg:Class;
		
		
		public var _map:FlxTilemap;
		public var _hills:FlxSprite;
		public var _clouds:FlxGroup;
		//public var _foreground:FlxTilemap;
		
		 
		public function Map()
		{
			
			var grid_size:int = 16;
			
			_hills = new FlxSprite(100, 100, hillsImg);
			
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(new layer1_string, blocks_img, grid_size, grid_size);
			
			//init _clouds
			InitEnv();
			
		
		}
		//initializes all the environment: clouds, hills.
		
		private function InitEnv():void 
		{
			_clouds = new FlxGroup();
			var scrollFactorX:Number = 0.3;
			var tempSprite:FlxSprite;
			
			tempSprite = new FlxSprite(400, 20, cloud_img);
			tempSprite.velocity.x = -5;
			tempSprite.scrollFactor.x = scrollFactorX;
			_clouds.add(tempSprite);
			
			tempSprite = new FlxSprite(900, 25, cloud2_img);
			tempSprite.velocity.x = -7;
			tempSprite.scrollFactor.x = scrollFactorX;
			_clouds.add(tempSprite);
			
			
			//we put hills in the middle so that a couple of clouds will be rendered amongst them
			_hills = new FlxSprite(100, 100, hillsImg);
			_hills.scrollFactor.x = 0.6;
			_hills.scrollFactor.y = 0.7;
			
			_clouds.add(_hills);
			
			
			
			
			
			tempSprite = new FlxSprite(1100, 15, cloud2_img);
			tempSprite.velocity.x = -3;
			tempSprite.scrollFactor.x = scrollFactorX;
			tempSprite.facing = FlxSprite.LEFT;
			_clouds.add(tempSprite);
			
			tempSprite = new FlxSprite(200, 22, cloud3_img);
			tempSprite.velocity.x = -8;
			tempSprite.scrollFactor.x = scrollFactorX;
			_clouds.add(tempSprite);
			
			tempSprite = new FlxSprite(600, 30, cloud3_img);
			tempSprite.velocity.x = -6;
			tempSprite.scrollFactor.x = scrollFactorX;
			tempSprite.facing = FlxSprite.LEFT;
			_clouds.add(tempSprite);
			
			
			tempSprite = new FlxSprite(1300, 5, cloud_img);
			tempSprite.velocity.x = -7;
			tempSprite.scrollFactor.x = scrollFactorX;
			_clouds.add(tempSprite);
			
			
		}
		public function AddToState(st:FlxState):void
		{
			st.add(_clouds);
			st.add(_map);
		}
		public function update():void
		{
			_map.update();
			_clouds.update();
		}
		
	}

}