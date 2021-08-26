package;

/**
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
 * @author kboardgames.com
 */
class MenuConfigurations extends FlxState
{
	override public function create():Void
	{
		persistentDraw = true;
		persistentUpdate = false;
		
		var _help = new MenuConfigurationsOutput();
		add(_help);
	}
	
	override public function update(elapsed:Float):Void 
	{
		// should message box be displayed?
		if (Reg._messageId > 0 && Reg._messageId != 1000000
		&&	RegTriggers._buttons_set_not_active == false)
		{
			var _msg = new IdsMessageBox();
			add(_msg);
		}
			
		super.update(elapsed);
	}	
	
}