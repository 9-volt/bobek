package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		private var Bob:Player;
		override public function create():void
		{
			bgColor = 0xff783629;
			
			Bob = new Player(100, 100);
			add(Bob);
		}
	}
}