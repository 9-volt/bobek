package  
{
	import adobe.utils.CustomActions;
	import flash.utils.Timer;
	import org.flixel.*;
	public class Map
	{
		
		[Embed(source = "../media/tiles.png")] private var blocks_img:Class;
		[Embed(source = "../media/Level1Layer1.txt", mimeType = "application/octet-stream")] private var layer1_string:Class;
		[Embed(source = "../media/sky_gradient.png")] private var hillsImg:Class;

		public var _map:FlxTilemap;
		
		public var _traps:FlxGroup;
		public var _candies:FlxGroup;
		public var _fans:FlxGroup;
		
		public var _farBg:FlxSprite;
		public var _nearBg:FlxSprite;
		
		private var _levelString:String;
		private var _levelArr:Array;
		private var _mapWidth:int;
		 
		public function Map()
		{
			
			_levelString = new String(new layer1_string);
			_levelArr = _levelString.split(",");
			_mapWidth = 768/2 - 1;
			
			var grid_size:int = 16;
			
			
			InitStuff();
			
			_levelString = _levelArr.join();
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(_levelString, blocks_img, grid_size, grid_size);
			
			
			
			
		
		}
		private function InitStuff():void {
			
			_traps = new FlxGroup();
			_candies = new FlxGroup();
			_fans = new FlxGroup();
			
			var _trap : Trap;
			var _candy :Kanfeata;
			var _fan :Fan;
			
			
			for (var i:int = 0; i < _levelArr.length; i++) 
			{
				var ch: String = _levelArr[i];
				if (ch == "12")
				{
					_trap = new Trap((i % _mapWidth) * 16 + 4, int(i / _mapWidth) * 16 + 64);
					
					_traps.add(_trap);
					_levelArr[i] = "0";
				}
				if (ch == "13")
				{
					_candy = new Kanfeata((i % _mapWidth) * 16, int(i / _mapWidth) * 16 );
					_candies.add(_candy);
					_levelArr[i] = "0";
				}
				if (ch == "14")
				{
					_fan = new Fan((i % _mapWidth) * 16, int(i / _mapWidth) * 16 + 7, "up", "forward");
					_fans.add(_fan);
					_levelArr[i] = "0";
				}
				if (ch == "18")
				{
					_fan = new Fan((i % _mapWidth) * 16 - 4, int(i / _mapWidth) * 16 - 2 , "right", "forward");
					_fans.add(_fan);
					_levelArr[i] = "0";
				}
			}
		}
		public function AddToState(st:FlxState):void
		{
			
			for (var j:int = 0; j < _fans.members.length; j++) 
			{
				var tempfan:Fan = _fans.members[j] as Fan;
				tempfan.AddToState(st);
			}
			
			st.add(_map);
			
			for (var i:int = 0; i < _traps.members.length; i++) 
			{
				var temptrap:Trap = _traps.members[i] as Trap;
				temptrap.AddToState(st);
				
			}
			for (var k:int = 0; k < _candies.members.length; k++) 
			{
				var tempcandy:Kanfeata = _candies.members[k] as Kanfeata;
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
			for (j = 0; j < _fans.members.length; j++) 
			{
				var tempfan:Fan = _fans.members[j] as Fan;
				if(tempfan.visible)
					tempfan.update();
			}
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