package  
{
	import org.flixel.*;
	
	public class Bullets extends FlxGroup
	{
		private var _gameState:FlxState;
		private var _maxBulletsNumber:Number;
		private var _totalBulletsNumber:Number = 0;
		
		function Bullets( _st:FlxState = null, bulletsNumber:Number = 40 ):void
		{
			super();
			
			_gameState = _st;
			_maxBulletsNumber = bulletsNumber;
		}
		
		public function shotOne( _x:int = 0, _y:int = 0, directionLeftRight:int = 1, _type:int = 1 ):void
		{
			if ( _totalBulletsNumber < _maxBulletsNumber )
			{
				var _bullet:Bullet = recycleBullet( _x, _y, directionLeftRight, _type );
				//_bullet.reset( _x, _y );
				_gameState.add( _bullet );
			}
		}
		
		private function recycleBullet( _x:int = 0, _y:int = 0, directionLeftRight:int = 1, _type:int = 1 ):Bullet
		{
			var _bullet:Bullet = this.getFirstAvail() as Bullet;
		 
			if (_bullet == null)
			{
				
				var _newBullet:Bullet = new Bullet( _type );
				_newBullet.setType( _x, _y, directionLeftRight, _type );
				this.add(_newBullet);
				return _newBullet;
			}
			_bullet.setType( _x, _y, directionLeftRight, _type );
			return _bullet;
		}
		
		//override public function update():void
		//{
			//saveOldPosition();
			//updateMotion();
			//updateMembers();
			//updateFlickering();
		//}
		
	}

}