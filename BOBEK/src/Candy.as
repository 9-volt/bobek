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
		[Embed(source = "../media/elements/star_sparkle.png")] private var sparkle_img:Class;
		[Embed(source="../media/sounds/candy_pick.mp3")] private var SoundEffect:Class
		
		public var got: Boolean = false;	
		public var over:Boolean = false;
		public var emitter:FlxEmitter;
		private var counter:Number;
		private var fadeoutTime :Number = 1;
		
		private var type:String;
		private var energyQuatity:int = 10;
		
		private var state:PlayState = FlxG.state as PlayState;
		private var player:Player = state.Bob;
		
		private var energyCandies:Array = new Array(5, 7, 9, 11, 13, 20);
		
		public function Candy(x:Number, y:Number, _type:String, _energyQuatity:int = 0) 
		{
			super( x + 4, y );
			counter = 0;
			type = _type;
			
			switch( type )
			{
				case "2":
					energyQuatity = energyCandies[2];
					loadGraphic(imgCandy_2, false, false, 28, 28);
					addAnimation("candy", [2, 1, 0, 1, 2, 3, 4, 3], 5.4 + Math.random( ), true);
					break;
				case "3":
					energyQuatity =  energyCandies[3];
					loadGraphic(imgCandy_3, false, false, 28, 28);
					addAnimation("candy", [1, 0, 1, 2, 3, 4, 3, 2], 5.3 + Math.random( ), true);
					break;
				case "4":
					energyQuatity =  energyCandies[4];
					loadGraphic(imgCandy_4, false, false, 28, 28);
					addAnimation("candy", [2, 3, 4, 3, 2, 1, 0, 1], 5.7 + Math.random( ), true);
					break;
				case "5":
					energyQuatity =  energyCandies[5];
					loadGraphic(imgCandy_5, false, false, 28, 28);
					addAnimation("candy", [3, 4, 3, 2, 1, 0, 1, 2], 5.2 + Math.random( ), true);
					break;
				case "6":
					energyQuatity =  energyCandies[6];
					loadGraphic(imgCandy_6, false, false, 28, 28);
					addAnimation("candy", [3, 2, 1, 0, 1, 2, 3, 4], 5.5 + Math.random( ), true);
					break;
				case "7":
					loadGraphic(imgCandies, true, false, 28, 28);
					addAnimation("candy", [0, 1, 2, 3, 4, 3, 2, 1], 5.6 + Math.random( ), true);
					break;
				case "1":
				default:
					energyQuatity =  energyCandies[1];
					loadGraphic(imgCandy_1, true, false, 28, 28);
					addAnimation("candy", [0, 1, 2, 3, 4, 3, 2, 1], 5.1, true);
					
					break;
			}
			play("candy");

			//making bounding box smaller
			height = 16;
			offset.y = 6;
			
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
						energyQuatity = energyCandies[frame % energyCandies.length];
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