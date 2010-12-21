package  
{
	import flash.net.URLLoaderDataFormat;
	import org.flixel.*;
	
	public class Trap extends FlxSprite
	{
		[Embed(source = "../media/trap.png")] private var trap_img:Class;
		
		public var emitter:FlxEmitter;
		public var broken:Boolean;
		
		public function Trap(x:Number, y:Number) 
		{
			//the editor coordinates have to be changed:
			//trap.x = trap_map.x - 8
			//trap.y = trap_map.y - 64
			super(x - 8, y - 64);
			
			loadGraphic(trap_img);
			
			
			broken = false;
			
			emitter = new FlxEmitter(); //x and y of the emitter
			emitter.width = width - 10;
			emitter.x = x - 3;
			emitter.y = y - 44;
			emitter.velocity.y = 0;
			emitter.gravity = 800;
			
			var particles:int = 10;
			 
			for(var i:int = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				particle.createGraphic(10, 10, 0xffffffff);
				emitter.add(particle);
			}
			emitter.start(false);
		}
		override public function hitTop(Contact:FlxObject, Velocity:Number):void
		{
			super.hitTop(Contact, Velocity);
		}
		public function Break():void
		{
			
		}
		override public function update():void 
		{
			super.update();
			emitter.update();
		}
	}

}