package  
{
	import adobe.utils.CustomActions;
	import flash.utils.Timer;
	import org.flixel.*;
	public class Map
	{
		
		[Embed(source = "../media/elements/tiles.png")] private var blocks_img:Class;
		[Embed(source = "../media/sky_gradient.png")] private var hillsImg:Class;
		
		private var _texts:Array = [
									"Hello",
									"This is a test message #1",
									"This is test msg #2"];
		private var _triggeredTexts:FlxGroup;
									
		public var _map:FlxTilemap;
		
		public var _traps:FlxGroup;
		public var _candies:FlxGroup;
		private var _fans:FlxGroup;
		
		private var _farBg:FlxSprite;
		private var _nearBg:FlxSprite;
		
		private var _levelString:String;
		private var _levelArr:Array;
		private var _mapWidth:int;
		
		 
		public function Map(str:Class)
		{
			_levelString = new String(new str);
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
			_triggeredTexts = new FlxGroup();
			
			var _trap : Trap;
			var _candy :Candy;
			var _fan :Fan;
			var _text:Message;
			var _textCounter:int = 0;
			
			
			for (var i:int = 0; i < _levelArr.length; i++) 
			{
				var ch: String = _levelArr[i];
				switch( ch )
				{
					case "1":
					case "2":
					case "3":
					case "4":
					case "5":
					case "6":
					case "7":
						_candy = new Candy((i % _mapWidth) * 16, int(i / _mapWidth) * 16, ch );
						
						_candies.add(_candy);
						_levelArr[i] = "0";
						break;
					case "12":
						_trap = new Trap((i % _mapWidth) * 16 + 4, int(i / _mapWidth) * 16 + 64);
						
						_traps.add(_trap);
						_levelArr[i] = "0";
						break;
					case "14":
						_fan = new Fan((i % _mapWidth) * 16, int(i / _mapWidth) * 16 + 7, "up", "forward");
						_fans.add(_fan);
						_levelArr[i] = "0";
						break;
					case "18":
						_fan = new Fan((i % _mapWidth) * 16 - 4, int(i / _mapWidth) * 16 - 2 , "right", "forward");
						_fans.add(_fan);
						_levelArr[i] = "0";
						break;
					case "28": // text trigger
						if (_textCounter < _texts.length)
						{
							_text = new Message((i % _mapWidth) * 16 , int(i / _mapWidth) * 16, 300, _texts[_textCounter]);
							_triggeredTexts.add(_text);
							_textCounter++;
						}
						_levelArr[i] = "0";
						break;
				}
			}
		}
		public function AddToState(st:PlayState):void
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
				var tempcandy:Candy = _candies.members[k] as Candy;
				tempcandy.AddToState(st);
			}
			for (i = 0; i < _triggeredTexts.members.length; i++) 
			{
				var tempText:FlxText = _triggeredTexts.members[i] as FlxText;
				st.add(tempText);
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
			for (i = 0; i < _triggeredTexts.members.length; i++) 
			{
				var tempText:FlxText = _triggeredTexts.members[i] as FlxText;
				if (tempText.visible)
				{
					tempText.update();
				}
			}
			
			for (var j:int = 0; j < _candies.members.length; j++) 
			{
				var tempcandy:Candy = _candies.members[j] as Candy;
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