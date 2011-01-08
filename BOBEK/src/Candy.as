package  
{
	import adobe.utils.CustomActions;
	import org.flixel.*;

	public class Candy extends FlxSprite
	{
		[Embed(source = "../media/elements/candies.png")] private var imgCandies:Class;		
		[Embed(source = "../media/elements/candy_1.png")] private var imgCandy_1:Class;		
		[Embed(source = "../media/elements/candy_2.png")] private var imgCandy_2:Class;		
		[Embed(source = "../media/elements/candy_3.png")] private var imgCandy_3:Class;		
		[Embed(source = "../media/elements/candy_4.png")] private var imgCandy_4:Class;		
		[Embed(source = "../media/elements/candy_5.png")] private var imgCandy_5:Class;		
		[Embed(source = "../media/elements/candy_6.png")] private var imgCandy_6:Class;		
		[Embed(source = "../media/star_sparkle.png")] private var sparkle_img:Class;
		[Embed(source="../media/sounds/candy_pick.mp3")] private var SoundEffect:Class
		
		public var got: Boolean = false;	
		public var over:Boolean = false;
		public var emitter:FlxEmitter;
		private var counter:Number;
		private var fadeoutTime :Number = 2;
		
		private var type:String;
		private var energyQuatity:int = 10;
		
		private var state:PlayState = FlxG.state as PlayState;
		private var player:Player = state.Bob;
		
		private var energyCandies:Array = new Array(5, 7, 9, 11, 13, 20);
		
		public function Candy(x:Number, y:Number, _type:String, _energyQuatity:int = 0) 
		{
			super( x + 7, y );
			counter = 0;
			type = _type;
			
			switch( type )
			{
				case "2":
					loadGraphic(imgCandy_2, false, false, 28, 28);
					energyQuatity = energyCandies[2];
					break;
				case "3":
					loadGraphic(imgCandy_3, false, false, 28, 28);
					energyQuatity =  energyCandies[3];
					break;
				case "4":
					loadGraphic(imgCandy_4, false, false, 28, 28);
					energyQuatity =  energyCandies[4];
					break;
				case "5":
					loadGraphic(imgCandy_5, false, false, 28, 28);
					energyQuatity =  energyCandies[5];
					break;
				case "6":
					loadGraphic(imgCandy_6, false, false, 28, 28);
					energyQuatity =  energyCandies[6];
					break;
				case "7":
					loadGraphic(imgCandies, true, false, 28, 28);
					addAnimation("multicandie", [0, 1, 2, 3, 4, 5], 5, true);
					play("multicandie");
					break;
				case "1":
				default:
					energyQuatity =  energyCandies[1];
					loadGraphic(imgCandy_1, false, false, 28, 28);
					break;
			}

			
			emitter = new FlxEmitter(); //x and y of the emitter
			emitter.x = x + width / 2;
			emitter.y = y + height / 2;
			emitter.gravity = 40;
			emitter.setXSpeed(-50, 50);
			emitter.setYSpeed(-50, 50);
			
			//we do not need collision with player or other elements
			solid = false;
			
			emitter.createSprites(sparkle_img, 32, 8);
			
			//assign energy quantity
			if( _energyQuatity > 0 )
				energyQuatity = _energyQuatity;
		}
		override public function update():void 
		{
			if (!got)
			{
				super.update();
				
				//if ( type == "7" )
					//randomFrame();
				if (overlaps(player))
				{
					if ( type == "7" )
					{
						energyQuatity = energyCandies[frame];
					}
					GetCandy();
				}
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
		
		public function GetCandy():void
		{
			got = true;
			emitter.start(true, 2);
			FlxG.play(SoundEffect);
			state.Bob._candy_bar.changeQuantity( energyQuatity );
		}
		public function AddToState(st:FlxState):void {
			st.add(emitter);
			st.add(this);
		}
	}

}