package  
{
	import adobe.utils.CustomActions;
	import org.flixel.*;

	public class Kanfeata extends FlxSprite
	{
		[Embed(source = "../media/kanfeata.png")] private var image:Class;		
		[Embed(source = "../media/star_sparkle.png")] private var sparkle_img:Class;
		
		public var got: Boolean = false;	
		public var over:Boolean = false;
		public var emitter:FlxEmitter;
		private var counter:Number;
		private var fadeoutTime :Number = 2;
		
		public function Kanfeata(x:Number, y:Number) 
		{
			super(x, y);
			counter = 0;
			loadGraphic(image, true, false, 30, 22);
			addAnimation("spin", [0, 1, 2, 3], 3, true);
			play("spin");
			
			
			emitter = new FlxEmitter(); //x and y of the emitter
			emitter.x = x + width / 2;
			emitter.y = y + height / 2;
			emitter.gravity = 40;
			emitter.setXSpeed(-50, 50);
			emitter.setYSpeed(-50, 50);
			
			
			
			emitter.createSprites(sparkle_img, 32, 8);
			
		}
		override public function update():void 
		{
			if (!got)
			{
				super.update();
			}
			else
			{
				super.update();
				emitter.update();
				if (visible)
				{
					counter += FlxG.elapsed;
					if(counter < fadeoutTime)
						alpha = 1 - counter / fadeoutTime;
					else {						
						visible = false;
						over = true;
					}
					
				}
			}
			if (over)
			{
				emitter.kill();
			}
			
		}
		override public function hitLeft(Contact:FlxObject, Velocity:Number):void
		{
			GetCandy();
		}
		override public function hitRight(Contact:FlxObject, Velocity:Number):void
		{
			GetCandy();
		}
		override public function hitTop(Contact:FlxObject, Velocity:Number):void
		{
			GetCandy();
		}
		override public function hitBottom(Contact:FlxObject, Velocity:Number):void
		{
			GetCandy();
		}
		public function GetCandy():void
		{
			got = true;
			solid = false; //so that the player won't hit it;	
			emitter.start(true, 2);
		}
		public function AddToState(st:FlxState):void {
			st.add(emitter);
			st.add(this);
		}
	}

}