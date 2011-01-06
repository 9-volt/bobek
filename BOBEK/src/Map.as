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
		[Embed(source = "../media/bg_back.png")] private var bg1Img:Class;
		[Embed(source = "../media/bg_front.png")] private var bg2Img:Class;
		
		
		
		public var _map:FlxTilemap;
		public var _hills:FlxBackdrop;
		public var _environment:FlxGroup;
		public var _traps:FlxGroup;
		public var _candies:FlxGroup;
		public var _testmsg:Message;
		public var _testFan:Fan;
		
		public var _farBg:FlxSprite;
		public var _nearBg:FlxSprite;
		
		 
		public function Map()
		{
			
			var grid_size:int = 16;
			_testmsg = new Message(400, 400);
			
			
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
			_trap = new Trap(530, 720);
			_traps.add(_trap);
			
			_trap = new Trap(1800, 500);
			_traps.add(_trap);
			
			_trap = new Trap(2350, 650);
			_traps.add(_trap);
			
			_trap = new Trap(3456, 640);
			_traps.add(_trap);
			
			_trap = new Trap(3552, 640);
			_traps.add(_trap);
			
			_testFan = new Fan(770, 760);
			
		}
		private function InitCandies():void
		{
			_candies = new FlxGroup();
			
			var tempCandy:Kanfeata = new Kanfeata(920, 240);
			_candies.add(tempCandy);
			
			tempCandy = new Kanfeata(990, 200);
			_candies.add(tempCandy);
		}
		
		//initializes all the environment: clouds, hills.
		
		private function InitEnv():void 
		{
			_environment = new FlxGroup();
			var scrollFactorX:Number = 0.3;
			var scrollFactorY:Number = 0.8;
			var tempSprite:FlxSprite;
			
			
			_hills = new FlxBackdrop(hillsImg, 0.6, 0.7, true, false);
			_environment.add(_hills);
			
			//for (var i:int = 0; i < 10; i++) 
			//{
				//
				//var rndX:Number = FlxU.random() * 2000;
				//var rndY:Number = FlxU.random() * 120;
				//var rndFactor:Number = FlxU.random() / 5;
				//var rndSpeed:Number = FlxU.random() * 5;
				//var rndKind:Number = int(FlxU.random()*3); // so that it would generate 0,1 or 2
				//
					//switch (rndKind)
					//{
						//case 0:
							//tempSprite = new FlxSprite(rndX, rndY, cloud_img);
							//break;
						//case 1:
							//tempSprite = new FlxSprite(rndX, rndY, cloud2_img);
							//break;
						//case 2:
							//tempSprite = new FlxSprite(rndX, rndY, cloud3_img);
							//break;
						//default:
							//
						//break;
					//}
				//tempSprite.velocity.x = -5 - rndSpeed;
				//tempSprite.scrollFactor.x = scrollFactorX + rndFactor;
				//tempSprite.scrollFactor.y = scrollFactorY;
				//_environment.add(tempSprite);
			//}
		}
		public function AddToState(st:FlxState):void
		{
			
			
			
			st.add(_environment);
			_testFan.AddToState(st, "forward");
			st.add(_map);
			st.add(_testmsg);
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