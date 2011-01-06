package  
{
	import org.flixel.*;
	
	public class Bullets extends FlxGroup
	{
		private var _gameState:FlxState;
		
		function Bullets( _st:FlxState = null ):void
		{
			super();
			_gameState = _st;
		}
		
		public function shotOne( _x:int = 0, _y:int = 0, directionLeftRight:int = 1, _type:int = 1, _speed:int = 100 ):void
		{
			var bullet:Bullet = new Bullet( _x, _y, directionLeftRight, _type, _speed );

			_gameState.add( bullet );
		}
	}
}