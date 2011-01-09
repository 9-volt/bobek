package  
{
	import org.flixel.*;
	public class Spike extends FlxSprite
	{
		[Embed(source = "../media/elements/teeth_large.png")] private var largeTeethImg:Class;
		[Embed(source = "../media/elements/teeth_not_large.png")] private var smallTeethImg:Class;
		
		private var state:PlayState = FlxG.state as PlayState;
		private var player:Player = state.Bob as Player;
		
		public function Spike(x:int, y:int, small:Boolean = true) 
		{
			super(x, y);
			fixed = true;
			if (small)
				loadGraphic(smallTeethImg);
			else
				loadGraphic(largeTeethImg);
		}
		
		override public function update():void 
		{
			super.update();
			collide(player);
		}
		override public function hitTop(Contact:FlxObject, Velocity:Number):void 
		{
			super.hitTop(Contact, Velocity);
			if (player == Contact)
				state.restart();
		}
	}

}