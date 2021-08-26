package;

/**
 * general message. its a blue background that can be closed when time expires or from a mouse button click.
 * @author kboardgames.com
 */
class GameMessage extends FlxGroup
{		
	/******************************
	 * the message.
	 */
	public var _text:FlxText;
	
	
	public function new():Void
	{
		super();	
				
		// color black the whole scene.
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, FlxG.height, 0xCC000000);
		background.scrollFactor.set(0, 0);	
		add(background);
		
		var background2 = new FlxSprite(0, 0);
		background2.makeGraphic(650, 275, 0xBB000066);
		background2.scrollFactor.set(0, 0);	
		background2.screenCenter(XY);
		add(background2);	
					
		var _text:FlxText = new FlxText(0, FlxG.height / 2 -75, 0, Reg._gameMessage);
		_text.setFormat(null, 25, FlxColor.WHITE, LEFT);
		_text.font = Reg._fontDefault;
		_text.fieldWidth = 500;
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		_text.scrollFactor.set(0, 0);
		_text.screenCenter(XY);
		add(_text);
				
		new FlxTimer().start(0.8, closeMessage, 1);
		
		visible = true;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (ActionInput.justPressed() == true)
			visible = false;
		
		super.update(elapsed);
	}	
	
	override public function destroy()
	{
		super.destroy();
	}
	
	private function closeMessage(i:FlxTimer):Void
	{
		new FlxTimer().start(1, closeSubstate, 1);
	}
	
	private function closeSubstate(i:FlxTimer):Void
	{
		visible = false;			
	}

}