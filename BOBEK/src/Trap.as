package  
{
	import flash.net.URLLoaderDataFormat;
	import org.flixel.*;
	
	public class Trap extends FlxSprite
	{
		[Embed(source = "../media/trap.png")] private var trap_img:Class;
		[Embed(source = "../media/trap_part.png")] private var trap_part_img:Class;
		
		public var emitter:FlxEmitter;
		public var broken:Boolean;
		public var broke:Boolean;
		private var counter:Number;
		
		public function Trap(x:Number, y:Number) 
		{
			//the editor coordinates have to be changed:
			//trap.x = trap_map.x - 8
			//trap.y = trap_map.y - 64
			super(x - 8, y - 64);
			
			loadGraphic(trap_img);
			
			fixed = true;
			
			broken = false;
			broke = false;
			counter = 0;
			
			
			emitter = new FlxEmitter(); //x and y of the emitter
			emitter.width = width - 40;
			emitter.x = x + 17;
			emitter.y = y - 44;
			emitter.setXSpeed(0, 10);
			emitter.setYSpeed(0, 10);
			emitter.setRotation(0, 10);
			emitter.gravity = 80;
			
			emitter.createSprites(trap_part_img, 50, 16, true, 0.8);
			//
			//var particles:int = 10;			 
			//for(var i:int = 0; i < particles; i++)
			//{
				//var particle:FlxSprite = new FlxSprite();
				//particle.
				//emitter.add(particle);
			//}
			
		}
		override public function hitTop(Contact:FlxObject, Velocity:Number):void
		{
			super.hitTop(Contact, Velocity);
			if (!broken)
			{
				broken = true;
				FlxG.quake.start(0.01);
			}
		}
		public function Break():void
		{
			emitter.start(true, 2000);
			broken = true;
			solid = false;
			visible = false;
		}
		override public function update():void 
		{
			//if(!broken)
				super.update();
			if (broken && visible)
				counter += FlxG.elapsed;
			if (counter >= 0.7 && !broke)
			{
				Break();
				broke = true;
			}
			emitter.update();
		}
		public function AddToState(st:FlxState):void {
			st.add(this);
			st.add(emitter);
		}
	}

}