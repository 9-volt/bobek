package  
{
	import adobe.utils.CustomActions;
	import flash.utils.Timer;
	import org.flixel.*;
	public class World1Level2Map
	{
		
		[Embed(source = "../media/tiles.png")] private var blocks_img:Class;
		[Embed(source = "../media/levels/World1Level2.txt", mimeType = "application/octet-stream")] private var layer1_string:Class;
		[Embed(source = "../media/sky_gradient.png")] private var hillsImg:Class;
		[Embed(source = "../media/bg_back.png")] private var bg1Img:Class;
		[Embed(source = "../media/bg_front.png")] private var bg2Img:Class;
		
		
		public var _map:FlxTilemap;
		public var _hills:FlxSprite;
		public var _environment:FlxGroup;
		public var _traps:FlxGroup;
		public var _sun:FlxSprite;
		public var _candies:FlxGroup;
		public var _farBg:FlxSprite;
		public var _nearBg:FlxSprite;
		
		
		 
		public function World1Level2Map()
		{
			
			var grid_size:int = 16;
			
			
		 
			
			
			//initialize main map
			_map = new FlxTilemap;
			_map.loadMap(new layer1_string, blocks_img, grid_size, grid_size);
			
			
			//init _environment
			InitEnv();
			InitCandies();
			InitTraps();
			
		
		}
		private function InitTraps():void {
			_traps = new FlxGroup();
			
			var _trap : Trap;
			_trap = new Trap(320, 672+56);
			_traps.add(_trap);
			
			
		}
		private function InitCandies():void
		{
			_candies = new FlxGroup();
			
			var tempCandy:Kanfeata = new Kanfeata(640, 672);
			_candies.add(tempCandy);
			
			tempCandy = new Kanfeata(240, 783);
			_candies.add(tempCandy);
			
			
		}
		
		//initializes all the environment: clouds, hills.
		
		private function InitEnv():void 
		{
			_environment = new FlxGroup();
			var scrollFactorX:Number = 0.3;
			var scrollFactorY:Number = 0.8;
			
		}
		public function AddToState(st:FlxState):void
		{
			st.add(_environment);
			_nearBg = new FlxSprite(0, 300, bg2Img);
			_nearBg.scrollFactor.x = 0.4;
			_nearBg.scrollFactor.y = 0.2;
			
			_farBg = new FlxSprite(0, 100, bg1Img);
			_farBg.scrollFactor.x = 0.3;
			_farBg.scrollFactor.y = 0.1;
			
			st.add(_farBg);
			st.add(_nearBg);
			
			st.add(_map);
			for (var i:int = 0; i < _traps.members.length; i++) 
			{
				var temptrap:Trap = _traps.members[i] as Trap;
				temptrap.AddToState(st);
				
			}
			for (var j:int = 0; j < _candies.members.length; j++) 
			{
				var tempcandy:Kanfeata = _candies.members[j] as Kanfeata;
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
			_environment.update();
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