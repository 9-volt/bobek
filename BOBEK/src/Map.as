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
		
		public var _map:FlxTilemap;
		
		public var clouds:FlxGroup;
		//public var _foreground:FlxTilemap;
		
		 
		public function Map()
		{
			
			var grid_size:int = 16;
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(new layer1_string, blocks_img, grid_size, grid_size);
			
			//init clouds
			InitClouds();
			
		
		}
		private function InitClouds():void 
		{
			clouds = new FlxGroup();
			
			var tempSprite:FlxSprite;
			
			tempSprite = new FlxSprite(400, 20, cloud_img);
			tempSprite.velocity.x = -5;
			tempSprite.scrollFactor.x = 0.2;
			clouds.add(tempSprite);
			
			tempSprite = new FlxSprite(900, 25, cloud2_img);
			tempSprite.velocity.x = -7;
			tempSprite.scrollFactor.x = 0.2;
			clouds.add(tempSprite);
			
			tempSprite = new FlxSprite(1100, 15, cloud2_img);
			tempSprite.velocity.x = -3;
			tempSprite.scrollFactor.x = 0.2;
			tempSprite.facing = FlxSprite.LEFT;
			clouds.add(tempSprite);
			
			tempSprite = new FlxSprite(200, 22, cloud3_img);
			tempSprite.velocity.x = -7;
			tempSprite.scrollFactor.x = 0.2;
			clouds.add(tempSprite);
			
			tempSprite = new FlxSprite(600, 30, cloud3_img);
			tempSprite.velocity.x = -7;
			tempSprite.scrollFactor.x = 0.2;
			tempSprite.facing = FlxSprite.LEFT;
			clouds.add(tempSprite);
			
			
			tempSprite = new FlxSprite(1300, 5, cloud_img);
			tempSprite.velocity.x = -7;
			tempSprite.scrollFactor.x = 0.2;
			clouds.add(tempSprite);
			
			
		}
		public function AddToState(st:FlxState):void
		{
			st.add(clouds);
			st.add(_map);
			
		}
		public function update():void
		{
			_map.update();
			clouds.update();
			//_background.update();
			//_foreground.update();
		}
		
	}

}