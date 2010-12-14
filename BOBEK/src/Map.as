package  
{
	import org.flixel.*;
	public class Map
	{
		
		[Embed(source = "../media/tilesetmare.png")] private var blocks_img:Class;
		public var _map:FlxTilemap;
		
		//public var _background:FlxTilemap;
		//public var _foreground:FlxTilemap;
		
		 
		public function Map()
		{
			
			var grid_size:int = 32;
			
			//initialize main map
			_map = new FlxTilemap;
			var randommap:String = "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 \n \
								    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 \n \
								    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 \n \
								    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 \n \
								    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 \n \
								    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 \n \
								    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 \n \
								    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 \n \
								    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,13,13,13, 0, 0, 0 \n \
								    2,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61, \n \ ";
			//rows
				//for (var i:int = 0; i < 18; i++ )
				//{
					 //columns
					//for (var j:int = 0; j < 24; j++ )
					//{
						//if (i < 12)
						//{
							//randommap += 0;
						//}
						//else if (i == 61) {
							//randommap += 2;
						//}
						//else
						//{
							 //choose a random tile between 1 and 3
							//randommap += int(Math.random() * 3)+1;
						//}
						//randommap += ",";
					//}
					//randommap += "\n";
				//}
			_map.loadMap(randommap, blocks_img, grid_size, grid_size);
			
		// initialize foreground
		
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
		
		public function collide(spr:FlxSprite):void
		{
			FlxU.collide(spr, _map);
		}
		
	}

}