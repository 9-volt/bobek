package  
{
	import org.flixel.*;
	public class Map
	{
		
		[Embed(source = "../media/tiles.png")] private var blocks_img:Class;
		[Embed(source = "../media/Level1Layer1.txt", mimeType="application/octet-stream")] private var layer1_string:Class;
		
		public var _map:FlxTilemap;
		
		//public var _foreground:FlxTilemap;
		
		 
		public function Map()
		{
			
			var grid_size:int = 16;
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(new layer1_string, blocks_img, grid_size, grid_size);
			
		// initialize background
			
		
		}
		public function AddToState(st:FlxState):void
		{
			st.add(_map);
			
		}
		public function update():void
		{
			_map.update();
			//_background.update();
			//_foreground.update();
		}
		
	}

}