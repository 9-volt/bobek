package
{
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		public var level:Map;
		private var Bob:Player;
		
		[Embed (source = "../media/bg.png")] private var blocks_img:Class;
		public var blockgrid:FlxTilemap;
		public var grid_size:int = 27;
		
		public function PlayState()
		{
			super();
			bgColor = 0xff783629;
		}
		
		override public function create():void
		{
			
			blockgrid = new FlxTilemap();
			
			// Generate a random tile map (as a string, since that's how FlxTilemap wants it)
			var randommap:String = "";
			// rows
			for (var i:int = 0; i < 18; i++ )
			{
				// columns
				for (var j:int = 0; j < 24; j++ )
				{
					if (i < 13)
					{
						randommap += 0;
					}
					else if (i == 13) {
						randommap += 2;
					}
					else
					{
						// choose a random tile between 1 and 3
						randommap += int(Math.random() * 3)+1;
					}
					randommap += ",";
				}
				randommap += "\n";
			}
			blockgrid.loadMap(randommap, blocks_img, grid_size, grid_size);
			add(blockgrid);
			
			Bob = new Player(100, 200, 136);
			add(Bob);
			FlxG.follow(Bob);
			super.create();
		}
		
		override public function update():void 
		{
			//Set collisions
			FlxU.collide(Bob, blockgrid);
			
			super.update();
		}
	}
}