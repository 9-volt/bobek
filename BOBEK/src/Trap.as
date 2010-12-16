package  
{
	import flash.net.URLLoaderDataFormat;
	import org.flixel.*;
	
	public class Trap extends FlxSprite
	{
		[Embed(source = "../media/trap.png")] private var trap_img:Class;
		
		public function Trap(x:Number, y:Number) 
		{
			//the editor coordinates have to be changed:
			//trap.x = trap_map.x - 8
			//trap.y = trap_map.y - 64
			super(x - 8, y - 64);
			
			loadGraphic(trap_img);
			
		}
		
	}

}