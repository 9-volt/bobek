package  
{
	import flash.net.URLLoaderDataFormat;
	import org.flixel.*;
	
	public class Trap extends FlxSprite
	{
		[Embed(source = "../media/mini/trap.png")] private var trap_img:Class;
		[Embed(source = "../media/trap_part.png")] private var trap_part_img:Class;
		[Embed(source = "../media/mini/trap_part.png")] private var trap_shake_part_img:Class;
		[Embed(source="../media/sounds/leaves.mp3")] private var SoundEffect:Class
		
		public var emitter:FlxEmitter;
		public var shakeEmitter:FlxEmitter;
		public var broken:Boolean; // tells us that the player has been on the top
		public var broke:Boolean;  // says the trap is completely broken
		private var counter:Number;
		
		private var time:Number = 1.2;
		private var fadeoutTime:Number = 1.7;
		private var particleFadeoutTime:Number = 4;
		
		
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
			emitter.setYSpeed(0, 30);
			emitter.setRotation(0, 80);
			emitter.gravity = 40;
			
			emitter.createSprites(trap_part_img, 16, 32, true, 0.8);
			
			
			shakeEmitter = new FlxEmitter(); //x and y of the shakeEmitter
			shakeEmitter.width = width - 20;
			shakeEmitter.x = x + 7;
			shakeEmitter.y = y - 20;
			shakeEmitter.setXSpeed(0, 10);
			shakeEmitter.setYSpeed(0, 30);
			shakeEmitter.setRotation(0, 80);
			shakeEmitter.gravity = 20;
			
			shakeEmitter.createSprites(trap_shake_part_img, 28, 32);
			
		}
		override public function hitTop(Contact:FlxObject, Velocity:Number):void
		{
			super.hitTop(Contact, Velocity);
			if (!broken)
			{
				broken = true;
				shakeEmitter.start(false);
			}
		}
		public function Break():void
		{
			emitter.start(true, particleFadeoutTime);
			FlxG.play(SoundEffect);
			shakeEmitter.stop();
			solid = false;
		}
		override public function update():void 
		{
			if(!broken)
				super.update();
			if (broken && visible)
			{
				counter += FlxG.elapsed;
				if (int(counter * 10) % 2 == 0)
				{
					x += 1;
				}
				else x -= 1;
			}
			if (counter >= time)
			{
				if (!broke) {
					Break();
					broke = true;
				}
				else if(fadeoutTime > counter){
					alpha = 1 - (counter / fadeoutTime)
				}
				else 
				{
					visible = false;
				}
				
			}
			emitter.update();
			shakeEmitter.update();
		}
		public function AddToState(st:FlxState):void {
			st.add(this);
			st.add(emitter);
			st.add(shakeEmitter);
		}
	}

}