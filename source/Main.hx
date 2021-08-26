package;

/**
 * the first class.
 * TODO one day you need to remove all created elements before they are created so that memory does not grow which will slow down the client which will happens now. the client becomes a bit more slow each time entering and exiting a scene.
 * search for the word TODO to see all the to do.
 * @author kboardgames.com
 */
class Main extends Sprite
{
	var initialState:Class<FlxState> = MenuState; // The FlxState the game starts with.

	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.

	// You can pretty much ignore everything from here on - your code should go in your states.

	public function new()
	{
		super();

		setupGame();
	}

	private function setupGame():Void
	{
		addChild(new FlxGame(Reg.gameWidth, Reg.gameHeight, initialState, zoom, Reg._framerate, Reg._framerate, true, true));
	}
	
}
