package;

/**
 * ...
 * @author kboardgames.com
 */
class SnakesAndLaddersImage extends FlxSprite {

	public function new (yy:Float, xx:Float)
	{
		super(yy, xx);		
		
		loadGraphic("assets/images/snakesLadders/snakesAndLadders.png", false);
	}
}
