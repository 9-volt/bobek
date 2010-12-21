package  
{
	import org.flixel.*;

	public class Kanfeata extends FlxSprite
	{
		[Embed(source = "../media/kanfeata.png")] private var image:Class;
		public function Kanfeata(x:Number, y:Number) 
		{
			super(x, y);
			loadGraphic(image, true, false, 30, 22);
			addAnimation("spin", [0, 1, 2, 3], 3, true);
			play("spin");
		}
		override public function update():void 
		{
			super.update();
		}
	}

}