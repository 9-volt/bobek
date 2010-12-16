package  
{
	
	import org.flixel.*; 
	[SWF(width="640", height="480", backgroundColor="#FFFFFF")]
 
	public class BobGame extends FlxGame
	{
		FlxU.seed = 12345;
		public function BobGame()
		{
			super(640, 480 ,PlayState,1);
		}
	}
}