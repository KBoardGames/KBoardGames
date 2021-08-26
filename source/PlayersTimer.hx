package;

/**
 * addresses a double message bug. a player lost message when time runs out and then when restarting a game the same message is displayed again. 
 * @author kboardgames.com
 */

class PlayersTimer extends Timer {
	
	override public function new( time_ms : Int )
	{
		super(time_ms);
		
		PlayerTimeRemainingMove._ticksStart = 0;
	}
	
}
