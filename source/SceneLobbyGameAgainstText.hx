package;

/**
 * lobby boxScroller data, such as, room state, room game. 
 * @author kboardgames.com
 */
class SceneLobbyGameAgainstText extends FlxText
{
	public var _id:Int = 0;
	
	public function new(x:Float = 0, y:Float = 0, _fieldWidth:Float = 0, _text:String, _textSize:Int = 20, id:Int = 0)	
	{	
		super(x, y, _fieldWidth, _text, _textSize);
		
		_id = id;

	}

	override public function destroy()
	{
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		// this code is needed so that it refreshes the lobby boxScroller data without new the text.
		for (i in 0...27)
		{
			var _host:String = RegTypedef._dataMisc._roomHostUsername[i];
			var _vsComputer:Int = RegTypedef._dataMisc._vsComputer[i];
			var _title:String = "Human";
			
			if (_vsComputer == 1) _title = "Computer";
			
			if (i == _id) 
			{
				if (_host != ""
				&&	RegTypedef._dataMisc._roomPlayerCurrentTotal[i] > 0) 
				{
					text = _title;
				}
				else text = " ";
			}
		}
		
		
		super.update(elapsed);
	}

}
