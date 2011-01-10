package  
{
	import adobe.utils.CustomActions;
	import flash.utils.Timer;
	import org.flixel.*;
	public class Map
	{
		
		[Embed(source = "../media/elements/tiles.png")] private var blocks_img:Class;
		[Embed(source = "../media/sky_gradient.png")] private var hillsImg:Class;
		[Embed(source = "../media/elements/clouds/cloud1.png")] private var clouds1Img:Class;
		[Embed(source = "../media/elements/clouds/cloud2.png")] private var clouds2Img:Class;
		[Embed(source = "../media/elements/clouds/cloud3.png")] private var clouds3Img:Class;
		
		
		private var _texts:Array = [
									"Hello",
									"This is a test message #1",
									"This is test msg #2"];
		private var _triggeredTexts:FlxGroup;
									
		public var _map:FlxTilemap;
		
		public var _traps:FlxGroup;
		public var _candies:FlxGroup;
		private var _fans:FlxGroup;
		private var _spikes:FlxGroup;
		private var _clouds:FlxGroup;
		private var _hasClouds:Boolean;
		
		private var _farBg:FlxSprite;
		private var _nearBg:FlxSprite;
		
		private var _levelString:String;
		private var _levelArr:Array;
		private var _mapWidth:int = 0;
		
		 
		public function Map(str:Class, hasClouds:Boolean = true)
		{
			_levelString = new String(new str);
			_levelArr = _levelString.split(",");
		
			//counting map tiles length
			var tempStr:String = _levelString.split("\n")[0];
			for ( var i:int = 0; i < tempStr.length; i ++ )
			{
				if( tempStr.charAt(i) == ',' )
					_mapWidth++;
			}
			
			var grid_size:int = 16;
			
			InitStuff();
			
			_hasClouds = hasClouds;
			
			if (hasClouds)
			{
				InitClouds();
			}
			
			_levelString = _levelArr.join();
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(_levelString, blocks_img, grid_size, grid_size);
		
		}
		private function InitClouds():void {
			_clouds = new FlxGroup();
			var tempSprite:FlxSprite;
			
			
			var scrollFactorX:Number = 1.3;
			var scrollFactorY:Number = 1.2;
			
			for (var i:int = 0; i < 30; i++) 
			{
				
				var rndX:Number = FlxU.random() * _mapWidth * 16;
				var rndY:Number = FlxU.random() * 120 + 850;
				var rndFactor:Number = FlxU.random() / 5;
				var rndSpeed:Number = FlxU.random() * 1;
				var rndKind:Number = int(FlxU.random()*3); // so that it would generate 0,1 or 2
				
					switch (rndKind)
					{
						case 0:
							tempSprite = new FlxSprite(rndX, rndY, clouds1Img);
							break;
						case 1:
							tempSprite = new FlxSprite(rndX, rndY, clouds2Img);
							break;
						case 2:
							tempSprite = new FlxSprite(rndX, rndY, clouds3Img);
							break;
						default:
							
						break;
					}
				tempSprite.velocity.x = -5 - rndSpeed;
				tempSprite.scrollFactor.x = scrollFactorX + rndFactor;
				tempSprite.scrollFactor.y = scrollFactorY;
				_clouds.add(tempSprite);
			}
		}
		private function InitStuff():void {
			
			_traps = new FlxGroup();
			_candies = new FlxGroup();
			_fans = new FlxGroup();
			_triggeredTexts = new FlxGroup();
			_spikes = new FlxGroup();
			
			var _trap : Trap;
			var _candy :Candy;
			var _fan :Fan;
			var _text:Message;
			var _spike:Spike;
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
					case "13":
						_spike= new Spike((i % _mapWidth) * 16 + 4, int(i / _mapWidth) * 16);
						
						_spikes.add(_spike);
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
			for (i = 0; i < _spikes.members.length; i++) 
			{
				var tempSpike:Spike = _spikes.members[i] as Spike;
				st.add(tempSpike);
			}
			
		}
		public function AddFrontLayer(st:PlayState):void
		{
			 
			if (_hasClouds)
			{
				st.add(_clouds);
			}
		}
		public function update():void
		{
			_map.update();
			_spikes.update();
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
			if (_hasClouds)
			{
				_clouds.update();
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