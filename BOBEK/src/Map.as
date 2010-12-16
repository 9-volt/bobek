package  
{
	import org.flixel.*;
	public class Map
	{
		
		[Embed(source = "../media/tiles.png")] private var blocks_img:Class;
		[Embed(source = "../media/Level1Layer1.txt", mimeType = "application/octet-stream")] private var layer1_string:Class;
		[Embed(source = "../media/mini/cloud.png")] private var cloud_img:Class;
		[Embed(source = "../media/mini/cloud2.png")] private var cloud2_img:Class;
		
		public var _map:FlxTilemap;
		private var _cloud1:FlxSprite;
		private var _cloud2:FlxSprite;
		//public var _foreground:FlxTilemap;
		
		 
		public function Map()
		{
			
			var grid_size:int = 16;
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(new layer1_string, blocks_img, grid_size, grid_size);
			
			//init clouds
			_cloud1 = new FlxSprite(400, 20, cloud_img);
			_cloud1.velocity.x = -5;
			_cloud2 = new FlxSprite(600, 25, cloud2_img);
			_cloud2.velocity.x = -7;
			
			
		
		}
		public function AddToState(st:FlxState):void
		{
			st.add(_cloud1);
			st.add(_cloud2);
			st.add(_map);
			
		}
		public function update():void
		{
			_map.update();
			_cloud1.update();
			_cloud2.update();
			//_background.update();
			//_foreground.update();
		}
		
	}

}