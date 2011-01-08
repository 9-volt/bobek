package  
{
	import org.flixel.*;
	
	public class CandyBar  extends FlxSprite
	{
		[Embed(source = "../media/elements/candy_bar.png")]
		private var candy_bar:Class;
		
		[Embed(source = "../media/elements/candy_bar_empty.png")]
		private var candy_bar_empty:Class;
		
		[Embed(source = "../media/elements/candy_bar_full.png")]
		private var candy_bar_full:Class;
		
		private var barFull:FlxSprite;
		private var barEmpty:FlxSprite;
		
		private var _height:int = 64;
		private var _width:int = 37;
		
		private var quantityNumber:Number = 0;
		private var heightFull:int = 0;
		
		public function get available():Boolean
		{
			if ( quantityNumber > 0 )
				return true;
			return false;
		}
		
		public function get availableQuantity():int
		{
			return quantityNumber as int;
		}
		
		public function CandyBar( _quantity:int = 50 ) 
		{
			super( 590, 13 );//603 0
			scrollFactor.x = scrollFactor.y = 0;
			
			quantityNumber = _quantity;
			
			//Load graphic
			loadGraphic(candy_bar_empty, false, false, _width, _height);
			
			//load bars graphic
			barFull = new FlxSprite(0, 0, candy_bar_full);
			barEmpty = new FlxSprite(0, 0, candy_bar_empty);
			
			heightFull = ( quantityNumber / 100 ) * _height;
			
			//initial Bar redrawing
			redrawBar();			
		}
		
		private function redrawBar():void
		{	
			fill( 0x00000000 );
			//draw full part
			draw(barFull, 0, 0 );
			//if bar is not full
			if ( heightFull < _height )
			{
				//erase unneded pixels
				fill( 0x00000000 , _width, _height - heightFull );
				//draw empty part
				draw(barEmpty, 0, 0, _width, _height - heightFull );
			}
		}
		
		public function changeQuantity( difference:Number = 0 ):void
		{
			var _heightFull:int;
			if ( difference != 0 )
			{
				quantityNumber += difference;
			}
			if ( quantityNumber < 0 )
				quantityNumber = 0;
			else if ( quantityNumber > 100 )
				quantityNumber = 100;
			
			_heightFull = ( quantityNumber / 100 ) * _height;
			if( _heightFull != heightFull ){
				heightFull = _heightFull;
				redrawBar();
				update();
			}
		}
	}

}