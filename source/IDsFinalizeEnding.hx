/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * this class does things that are needed to be done after the game ends. 
 * @author kboardgames.com
 */
class IDsFinalizeEnding extends FlxGroup
{
	private var __scene_game_room:SceneGameRoom;
	
	public function new(scene_game_room:SceneGameRoom) 
	{
		super();
	
		__scene_game_room = scene_game_room;
	}	
	
	public function id0():Void
	{
		
	}

	public function id1():Void
	{
		
	}

	public function id2():Void
	{
		
	}

	public function id3():Void
	{
		
	}

	public function id4():Void
	{
		var _signatureGame = __scene_game_room._iDsCreateAndMain.__signature_game;
		
		
		if (SignatureGameMain.background != null)
		{
						
			if (_signatureGame._buttonGoBack != null)
			{
				_signatureGame._buttonGoBack.visible = false;
				_signatureGame._buttonGoBack.active = false;
				
			}
				
			SignatureGameMain._buttonEndTurnOrPayNow.visible = false;
			SignatureGameMain._buttonEndTurnOrPayNow.active = false;
			
			
			if (SignatureGameMain._textGeneralMessage.visible == true && SignatureGameMain._textGeneralMessage.text == "Main menu.")
			{
				SignatureGameMain._buttonEndTurnOrPayNow.screenCenter(X); 			
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStores.active = true;
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStores.visible = true;
				//
							
				if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 0)
				{
					_signatureGame._buttonSellHouse.active = true;
					_signatureGame._buttonSellHouse.visible = true;
					
				}
				
				if (SignatureGameMain._isMortgage[Reg._move_number_next][Reg._gameDiceMaximumIndex[Reg._move_number_next]] <= -1)
				{			
					// if no house.
					if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 0)
					{
						_signatureGame._buttonBuyMortgage.active = true;
						_signatureGame._buttonBuyMortgage.visible = true;
						
					}
					
				}
								
				SignatureGameMain._tradeWith.active = true;
				SignatureGameMain._tradeWith.visible = true;
				
			}
			
			
			else if (_signatureGame._buttonBuyHouseTaxiCabOrCafeStore1 != null && SignatureGameMain._textGeneralMessage.text == "Buy property.")
			{
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStore1.active = true;
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStore2.active = true;
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStore3.active = true;
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStore4.active = true;
				
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStore1.visible = true;
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStore2.visible = true;
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStore3.visible = true;
				_signatureGame._buttonBuyHouseTaxiCabOrCafeStore4.visible = true;
			}		

			else 
			{
				_signatureGame._buttonTradeProposal.active = true;		
				_signatureGame._buttonResetTradeProposal.active = true;		
				_signatureGame._buttonTradeProposal.visible = true;		
				_signatureGame._buttonResetTradeProposal.visible = true;		
				
				SignatureGameMain._unitYoursButton.active = true;		
				SignatureGameMain._unitOthersButton.active = true;		
				SignatureGameMain._unitYoursButton.visible = true;		
				SignatureGameMain._unitOthersButton.visible = true;			
				
				_signatureGame._cashMinus500YoursButton.active = true;
				_signatureGame._cashPlus500YoursButton.active = true;
				_signatureGame._cashMinus500YoursButton.visible = true;
				_signatureGame._cashPlus500YoursButton.visible = true;
				_signatureGame._cashMinus500OthersButton.active = true;
				_signatureGame._cashPlus500OthersButton.active = true;
				_signatureGame._cashMinus500OthersButton.visible = true;
				_signatureGame._cashPlus500OthersButton.visible = true;
			}	
		} 
	
		if (SignatureGameMain._tradeProposal != null)
		{
			SignatureGameMain._tradeProposal.popupMessageHide();
			SignatureGameMain._tradeProposal.destroy();
		}
		
		if (SignatureGameMain._replyTradeProposal != null)
		{
			SignatureGameMain._replyTradeProposal.popupMessageHide();
			SignatureGameMain._replyTradeProposal.destroy();
		}
	}
}

