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
 * ...
 * @author kboardgames.com
 */
class ChessECO
{	
	public static function ECOlists():Void
	{
		Reg._ecoOpeningsNamesTemp =	"A00 Polish (Sokolsky) opening
A00 Polish: Tuebingen variation
A00 Polish: Outflank variation
A00 Benko's opening
A00 Lasker simul special
A00 Benko's opening: reversed Alekhine
A00 Grob's attack
A00 Grob: spike attack
A00 Grob: Fritz gambit
A00 Grob: Romford counter-gambit
A00 Clemenz (Mead's, Basman's or de Klerk's) opening
A00 Global opening
A00 Amar (Paris) opening
A00 Amar gambit
A00 Dunst (Sleipner, Heinrichsen) opening
A00 Dunst (Sleipner,Heinrichsen) opening
A00 Battambang opening
A00 Novosibirsk opening
A00 Anderssen's opening
A00 Ware (Meadow Hay) opening
A00 Crab opening
A00 Saragossa opening
A00 Mieses opening
A00 Mieses opening
A00 Valencia opening
A00 Venezolana opening
A00 Van't Kruijs opening
A00 Amsterdam attack
A00 Gedult's opening
A00 Hammerschlag (Fried fox/Pork chop opening)
A00 Anti-Borg (Desprez) opening
A00 Durkin's attack
A01 Nimzovich-Larsen attack
A01 Nimzovich-Larsen attack: modern variation
A01 Nimzovich-Larsen attack: Indian variation
A01 Nimzovich-Larsen attack: classical variation
A01 Nimzovich-Larsen attack: English variation
A01 Nimzovich-Larsen attack: Dutch variation
A01 Nimzovich-Larsen attack: Polish variation
A01 Nimzovich-Larsen attack: symmetrical variation
A02 Bird's opening
A02 Bird: From gambit
A02 Bird: From gambit, Lasker variation
A02 Bird: From gambit, Lipke variation
A02 Bird's opening, Swiss gambit
A02 Bird: Hobbs gambit
A03 Bird's opening
A03 Mujannah opening
A03 Bird's opening: Williams gambit
A03 Bird's opening: Lasker variation
A04 Reti opening
A04 Reti v Dutch
A04 Reti: Pirc-Lisitsin gambit
A04 Reti: Lisitsin gambit deferred
A04 Reti opening
A04 Reti: Wade defence
A04 Reti: Herrstroem gambit
A05 Reti opening
A05 Reti: King's Indian attack, Spassky's variation
A05 Reti: King's Indian attack
A05 Reti: King's Indian attack, Reti-Smyslov variation
A06 Reti opening
A06 Reti: old Indian attack
A06 Santasiere's folly
A06 Tennison (Lemberg, Zukertort) gambit
A06 Reti: Nimzovich-Larsen attack
A07 Reti: King's Indian attack (Barcza system)
A07 Reti: King's Indian attack, Yugoslav variation
A07 Reti: King's Indian attack, Keres variation
A07 Reti: King's Indian attack
A07 Reti: King's Indian attack, Pachman system
A07 Reti: King's Indian attack (with ...c5)
A08 Reti: King's Indian attack
A08 Reti: King's Indian attack, French variation
A09 Reti opening
A09 Reti: advance variation
A09 Reti accepted
A09 Reti accepted: Keres variation
A10 English opening
A10 English opening
A10 English: Adorjan defence
A10 English: Jaenisch gambit
A10 English: Anglo-Dutch defense
A11 English: Caro-Kann defensive system
A12 English: Caro-Kann defensive system
A12 English: Torre defensive system
A12 English: London defensive system
A12 English: Caro-Kann defensive system
A12 English: Bled variation
A12 English: New York (London) defensive system
A12 English: Capablanca's variation
A12 English: Caro-Kann defensive system, Bogolyubov variation
A13 English opening
A13 English: Romanishin gambit
A13 English opening: Agincourt variation
A13 English: Wimpey system
A13 English opening: Agincourt variation
A13 English: Kurajica defence
A13 English: Neo-Catalan
A13 English: Neo-Catalan accepted
A14 English: Neo-Catalan declined
A14 English: Symmetrical, Keres defence
A15 English, 1...Nf6 (Anglo-Indian defense)
A15 English orang-utan
A15 English opening
A16 English opening
A16 English: Anglo-Gruenfeld defense
A16 English: Anglo-Gruenfeld, Smyslov defense
A16 English: Anglo-Gruenfeld, Czech defense
A16 English: Anglo-Gruenfeld defense
A16 English: Anglo-Gruenfeld defense, Korchnoi variation
A17 English opening
A17 English: Queens Indian formation
A17 English: Queens Indian, Romanishin variation
A17 English: Nimzo-English opening
A18 English: Mikenas-Carls variation
A18 English: Mikenas-Carls, Flohr variation
A18 English: Mikenas-Carls, Kevitz variation
A19 English: Mikenas-Carls, Sicilian variation
A20 English opening
A20 English, Nimzovich variation
A20 English, Nimzovich, Flohr variation
A21 English opening
A21 English, Troeger defence
A21 English, Keres variation
A21 English opening
A21 English, Smyslov defence
A21 English, Kramnik-Shirov counterattack
A22 English opening
A22 English: Bellon gambit
A22 English: Carls' Bremen system
A22 English: Bremen, reverse dragon
A22 English: Bremen, Smyslov system
A23 English: Bremen system, Keres variation
A24 English: Bremen system with ...g6
A25 English: Sicilian reversed
A25 English: closed system
A25 English: closed, Taimanov variation
A25 English: closed, Hort variation
A25 English: closed, 5.Rb1
A25 English: closed, 5.Rb1 Taimanov variation
A25 English: closed system (without ...d6)
A26 English: closed system
A26 English: Botvinnik system
A27 English: three knights system
A28 English: four knights system
A28 English: Nenarokov variation
A28 English: Bradley Beach variation
A28 English: four knights, Nimzovich variation
A28 English: four knights, Marini variation
A28 English: four knights, Capablanca variation
A28 English: four knights, 4.e3
A28 English: four knights, Stean variation
A28 English: four knights, Romanishin variation
A29 English: four knights, kingside fianchetto
A30 English: symmetrical variation
A30 English: symmetrical, hedgehog system
A30 English: symmetrical, hedgehog, flexible formation
A31 English: symmetrical, Benoni formation
A32 English: symmetrical variation
A33 English: symmetrical variation
A33 English: symmetrical, Geller variation
A34 English: symmetrical variation
A34 English: symmetrical, three knights system
A34 English: symmetrical variation
A34 English: symmetrical, Rubinstein system
A35 English: symmetrical variation
A35 English: symmetrical, four knights system
A36 English: symmetrical variation
A36 English: ultra-symmetrical variation
A36 English: symmetrical, Botvinnik system reversed
A36 English: symmetrical, Botvinnik system
A37 English: symmetrical variation
A37 English: symmetrical, Botvinnik system reversed
A38 English: symmetrical variation
A38 English: symmetrical, main line with d3
A38 English: symmetrical, main line with b3
A39 English: symmetrical, main line with d4
A40 Queen's pawn
A40 Queen's pawn: Lundin (Kevitz-Mikenas) defence
A40 Queen's pawn: Charlick (Englund) gambit
A40 Queen's pawn: Englund gambit
A40 Queen's pawn: English defence
A40 Polish defence
A40 Queen's pawn
A40 Queen's pawn: Keres defence
A40 Queen's pawn: Franco-Indian (Keres) defence
A40 Modern defence
A40 Beefeater defence
A41 Queen's Pawn
A41 Old Indian: Tartakower (Wade) variation
A41 Old Indian defence
A41 Modern defence
A41 Robatsch defence: Rossolimo variation
A42 Modern defence: Averbakh system
A42 Pterodactyl defence
A42 Modern defence: Averbakh system, Randspringer variation
A42 Modern defence: Averbakh system, Kotov variation
A43 Old Benoni defence
A43 Old Benoni: Franco-Benoni defence
A43 Old Benoni: Mujannah formation
A43 Old Benoni defence
A43 Woozle defence
A43 Old Benoni defence
A43 Hawk (Habichd) defence
A43 Old Benoni defence
A43 Old Benoni: Schmid's system
A44 Old Benoni defence
A44 Semi-Benoni (`blockade variation')
A45 Queen's pawn game
A45 Queen's pawn: Bronstein gambit
A45 Canard opening
A45 Paleface attack
A45 Blackmar-Diemer gambit
A45 Gedult attack
A45 Trompovsky attack (Ruth, Opovcensky opening)
A46 Queen's pawn game
A46 Queen's pawn: Torre attack
A46 Queen's pawn: Torre attack, Wagner gambit
A46 Queen's pawn: Yusupov-Rubinstein system
A46 Doery defence
A47 Queen's Indian defence
A47 Queen's Indian: Marienbad system
A47 Queen's Indian: Marienbad system, Berg variation
A48 King's Indian: East Indian defence
A48 King's Indian: Torre attack
A48 King's Indian: London system
A49 King's Indian: fianchetto without c4
A50 Queen's pawn game
A50 Kevitz-Trajkovich defence
A50 Queen's Indian accelerated
A51 Budapest defence declined
A51 Budapest: Fajarowicz variation
A51 Budapest: Fajarowicz, Steiner variation
A52 Budapest defence
A52 Budapest: Adler variation
A52 Budapest: Rubinstein variation
A52 Budapest: Alekhine variation
A52 Budapest: Alekhine, Abonyi variation
A52 Budapest: Alekhine variation, Balogh gambit
A53 Old Indian defence
A53 Old Indian: Janowski variation
A54 Old Indian: Ukrainian variation
A54 Old Indian: Dus-Khotimirsky variation
A54 Old Indian: Ukrainian variation, 4.Nf3
A55 Old Indian: main line
A56 Benoni defence
A56 Benoni defence, Hromodka system
A56 Vulture defence
A56 Czech Benoni defence
A56 Czech Benoni: King's Indian system
A57 Benko gambit
A57 Benko gambit half accepted
A57 Benko gambit: Zaitsev system
A57 Benko gambit: Nescafe Frappe attack
A58 Benko gambit accepted
A58 Benko gambit: Nd2 variation
A58 Benko gambit: fianchetto variation
A59 Benko gambit: 7.e4
A59 Benko gambit: Ne2 variation
A59 Benko gambit
A59 Benko gambit: main line
A60 Benoni defence
A61 Benoni defence
A61 Benoni: Uhlmann variation
A61 Benoni: Nimzovich (knight's tour) variation
A61 Benoni: fianchetto variation
A62 Benoni: fianchetto variation
A63 Benoni: fianchetto, 9...Nbd7
A64 Benoni: fianchetto, 11...Re8
A65 Benoni: 6.e4
A66 Benoni: pawn storm variation
A66 Benoni: Mikenas variation
A67 Benoni: Taimanov variation
A68 Benoni: four pawns attack
A69 Benoni: four pawns attack, main line
A70 Benoni: classical with e4 and Nf3
A70 Benoni: classical without 9.O-O
A71 Benoni: classical, 8.Bg5
A72 Benoni: classical without 9.O-O
A73 Benoni: classical, 9.O-O
A74 Benoni: classical, 9...a6, 10.a4
A75 Benoni: classical with ...a6 and 10...Bg4
A76 Benoni: classical, 9...Re8
A77 Benoni: classical, 9...Re8, 10.Nd2
A78 Benoni: classical with ...Re8 and ...Na6
A79 Benoni: classical, 11.f3
A80 Dutch
A80 Dutch, Spielmann gambit
A80 Dutch, Manhattan (Alapin, Ulvestad) variation
A80 Dutch, Von Pretzel gambit
A80 Dutch, Korchnoi attack
A80 Dutch, Krejcik gambit
A80 Dutch, 2.Bg5 variation
A81 Dutch defence
A81 Dutch defence, Blackburne variation
A81 Dutch defence
A81 Dutch: Leningrad, Basman system
A81 Dutch: Leningrad, Karlsbad variation
A82 Dutch: Staunton gambit
A82 Dutch: Balogh defence
A82 Dutch: Staunton gambit
A82 Dutch: Staunton gambit, Tartakower variation
A83 Dutch: Staunton gambit, Staunton's line
A83 Dutch: Staunton gambit, Alekhine variation
A83 Dutch: Staunton gambit, Lasker variation
A83 Dutch: Staunton gambit, Chigorin variation
A83 Dutch: Staunton gambit, Nimzovich variation
A84 Dutch defence
A84 Dutch defence: Bladel variation
A84 Dutch defence
A84 Dutch defence, Rubinstein variation
A84 Dutch: Staunton gambit deferred
A84 Dutch defence
A85 Dutch with c4 & Nc3
A86 Dutch with c4 & g3
A86 Dutch: Hort-Antoshin system
A86 Dutch: Leningrad variation
A87 Dutch: Leningrad, main variation
A88 Dutch: Leningrad, main variation with c6
A89 Dutch: Leningrad, main variation with Nc6
A90 Dutch defence
A90 Dutch defence: Dutch-Indian (Nimzo-Dutch) variation
A90 Dutch-Indian, Alekhine variation
A91 Dutch defence
A92 Dutch defence
A92 Dutch defence, Alekhine variation
A92 Dutch: stonewall variation
A92 Dutch: stonewall with Nc3
A93 Dutch: stonewall, Botwinnik variation
A94 Dutch: stonewall with Ba3
A95 Dutch: stonewall with Nc3
A95 Dutch: stonewall: Chekhover variation
A96 Dutch: classical variation
A97 Dutch: Ilyin-Genevsky variation
A97 Dutch: Ilyin-Genevsky, Winter variation
A98 Dutch: Ilyin-Genevsky variation with Qc2
A99 Dutch: Ilyin-Genevsky variation with b3
B00 King's pawn opening
B00 Hippopotamus defence
B00 Corn stalk defence
B00 Lemming defence
B00 Fred
B00 Barnes defence
B00 Fried fox defence
B00 Carr's defence
B00 Reversed Grob (Borg/Basman defence/macho Grob)
B00 St. George (Baker) defence
B00 Owen defence
B00 Guatemala defence
B00 KP: Nimzovich defence
B00 KP: Nimzovich defence, Wheeler gambit
B00 KP: Nimzovich defence
B00 KP: Colorado counter
B00 KP: Nimzovich defence
B00 KP: Nimzovich defence, Marshall gambit
B00 KP: Nimzovich defence, Bogolyubov variation
B00 KP: Neo-Mongoloid defence
B01 Scandinavian (centre counter) defence
B01 Scandinavian defence, Lasker variation
B01 Scandinavian defence
B01 Scandinavian defence, Gruenfeld variation
B01 Scandinavian: Anderssen counter-attack
B01 Scandinavian: Anderssen counter-attack orthodox attack
B01 Scandinavian: Anderssen counter-attack, Goteborg system
B01 Scandinavian: Anderssen counter-attack, Collijn variation
B01 Scandinavian, Mieses-Kotrvc gambit
B01 Scandinavian: Pytel-Wade variation
B01 Scandinavian defence
B01 Scandinavian: Icelandic gambit
B01 Scandinavian gambit
B01 Scandinavian defence
B01 Scandinavian: Marshall variation
B01 Scandinavian: Kiel variation
B01 Scandinavian: Richter variation
B02 Alekhine's defence
B02 Alekhine's defence: Scandinavian variation
B02 Alekhine's defence: Spielmann variation
B02 Alekhine's defence: Maroczy variation
B02 Alekhine's defence: Krejcik variation
B02 Alekhine's defence: Mokele Mbembe (Buecker) variation
B02 Alekhine's defence: Brooklyn defence
B02 Alekhine's defence
B02 Alekhine's defence: Kmoch variation
B02 Alekhine's defence: Saemisch attack
B02 Alekhine's defence: Welling variation
B02 Alekhine's defence
B02 Alekhine's defence: Steiner variation
B02 Alekhine's defence: two pawns' (Lasker's) attack
B02 Alekhine's defence: two pawns' attack, Mikenas variation
B03 Alekhine's defence
B03 Alekhine's defence: O'Sullivan gambit
B03 Alekhine's defence
B03 Alekhine's defence: Balogh variation
B03 Alekhine's defence
B03 Alekhine's defence: exchange variation
B03 Alekhine's defence: exchange, Karpov variation
B03 Alekhine's defence: four pawns attack
B03 Alekhine's defence: four pawns attack, Korchnoi variation
B03 Alekhine's defence: four pawns attack, 6...Nc6
B03 Alekhine's defence: four pawns attack, Ilyin-Genevsky var.
B03 Alekhine's defence: four pawns attack, 7.Be3
B03 Alekhine's defence: four pawns attack, Tartakower variation
B03 Alekhine's defence: four pawns attack, Planinc variation
B03 Alekhine's defence: four pawns attack, fianchetto variation
B03 Alekhine's defence: four pawns attack, Trifunovic variation
B04 Alekhine's defence: modern variation
B04 Alekhine's defence: modern, Larsen variation
B04 Alekhine's defence: modern, Schmid variation
B04 Alekhine's defence: modern, fianchetto variation
B04 Alekhine's defence: modern, Keres variation
B05 Alekhine's defence: modern variation, 4...Bg4
B05 Alekhine's defence: modern, Flohr variation
B05 Alekhine's defence: modern, Panov variation
B05 Alekhine's defence: modern, Alekhine variation
B05 Alekhine's defence: modern, Vitolins attack
B06 Robatsch (modern) defence
B06 Norwegian defence
B06 Robatsch (modern) defence
B06 Robatsch defence: three pawns attack
B06 Robatsch defence
B06 Robatsch defence: Gurgenidze variation
B06 Robatsch (modern) defence
B06 Robatsch defence: two knights variation
B06 Robatsch defence: two knights, Suttles variation
B06 Robatsch defence: Pseudo-Austrian attack
B07 Pirc defence
B07 Pirc: Ufimtsev-Pytel variation
B07 Pirc defence
B07 Pirc: 150 attack
B07 Pirc: Sveshnikov system
B07 Pirc: Holmov system
B07 Pirc: Byrne variation
B07 Pirc defence
B07 Pirc: Chinese variation
B07 Pirc: bayonet (Mariotti) attack
B07 Robatsch defence: Geller's system
B08 Pirc: classical (two knights) system
B08 Pirc: classical (two knights) system
B08 Pirc: classical, h3 system
B08 Pirc: classical system, 5.Be2
B09 Pirc: Austrian attack
B09 Pirc: Austrian attack
B09 Pirc: Austrian attack, 6.e5
B09 Pirc: Austrian attack, 6.Be3
B09 Pirc: Austrian attack, 6.Bd3
B09 Pirc: Austrian attack, dragon formation
B09 Pirc: Austrian attack, Ljubojevic variation
B10 Caro-Kann defence
B10 Caro-Kann: Hillbilly attack
B10 Caro-Kann: anti-Caro-Kann defence
B10 Caro-Kann: anti-anti-Caro-Kann defence
B10 Caro-Kann: closed (Breyer) variation
B10 Caro-Kann defence
B10 Caro-Kann: Goldman (Spielmann) variation
B10 Caro-Kann: two knights variation
B11 Caro-Kann: two knights, 3...Bg4
B12 Caro-Kann defence
B12 de Bruycker defence
B12 Caro-Masi defence
B12 Caro-Kann defence
B12 Caro-Kann: Tartakower (fantasy) variation
B12 Caro-Kann: 3.Nd2
B12 Caro-Kann: Edinburgh variation
B12 Caro-Kann: advance variation
B12 Caro-Kann: advance, Short variation
B13 Caro-Kann: exchange variation
B13 Caro-Kann: exchange, Rubinstein variation
B13 Caro-Kann: Panov-Botvinnik attack
B13 Caro-Kann: Panov-Botvinnik, Gunderam attack
B13 Caro-Kann: Panov-Botvinnik attack
B13 Caro-Kann: Panov-Botvinnik, Herzog defence
B13 Caro-Kann: Panov-Botvinnik, normal variation
B13 Caro-Kann: Panov-Botvinnik, Czerniak variation
B13 Caro-Kann: Panov-Botvinnik, Reifir (Spielmann) variation
B14 Caro-Kann: Panov-Botvinnik attack, 5...e6
B14 Caro-Kann: Panov-Botvinnik attack, 5...g6
B15 Caro-Kann defence
B15 Caro-Kann: Gurgenidze counter-attack
B15 Caro-Kann: Gurgenidze system
B15 Caro-Kann: Rasa-Studier gambit
B15 Caro-Kann defence
B15 Caro-Kann: Alekhine gambit
B15 Caro-Kann: Tartakower (Nimzovich) variation
B15 Caro-Kann: Forgacs variation
B16 Caro-Kann: Bronstein-Larsen variation
B17 Caro-Kann: Steinitz variation
B18 Caro-Kann: classical variation
B18 Caro-Kann: classical, Flohr variation
B18 Caro-Kann: classical, Maroczy attack
B18 Caro-Kann: classical, 6.h4
B19 Caro-Kann: classical, 7...Nd7
B19 Caro-Kann: classical, Spassky variation
B20 Sicilian defence
B20 Sicilian: Gloria variation
B20 Sicilian: Steinitz variation
B20 Sicilian: wing gambit
B20 Sicilian: wing gambit, Santasiere variation
B20 Sicilian: wing gambit, Marshall variation
B20 Sicilian: wing gambit, Marienbad variation
B20 Sicilian: wing gambit, Carlsbad variation
B20 Sicilian: Keres variation (2.Ne2)
B21 Sicilian: Grand Prix attack
B21 Sicilian: Smith-Morra gambit
B21 Sicilian: Andreaschek gambit
B21 Sicilian: Smith-Morra gambit
B21 Sicilian: Smith-Morra gambit, Chicago defence
B22 Sicilian: Alapin's variation (2.c3)
B22 Sicilian: 2.c3, Heidenfeld variation
B23 Sicilian: closed
B23 Sicilian: closed, Korchnoi variation
B23 Sicilian: closed, 2...Nc6
B23 Sicilian: chameleon variation
B23 Sicilian: Grand Prix attack
B23 Sicilian: Grand Prix attack, Schofman variation
B24 Sicilian: closed
B24 Sicilian: closed, Smyslov variation
B25 Sicilian: closed
B25 Sicilian: closed, 6.Ne2 e5 (Botvinnik)
B25 Sicilian: closed, 6.f4
B25 Sicilian: closed, 6.f4 e5 (Botvinnik)
B26 Sicilian: closed, 6.Be3
B27 Sicilian defence
B27 Sicilian: Stiletto (Althouse) variation
B27 Sicilian: Quinteros variation
B27 Sicilian: Katalimov variation
B27 Sicilian: Hungarian variation
B27 Sicilian: Acton extension
B28 Sicilian: O'Kelly variation
B29 Sicilian: Nimzovich-Rubinstein variation
B29 Sicilian: Nimzovich-Rubinstein; Rubinstein counter-gambit
B30 Sicilian defence
B30 Sicilian: Nimzovich-Rossolimo attack (without ...d6)
B31 Sicilian: Nimzovich-Rossolimo attack (with ...g6, without ...d6)
B31 Sicilian: Nimzovich-Rossolimo attack, Gurgenidze variation
B32 Sicilian defence
B32 Sicilian: Flohr variation
B32 Sicilian: Nimzovich variation
B32 Sicilian: Labourdonnais-Loewenthal variation
B32 Sicilian: Labourdonnais-Loewenthal (Kalashnikov) variation
B33 Sicilian defence
B33 Sicilian: Pelikan (Lasker/Sveshnikov) variation
B33 Sicilian: Pelikan, Bird variation
B33 Sicilian: Pelikan, Chelyabinsk variation
B33 Sicilian: Sveshnikov variation
B34 Sicilian: accelerated fianchetto, exchange variation
B34 Sicilian: accelerated fianchetto, modern variation
B35 Sicilian: accelerated fianchetto, modern variation with Bc4
B36 Sicilian: accelerated fianchetto, Maroczy bind
B36 Sicilian: accelerated fianchetto, Gurgenidze variation
B37 Sicilian: accelerated fianchetto, Maroczy bind, 5...Bg7
B37 Sicilian: accelerated fianchetto, Simagin variation
B38 Sicilian: accelerated fianchetto, Maroczy bind, 6.Be3
B39 Sicilian: accelerated fianchetto, Breyer variation
B40 Sicilian defence
B40 Sicilian: Marshall variation
B40 Sicilian defence
B40 Sicilian: Anderssen variation
B40 Sicilian: Pin variation (Sicilian counter-attack)
B40 Sicilian: Pin, Jaffe variation
B40 Sicilian: Pin, Koch variation
B41 Sicilian: Kan variation
B41 Sicilian: Kan, Maroczy bind (Reti variation)
B41 Sicilian: Kan, Maroczy bind - Bronstein variation
B42 Sicilian: Kan, 5.Bd3
B42 Sicilian: Kan, Gipslis variation
B42 Sicilian: Kan, Polugaievsky variation
B42 Sicilian: Kan, Swiss cheese variation
B43 Sicilian: Kan, 5.Nc3
B44 Sicilian defence
B44 Sicilian, Szen (`anti-Taimanov') variation
B44 Sicilian, Szen, hedgehog variation
B44 Sicilian, Szen variation, Dely-Kasparov gambit
B45 Sicilian: Taimanov variation
B45 Sicilian: Taimanov, American attack
B46 Sicilian: Taimanov variation
B47 Sicilian: Taimanov (Bastrikov) variation
B48 Sicilian: Taimanov variation
B49 Sicilian: Taimanov variation
B50 Sicilian
B50 Sicilian: wing gambit deferred
B51 Sicilian: Canal-Sokolsky (Nimzovich-Rossolimo, Moscow) attack
B52 Sicilian: Canal-Sokolsky attack, 3...Bd7
B52 Sicilian: Canal-Sokolsky attack, Bronstein gambit
B52 Sicilian: Canal-Sokolsky attack, Sokolsky variation
B53 Sicilian, Chekhover variation
B53 Sicilian: Chekhover, Zaitsev variation
B54 Sicilian
B54 Sicilian: Prins (Moscow) variation
B55 Sicilian: Prins variation, Venice attack
B56 Sicilian
B56 Sicilian: Venice attack
B56 Sicilian
B57 Sicilian: Sozin, not Scheveningen
B57 Sicilian: Magnus Smith trap
B57 Sicilian: Sozin, Benko variation
B58 Sicilian: classical
B58 Sicilian: Boleslavsky variation
B58 Sicilian: Boleslavsky, Louma variation
B59 Sicilian: Boleslavsky variation, 7.Nb3
B60 Sicilian: Richter-Rauzer
B60 Sicilian: Richter-Rauzer, Bondarevsky variation
B60 Sicilian: Richter-Rauzer, Larsen variation
B61 Sicilian: Richter-Rauzer, Larsen variation, 7.Qd2
B62 Sicilian: Richter-Rauzer, 6...e6
B62 Sicilian: Richter-Rauzer, Podvebrady variation
B62 Sicilian: Richter-Rauzer, Margate (Alekhine) variation
B62 Sicilian: Richter-Rauzer, Richter attack
B62 Sicilian: Richter-Rauzer, Keres variation
B63 Sicilian: Richter-Rauzer, Rauzer attack
B63 Sicilian: Richter-Rauzer, Rauzer attack, 7...Be7
B64 Sicilian: Richter-Rauzer, Rauzer attack, 7...Be7 defence, 9.f4
B64 Sicilian: Richter-Rauzer, Rauzer attack, Geller variation
B65 Sicilian: Richter-Rauzer, Rauzer attack, 7...Be7 defence, 9...Nxd4
B65 Sicilian: Richter-Rauzer, Rauzer attack, 7...Be7 defence, 9...Nxd4
B66 Sicilian: Richter-Rauzer, Rauzer attack, 7...a6
B67 Sicilian: Richter-Rauzer, Rauzer attack, 7...a6 defence, 8...Bd7
B68 Sicilian: Richter-Rauzer, Rauzer attack, 7...a6 defence, 9...Be7
B69 Sicilian: Richter-Rauzer, Rauzer attack, 7...a6 defence, 11.Bxf6
B70 Sicilian: dragon variation
B71 Sicilian: dragon, Levenfish variation
B71 Sicilian: dragon, Levenfish; Flohr variation
B72 Sicilian: dragon, 6.Be3
B72 Sicilian: dragon, classical attack
B72 Sicilian: dragon, classical, Amsterdam variation
B72 Sicilian: dragon, classical, Grigoriev variation
B72 Sicilian: dragon, classical, Nottingham variation
B73 Sicilian: dragon, classical, 8.O-O
B73 Sicilian: dragon, classical, Zollner gambit
B73 Sicilian: dragon, classical, Richter variation
B74 Sicilian: dragon, classical, 9.Nb3
B74 Sicilian: dragon, classical, Stockholm attack
B74 Sicilian: dragon, classical, Spielmann variation
B74 Sicilian: dragon, classical, Bernard defence
B74 Sicilian: dragon, classical, Reti-Tartakower variation
B74 Sicilian: dragon, classical, Alekhine variation
B75 Sicilian: dragon, Yugoslav attack
B76 Sicilian: dragon, Yugoslav attack, 7...O-O
B76 Sicilian: dragon, Yugoslav attack, Rauser variation
B77 Sicilian: dragon, Yugoslav attack, 9.Bc4
B77 Sicilian: dragon, Yugoslav attack, Byrne variation
B77 Sicilian: dragon, Yugoslav attack, 9...Bd7
B78 Sicilian: dragon, Yugoslav attack, 10.O-O-O
B79 Sicilian: dragon, Yugoslav attack, 12.h4
B80 Sicilian: Scheveningen variation
B80 Sicilian: Scheveningen, English variation
B80 Sicilian: Scheveningen, Vitolins variation
B80 Sicilian: Scheveningen, fianchetto variation
B81 Sicilian: Scheveningen, Keres attack
B82 Sicilian: Scheveningen, 6.f4
B82 Sicilian: Scheveningen, Tal variation
B83 Sicilian: Scheveningen, 6.Be2
B83 Sicilian: modern Scheveningen
B83 Sicilian: modern Scheveningen, main line
B83 Sicilian: modern Scheveningen, main line with Nb3
B84 Sicilian: Scheveningen (Paulsen), classical variation
B84 Sicilian: Scheveningen, classical, Nd7 system
B84 Sicilian: Scheveningen (Paulsen), classical variation
B85 Sicilian: Scheveningen, classical variation with ...Qc7 and ...Nc6
B85 Sicilian: Scheveningen, classical, Maroczy system
B85 Sicilian: Scheveningen, classical
B85 Sicilian: Scheveningen, classical main line
B86 Sicilian: Sozin attack
B87 Sicilian: Sozin with ...a6 and ...b5
B88 Sicilian: Sozin, Leonhardt variation
B88 Sicilian: Sozin, Fischer variation
B89 Sicilian: Sozin, 7.Be3
B89 Sicilian: Velimirovic attack
B90 Sicilian: Najdorf
B90 Sicilian: Najdorf, Adams attack
B90 Sicilian: Najdorf, Lipnitzky attack
B90 Sicilian: Najdorf, Byrne (English) attack
B91 Sicilian: Najdorf, Zagreb (fianchetto) variation
B92 Sicilian: Najdorf, Opovcensky variation
B93 Sicilian: Najdorf, 6.f4
B94 Sicilian: Najdorf, 6.Bg5
B94 Sicilian: Najdorf, Ivkov variation
B95 Sicilian: Najdorf, 6...e6
B96 Sicilian: Najdorf, 7.f4
B96 Sicilian: Najdorf, Polugayevsky variation
B96 Sicilian: Najdorf, Polugayevsky, Simagin variation
B97 Sicilian: Najdorf, 7...Qb6
B97 Sicilian: Najdorf, Poisoned pawn variation
B98 Sicilian: Najdorf, 7...Be7
B98 Sicilian: Najdorf, Browne variation
B98 Sicilian: Najdorf, Goteborg (Argentine) variation
B98 Sicilian: Najdorf variation
B99 Sicilian: Najdorf, 7...Be7 main line
C00 French defence
C00 French defence, Steiner variation
C00 French: Reti (Spielmann) variation
C00 French: Steinitz attack
C00 French: Labourdonnais variation
C00 French defence
C00 French: Wing gambit
C00 French defence
C00 French: Pelikan variation
C00 French: Two knights variation
C00 French: Chigorin variation
C00 French: King's Indian attack
C00 French: Reversed Philidor formation
C00 French defence
C00 Lengfellner system
C00 St. George defence
C00 French defence
C00 French: Schlechter variation
C00 French: Alapin variation
C01 French: exchange variation
C01 French: exchange, Svenonius variation
C01 French: exchange, Bogolyubov variation
C02 French: advance variation
C02 French: advance, Steinitz variation
C02 French: advance, Nimzovich variation
C02 French: advance, Nimzovich system
C02 French: advance variation
C02 French: advance, Wade variation
C02 French: advance variation
C02 French: advance, Paulsen attack
C02 French: advance, Milner-Barry gambit
C02 French: advance, Euwe variation
C03 French: Tarrasch
C03 French: Tarrasch, Haberditz variation
C03 French: Tarrasch, Guimard variation
C04 French: Tarrasch, Guimard main line
C05 French: Tarrasch, closed variation
C05 French: Tarrasch, Botvinnik variation
C05 French: Tarrasch, closed variation
C06 French: Tarrasch, closed variation, main line
C06 French: Tarrasch, Leningrad variation
C07 French: Tarrasch, open variation
C07 French: Tarrasch, Eliskases variation
C08 French: Tarrasch, open, 4.ed ed
C09 French: Tarrasch, open variation, main line
C10 French: Paulsen variation
C10 French: Marshall variation
C10 French: Rubinstein variation
C10 French: Fort Knox variation
C10 French: Rubinstein variation
C10 French: Rubinstein, Capablanca line
C10 French: Frere (Becker) variation
C11 French defence
C11 French: Swiss variation
C11 French: Henneberger variation
C11 French: Steinitz variation
C11 French: Steinitz, Bradford attack
C11 French: Steinitz variation
C11 French: Steinitz, Brodsky-Jones variation
C11 French: Steinitz variation
C11 French: Steinitz, Boleslavsky variation
C11 French: Steinitz, Gledhill attack
C11 French: Burn variation
C12 French: MacCutcheon variation
C12 French: MacCutcheon, Bogolyubov variation
C12 French: MacCutcheon, advance variation
C12 French: MacCutcheon, Chigorin variation
C12 French: MacCutcheon, Grigoriev variation
C12 French: MacCutcheon, Bernstein variation
C12 French: MacCutcheon, Janowski variation
C12 French: MacCutcheon, Dr. Olland (Dutch) variation
C12 French: MacCutcheon, Tartakower variation
C12 French: MacCutcheon, Lasker variation
C12 French: MacCutcheon, Duras variation
C12 French: MacCutcheon, Lasker variation, 8...g6
C13 French: classical
C13 French: classical, Anderssen variation
C13 French: classical, Anderssen-Richter variation
C13 French: classical, Vistaneckis (Nimzovich) variation
C13 French: classical, Frankfurt variation
C13 French: classical, Tartakower variation
C13 French: Albin-Alekhine-Chatard attack
C13 French: Albin-Alekhine-Chatard attack, Maroczy variation
C13 French: Albin-Alekhine-Chatard attack, Breyer variation
C13 French: Albin-Alekhine-Chatard attack, Teichmann variation
C13 French: Albin-Alekhine-Chatard attack, Spielmann variation
C14 French: classical variation
C14 French: classical, Tarrasch variation
C14 French: classical, Rubinstein variation
C14 French: classical, Alapin variation
C14 French: classical, Pollock variation
C14 French: classical, Steinitz variation
C14 French: classical, Stahlberg variation
C15 French: Winawer (Nimzovich) variation
C15 French: Winawer, Kondratiyev variation
C15 French: Winawer, fingerslip variation
C15 French: Winawer, Alekhine (Maroczy) gambit
C15 French: Winawer, Alekhine gambit, Alatortsev variation
C15 French: Winawer, Alekhine gambit
C15 French: Winawer, Alekhine gambit, Kan variation
C16 French: Winawer, advance variation
C16 French: Winawer, Petrosian variation
C17 French: Winawer, advance variation
C17 French: Winawer, advance, Bogolyubov variation
C17 French: Winawer, advance, Russian variation
C17 French: Winawer, advance, 5.a3
C17 French: Winawer, advance, Rauzer variation
C18 French: Winawer, advance variation
C18 French: Winawer, classical variation
C19 French: Winawer, advance, 6...Ne7
C19 French: Winawer, advance, Smyslov variation
C19 French: Winawer, advance, positional main line
C19 French: Winawer, advance, poisoned pawn variation
C19 French: Winawer, advance, poisoned pawn, Euwe-Gligoric variation
C19 French: Winawer, advance, poisoned pawn, Konstantinopolsky variation
C20 King's pawn game
C20 KP: Indian opening
C20 KP: Mengarini's opening
C20 KP: King's head opening
C20 KP: Patzer opening
C20 KP: Napoleon's opening
C20 KP: Lopez opening
C20 Alapin's opening
C21 Centre game
C21 Centre game, Kieseritsky variation
C21 Halasz gambit
C21 Danish gambit
C21 Danish gambit: Collijn defence
C21 Danish gambit: Schlechter defence
C21 Danish gambit: Soerensen defence
C21 Centre game
C22 Centre game
C22 Centre game: Paulsen attack
C22 Centre game: Charousek variation
C22 Centre game: l'Hermet variation
C22 Centre game: Berger variation
C22 Centre game: Kupreichik variation
C22 Centre game: Hall variation
C23 Bishop's opening
C23 Bishop's opening: Philidor counter-attack
C23 Bishop's opening: Lisitsyn variation
C23 Bishop's opening: Calabrese counter-gambit
C23 Bishop's opening: Calabrese counter-gambit, Jaenisch variation
C23 Bishop's opening: Classical variation
C23 Bishop's opening: Lopez gambit
C23 Bishop's opening: Philidor variation
C23 Bishop's opening: Pratt variation
C23 Bishop's opening: Lewis counter-gambit
C23 Bishop's opening: del Rio variation
C23 Bishop's opening: Lewis gambit
C23 Bishop's opening: Wing gambit
C23 Bishop's opening: MacDonnell double gambit
C23 Bishop's opening: Four pawns' gambit
C24 Bishop's opening: Berlin defence
C24 Bishop's opening: Greco gambit
C24 Bishop's opening: Ponziani gambit
C24 Bishop's opening: Urusov gambit
C24 Bishop's opening: Urusov gambit, Panov variation
C25 Vienna game
C25 Vienna: Zhuravlev countergambit
C25 Vienna game, Max Lange defence
C25 Vienna: Paulsen variation
C25 Vienna: Fyfe gambit
C25 Vienna gambit
C25 Vienna: Steinitz gambit
C25 Vienna: Steinitz gambit, Zukertort defence
C25 Vienna: Steinitz gambit, Fraser-Minckwitz variation
C25 Vienna gambit
C25 Vienna: Hamppe-Allgaier gambit
C25 Vienna: Hamppe-Allgaier gambit, Alapin variation
C25 Vienna: Hamppe-Muzio gambit
C25 Vienna: Hamppe-Muzio, Dubois variation
C25 Vienna: Pierce gambit
C25 Vienna: Pierce gambit, Rushmere attack
C26 Vienna: Falkbeer variation
C26 Vienna: Mengarini variation
C26 Vienna: Paulsen-Mieses variation
C26 Vienna game
C27 Vienna game
C27 Vienna: `Frankenstein-Dracula' variation
C27 Vienna: Adams' gambit
C27 Vienna game
C27 Vienna: Alekhine variation
C27 Boden-Kieseritsky gambit
C27 Boden-Kieseritsky gambit: Lichtenhein defence
C28 Vienna game
C29 Vienna gambit
C29 Vienna gambit: Kaufmann variation
C29 Vienna gambit: Breyer variation
C29 Vienna gambit: Paulsen attack
C29 Vienna gambit: Bardeleben variation
C29 Vienna gambit: Heyde variation
C29 Vienna gambit
C29 Vienna gambit, Wurzburger trap
C29 Vienna gambit, Steinitz variation
C30 King's gambit
C30 KGD: Keene's defence
C30 KGD: Mafia defence
C30 KGD: Norwalde variation
C30 KGD: Norwalde variation, Buecker gambit
C30 KGD: classical variation
C30 KGD: classical, Svenonius variation
C30 KGD: classical, Hanham variation
C30 KGD: classical, 4.c3
C30 KGD: classical, Marshall attack
C30 KGD: classical counter-gambit
C30 KGD: classical, Reti variation
C30 KGD: classical, Soldatenkov variation
C30 KGD: classical, Heath variation
C30 KGD: 2...Nf6
C31 KGD: Falkbeer counter-gambit
C31 KGD: Falkbeer, Tartakower variation
C31 KGD: Falkbeer, Milner-Barry variation
C31 KGD: Falkbeer counter-gambit
C31 KGD: Nimzovich counter-gambit
C31 KGD: Falkbeer, 3...e4
C31 KGD: Falkbeer, Rubinstein variation
C31 KGD: Falkbeer, Nimzovich variation
C31 KGD: Falkbeer, 4.d3
C31 KGD: Falkbeer, Morphy gambit
C32 KGD: Falkbeer, 5.de
C32 KGD: Falkbeer, Alapin variation
C32 KGD: Falkbeer, main line, 7...Bf5
C32 KGD: Falkbeer, Tarrasch variation
C32 KGD: Falkbeer, Charousek gambit
C32 KGD: Falkbeer, Charousek variation
C32 KGD: Falkbeer, Keres variation
C32 KGD: Falkbeer, Reti variation
C33 King's gambit accepted
C33 KGA: Tumbleweed gambit
C33 KGA: Orsini gambit
C33 KGA: Pawn's gambit (Stamma gambit)
C33 KGA: Schurig gambit
C33 KGA: Carrera (Basman) gambit
C33 KGA: Villemson (Steinitz) gambit
C33 KGA: Keres (Mason-Steinitz) gambit
C33 KGA: Breyer gambit
C33 KGA: Lesser bishop's (Petroff-Jaenisch-Tartakower) gambit
C33 KGA: bishop's gambit
C33 KGA: bishop's gambit, Chigorin's attack
C33 KGA: bishop's gambit, Greco variation
C33 KGA: bishop's gambit, classical defence
C33 KGA: bishop's gambit, Grimm attack
C33 KGA: bishop's gambit, classical defence
C33 KGA: bishop's gambit, McDonnell attack
C33 KGA: bishop's gambit, McDonnell attack
C33 KGA: bishop's gambit, Fraser variation
C33 KGA: bishop's gambit, classical defence, Cozio attack
C33 KGA: bishop's gambit, Boden defence
C33 KGA: bishop's gambit, Bryan counter-gambit
C33 KGA: bishop's gambit, Bryan counter-gambit
C33 KGA: bishop's gambit, Steinitz defence
C33 KGA: bishop's gambit, Maurian defence
C33 KGA: bishop's gambit, Ruy Lopez defence
C33 KGA: bishop's gambit, Lopez-Gianutio counter-gambit
C33 KGA: Lopez-Gianutio counter-gambit, Hein variation
C33 KGA: bishop's gambit, Bledow variation
C33 KGA: bishop's gambit, Gifford variation
C33 KGA: bishop's gambit, Boren-Svenonius variation
C33 KGA: bishop's gambit, Anderssen variation
C33 KGA: bishop's gambit, Morphy variation
C33 KGA: bishop's gambit, Cozio (Morphy) defence
C33 KGA: bishop's gambit, Bogolyubov variation
C33 KGA: bishop's gambit, Paulsen attack
C33 KGA: bishop's gambit, Jaenisch variation
C34 King's knight's gambit
C34 KGA: Bonsch-Osmolovsky variation
C34 KGA: Gianutio counter-gambit
C34 KGA: Fischer defence
C34 KGA: Becker defence
C34 KGA: Schallop defence
C35 KGA: Cunningham defence
C35 KGA: Cunningham, Bertin gambit
C35 KGA: Cunningham, three pawns gambit
C35 KGA: Cunningham, Euwe defence
C36 KGA: Abbazia defence (classical defence, modern defence[!])
C36 KGA: Abbazia defence, modern variation
C36 KGA: Abbazia defence, Botvinnik variation
C37 KGA: Quaade gambit
C37 KGA: Rosentreter gambit
C37 KGA: Soerensen gambit
C37 KGA: King's knight's gambit
C37 KGA: Blachly gambit
C37 KGA: Lolli gambit (wild Muzio gambit)
C37 KGA: Lolli gambit, Young variation
C37 KGA: Ghulam Kassim gambit
C37 KGA: MacDonnell gambit
C37 KGA: Salvio gambit
C37 KGA: Silberschmidt gambit
C37 KGA: Salvio gambit, Anderssen counter-attack
C37 KGA: Cochrane gambit
C37 KGA: Herzfeld gambit
C37 KGA: Muzio gambit
C37 KGA: Muzio gambit, Paulsen variation
C37 KGA: double Muzio gambit
C37 KGA: Muzio gambit, From defence
C37 KGA: Muzio gambit, Holloway defence
C37 KGA: Muzio gambit, Kling and Horwitz counter-attack
C37 KGA: Muzio gambit, Brentano defence
C38 King's knight's gambit
C38 KGA: Hanstein gambit
C38 KGA: Philidor gambit
C38 KGA: Greco gambit
C38 KGA: Philidor gambit, Schultz variation
C39 King's knight's gambit
C39 KGA: Allgaier gambit
C39 KGA: Allgaier, Horny defence
C39 KGA: Allgaier, Thorold variation
C39 KGA: Allgaier, Cook variation
C39 KGA: Allgaier, Blackburne gambit
C39 KGA: Allgaier, Walker attack
C39 KGA: Allgaier, Urusov attack
C39 KGA: Allgaier, Schlechter defence
C39 KGA: Kieseritsky, Paulsen defence
C39 KGA: Kieseritsky, long whip (Stockwhip, classical) defence
C39 KGA: Kieseritsky, long whip defence, Jaenisch variation
C39 KGA: Kieseritsky, Brentano (Campbell) defence
C39 KGA: Kieseritsky, Brentano defence, Kaplanek variation
C39 KGA: Kieseritsky, Brentano defence
C39 KGA: Kieseritsky, Brentano defence, Caro variation
C39 KGA: Kieseritsky, Salvio (Rosenthal) defence
C39 KGA: Kieseritsky, Salvio defence, Cozio variation
C39 KGA: Kieseritsky, Polerio defence
C39 KGA: Kieseritsky, Neumann defence
C39 KGA: Kieseritsky, Kolisch defence
C39 KGA: Kieseritsky, Berlin defence
C39 KGA: Kieseritsky, Berlin defence, Riviere variation
C39 KGA: Kieseritsky, Berlin defence, 6.Bc4
C39 KGA: Kieseritsky, Rice gambit
C40 King's knight opening
C40 Gunderam defence
C40 Greco defence
C40 Damiano's defence
C40 QP counter-gambit (elephant gambit)
C40 QP counter-gambit: Maroczy gambit
C40 Latvian counter-gambit
C40 Latvian: Nimzovich variation
C40 Latvian: Fraser defence
C40 Latvian gambit, 3.Bc4
C40 Latvian: Behting variation
C40 Latvian: Polerio variation
C40 Latvian: corkscrew counter-gambit
C41 Philidor's defence
C41 Philidor: Steinitz variation
C41 Philidor: Lopez counter-gambit
C41 Philidor: Lopez counter-gambit, Jaenisch variation
C41 Philidor's defence
C41 Philidor: Philidor counter-gambit
C41 Philidor: Philidor counter-gambit, del Rio attack
C41 Philidor: Philidor counter-gambit, Berger variation
C41 Philidor: Philidor counter-gambit, Zukertort variation
C41 Philidor: exchange variation
C41 Philidor: Boden variation
C41 Philidor: exchange variation
C41 Philidor: Paulsen attack
C41 Philidor: exchange variation
C41 Philidor: Berger variation
C41 Philidor: Larsen variation
C41 Philidor: Nimzovich (Jaenisch) variation
C41 Philidor: Improved Hanham variation
C41 Philidor: Nimzovich, Sozin variation
C41 Philidor: Nimzovich, Larobok variation
C41 Philidor: Nimzovich variation
C41 Philidor: Nimzovich, Sokolsky variation
C41 Philidor: Nimzovich, Rellstab variation
C41 Philidor: Nimzovich, Locock variation
C41 Philidor: Nimzovich, Klein variation
C41 Philidor: Hanham variation
C41 Philidor: Hanham, Krause variation
C41 Philidor: Hanham, Steiner variation
C41 Philidor: Hanham, Kmoch variation
C41 Philidor: Hanham, Berger variation
C41 Philidor: Hanham, Schlechter variation
C41 Philidor: Hanham, Delmar variation
C42 Petrov's defence
C42 Petrov: French attack
C42 Petrov: Kaufmann attack
C42 Petrov: Nimzovich attack
C42 Petrov: Cozio (Lasker) attack
C42 Petrov: classical attack
C42 Petrov: classical attack, Chigorin variation
C42 Petrov: classical attack, Berger variation
C42 Petrov: classical attack, Krause variation
C42 Petrov: classical attack, Maroczy variation
C42 Petrov: classical attack, Jaenisch variation
C42 Petrov: classical attack, Mason variation
C42 Petrov: classical attack, Marshall variation
C42 Petrov: classical attack, Tarrasch variation
C42 Petrov: classical attack, Marshall trap
C42 Petrov: classical attack, close variation
C42 Petrov: Cochrane gambit
C42 Petrov: Paulsen attack
C42 Petrov: Damiano variation
C42 Petrov three knights game
C42 Petrov: Italian variation
C43 Petrov: modern (Steinitz) attack
C43 Petrov: modern attack, main line
C43 Petrov: modern attack, Steinitz variation
C43 Petrov: modern attack, Bardeleben variation
C43 Petrov: Urusov gambit
C43 Petrov: modern attack, Symmetrical variation
C43 Petrov: modern attack, Trifunovic variation
C44 King's pawn game
C44 Irish (Chicago) gambit
C44 Konstantinopolsky opening
C44 Dresden opening
C44 Inverted Hungarian
C44 Inverted Hanham
C44 Tayler opening
C44 Ponziani opening
C44 Ponziani: Caro variation
C44 Ponziani: Leonhardt variation
C44 Ponziani: Steinitz variation
C44 Ponziani: Jaenisch counter-attack
C44 Ponziani: Fraser defence
C44 Ponziani: Reti variation
C44 Ponziani: Romanishin variation
C44 Ponziani counter-gambit
C44 Ponziani counter-gambit, Schmidt attack
C44 Ponziani counter-gambit, Cordel variation
C44 Scotch opening
C44 Scotch: Lolli variation
C44 Scotch: Cochrane variation
C44 Scotch: Relfsson gambit ('MacLopez')
C44 Scotch: Goering gambit
C44 Scotch: Sea-cadet mate
C44 Scotch: Goering gambit
C44 Scotch: Goering gambit, Bardeleben variation
C44 Scotch gambit
C44 Scotch gambit: Anderssen (Paulsen, Suhle) counter-attack
C44 Scotch gambit
C44 Scotch gambit: Cochrane-Shumov defence
C44 Scotch gambit: Vitzhum attack
C44 Scotch gambit
C44 Scotch gambit: Hanneken variation
C44 Scotch gambit
C44 Scotch gambit: Cochrane variation
C44 Scotch gambit: Benima defence
C44 Scotch gambit: Dubois-Reti defence
C45 Scotch game
C45 Scotch: Ghulam Kassim variation
C45 Scotch: Pulling counter-attack
C45 Scotch: Horwitz attack
C45 Scotch: Berger variation
C45 Scotch game
C45 Scotch: Rosenthal variation
C45 Scotch: Fraser attack
C45 Scotch: Steinitz variation
C45 Scotch: Schmidt variation
C45 Scotch: Mieses variation
C45 Scotch: Tartakower variation
C45 Scotch game
C45 Scotch: Blackburne attack
C45 Scotch: Gottschall variation
C45 Scotch: Paulsen attack
C45 Scotch: Paulsen, Gunsberg defence
C45 Scotch: Meitner variation
C45 Scotch: Blumenfeld attack
C45 Scotch: Potter variation
C45 Scotch: Romanishin variation
C46 Three knights game
C46 Three knights: Schlechter variation
C46 Three knights: Winawer defence (Gothic defence)
C46 Three knights: Steinitz variation
C46 Three knights: Steinitz, Rosenthal variation
C46 Four knights game
C46 Four knights: Schultze-Mueller gambit
C46 Four knights: Italian variation
C46 Four knights: Gunsberg variation
C47 Four knights: Scotch variation
C47 Four knights: Scotch, Krause variation
C47 Four knights: Scotch, 4...exd4
C47 Four knights: Belgrade gambit
C48 Four knights: Spanish variation
C48 Four knights: Ranken variation
C48 Four knights: Spielmann variation
C48 Four knights: Spanish, classical defence
C48 Four knights: Bardeleben variation
C48 Four knights: Marshall variation
C48 Four knights: Rubinstein counter-gambit
C48 Four knights: Rubinstein counter-gambit, Bogolyubov variation
C48 Four knights: Rubinstein counter-gambit, 5.Be2
C48 Four knights: Rubinstein counter-gambit Maroczy variation
C48 Four knights: Rubinstein counter-gambit, exchange variation
C48 Four knights: Rubinstein counter-gambit, Henneberger variation
C49 Four knights: double Ruy Lopez
C49 Four knights: Gunsberg counter-attack
C49 Four knights: double Ruy Lopez
C49 Four knights: Alatortsev variation
C49 Four knights
C49 Four knights: Janowski variation
C49 Four knights: Svenonius variation
C49 Four knights: symmetrical variation
C49 Four knights: symmetrical, Metger unpin
C49 Four knights: symmetrical, Capablanca variation
C49 Four knights: symmetrical, Pillsbury variation
C49 Four knights: symmetrical, Blake variation
C49 Four knights: symmetrical, Tarrasch variation
C49 Four knights: symmetrical, Maroczy system
C49 Four knights: Nimzovich (Paulsen) variation
C50 King's pawn game
C50 Blackburne shilling gambit
C50 Rousseau gambit
C50 Hungarian defence
C50 Hungarian defence: Tartakower variation
C50 Giuoco Piano
C50 Giuoco Piano: four knights variation
C50 Giuoco Piano: Jerome gambit
C50 Giuoco Pianissimo
C50 Giuoco Pianissimo: Dubois variation
C50 Giuoco Pianissimo
C50 Giuoco Pianissimo: Italian four knights variation
C50 Giuoco Pianissimo: Canal variation
C51 Evans gambit declined
C51 Evans gambit declined, Lange variation
C51 Evans gambit declined, Pavlov variation
C51 Evans gambit declined, Hirschbach variation
C51 Evans gambit declined, Vasquez variation
C51 Evans gambit declined, Hicken variation
C51 Evans gambit declined, 5.a4
C51 Evans gambit declined, Showalter variation
C51 Evans gambit declined, Cordel variation
C51 Evans counter-gambit
C51 Evans gambit
C51 Evans gambit: normal variation
C51 Evans gambit: Ulvestad variation
C51 Evans gambit: Paulsen variation
C51 Evans gambit: Morphy attack
C51 Evans gambit: Goering attack
C51 Evans gambit: Steinitz variation
C51 Evans gambit
C51 Evans gambit: Fraser attack
C51 Evans gambit: Fraser-Mortimer attack
C51 Evans gambit: Stone-Ware variation
C51 Evans gambit: Mayet defence
C51 Evans gambit: 5...Be7
C51 Evans gambit: Cordel variation
C52 Evans gambit
C52 Evans gambit: compromised defence
C52 Evans gambit: compromised defence, Paulsen variation
C52 Evans gambit: compromised defence, Potter variation
C52 Evans gambit: Leonhardt variation
C52 Evans gambit
C52 Evans gambit: Tartakower attack
C52 Evans gambit: Levenfish variation
C52 Evans gambit: Sokolsky variation
C52 Evans gambit
C52 Evans gambit: Richardson attack
C52 Evans gambit
C52 Evans gambit: Waller attack
C52 Evans gambit: Lasker defence
C52 Evans gambit: Sanders-Alapin variation
C52 Evans gambit: Alapin-Steinitz variation
C53 Giuoco Piano
C53 Giuoco Piano: LaBourdonnais variation
C53 Giuoco Piano: close variation
C53 Giuoco Piano: centre-holding variation
C53 Giuoco Piano: Tarrasch variation
C53 Giuoco Piano: Mestel variation
C53 Giuoco Piano: Eisinger variation
C53 Giuoco Piano
C53 Giuoco Piano: Bird's attack
C53 Giuoco Piano
C53 Giuoco Piano: Ghulam Kassim variation
C53 Giuoco Piano
C53 Giuoco Piano: Anderssen variation
C54 Giuoco Piano
C54 Giuoco Piano: Krause variation
C54 Giuoco Piano: Cracow variation
C54 Giuoco Piano: Greco's attack
C54 Giuoco Piano: Greco variation
C54 Giuoco Piano: Bernstein variation
C54 Giuoco Piano: Aitken variation
C54 Giuoco Piano
C54 Giuoco Piano: Steinitz variation
C54 Giuoco Piano: Moeller (Therkatz) attack
C54 Giuoco Piano: Therkatz-Herzog variation
C54 Giuoco Piano: Moeller, bayonet attack
C55 Two knights defence
C55 Giuoco piano: Rosentreter variation
C55 Giuoco piano
C55 Giuoco piano: Holzhausen attack
C55 Two knights defence (Modern bishop's opening)
C55 Two knights defence
C55 Two knights defence, Keidanz variation
C55 Two knights defence, Perreux variation
C55 Two knights defence
C55 two knights: Max Lange attack
C55 two knights: Max Lange attack, Berger variation
C55 two knights: Max Lange attack, Marshall variation
C55 two knights: Max Lange attack, Rubinstein variation
C55 two knights: Max Lange attack, Loman defence
C55 two knights: Max Lange attack, Schlechter variation
C55 two knights: Max Lange attack, Steinitz variation
C55 two knights: Max Lange attack, Krause variation
C56 Two knights defence
C56 two knights defence: Yurdansky attack
C56 two knights defence: Canal variation
C57 Two knights defence
C57 two knights defence: Wilkes Barre (Traxler) variation
C57 two knights defence: Ulvestad variation
C57 two knights defence: Fritz variation
C57 two knights defence: Fritz, Gruber variation
C57 two knights defence: Lolli attack
C57 two knights defence: Pincus variation
C57 two knights defence: Fegatello attack
C57 two knights defence: Fegatello attack, Leonhardt variation
C57 two knights defence: Fegatello attack, Polerio defence
C58 two knights defence
C58 two knights defence: Kieseritsky variation
C58 two knights defence: Yankovich variation
C58 two knights defence: Maroczy variation
C58 Two knights defence
C58 two knights defence: Bogolyubov variation
C58 two knights defence: Paoli variation
C58 two knights defence: Colman variation
C58 two knights defence: Blackburne variation
C58 Two knights defence
C59 Two knights defence
C59 two knights defence: Knorre variation
C59 two knights defence: Goering variation
C59 two knights defence: Steinitz variation
C60 Ruy Lopez (Spanish opening)
C60 Ruy Lopez: Nuernberg variation
C60 Ruy Lopez: Pollock defence
C60 Ruy Lopez: Lucena defence
C60 Ruy Lopez: Vinogradov variation
C60 Ruy Lopez: Brentano defence
C60 Ruy Lopez: fianchetto (Smyslov/Barnes) defence
C60 Ruy Lopez: Cozio defence
C60 Ruy Lopez: Cozio defence, Paulsen variation
C61 Ruy Lopez: Bird's defence
C61 Ruy Lopez: Bird's defence, Paulsen variation
C62 Ruy Lopez: old Steinitz defence
C62 Ruy Lopez: old Steinitz defence, Nimzovich attack
C62 Ruy Lopez: old Steinitz defence, semi-Duras variation
C63 Ruy Lopez: Schliemann defence
C63 Ruy Lopez: Schliemann defence, Berger variation
C64 Ruy Lopez: classical (Cordel) defence
C64 Ruy Lopez: classical defence, Zaitsev variation
C64 Ruy Lopez: classical defence, 4.c3
C64 Ruy Lopez: classical defence, Benelux variation 
C64 Ruy Lopez: classical defence, Charousek variation
C64 Ruy Lopez: classical defence, Boden variation
C64 Ruy Lopez: Cordel gambit
C65 Ruy Lopez: Berlin defence
C65 Ruy Lopez: Berlin defence, Nyholm attack
C65 Ruy Lopez: Berlin defence, Mortimer variation
C65 Ruy Lopez: Berlin defence, Mortimer trap
C65 Ruy Lopez: Berlin defence, Anderssen variation
C65 Ruy Lopez: Berlin defence, Duras variation
C65 Ruy Lopez: Berlin defence, Kaufmann variation
C65 Ruy Lopez: Berlin defence, 4.O-O
C65 Ruy Lopez: Berlin defence, Beverwijk variation
C66 Ruy Lopez: Berlin defence, 4.O-O, d6
C66 Ruy Lopez: Berlin defence, hedgehog variation
C66 Ruy Lopez: Berlin defence, Tarrasch trap
C66 Ruy Lopez: closed Berlin defence, Bernstein variation
C66 Ruy Lopez: closed Berlin defence, Showalter variation
C66 Ruy Lopez: closed Berlin defence, Wolf variation
C66 Ruy Lopez: closed Berlin defence, Chigorin variation
C67 Ruy Lopez: Berlin defence, open variation
C67 Ruy Lopez: open Berlin defence, l'Hermet variation
C67 Ruy Lopez: open Berlin defence, Showalter variation
C67 Ruy Lopez: open Berlin defence, 5...Be7
C67 Ruy Lopez: Berlin defence, Rio de Janeiro variation
C67 Ruy Lopez: Berlin defence, Zukertort variation
C67 Ruy Lopez: Berlin defence, Pillsbury variation
C67 Ruy Lopez: Berlin defence, Winawer attack
C67 Ruy Lopez: Berlin defence, Cordel variation
C67 Ruy Lopez: Berlin defence, Trifunovic variation
C67 Ruy Lopez: Berlin defence, Minckwitz variation
C67 Ruy Lopez: Berlin defence, Rosenthal variation
C68 Ruy Lopez: exchange variation
C68 Ruy Lopez: exchange, Alekhine variation
C68 Ruy Lopez: exchange, Keres variation
C68 Ruy Lopez: exchange, Romanovsky variation
C69 Ruy Lopez: exchange variation, 5.O-O
C69 Ruy Lopez: exchange variation, Alapin gambit
C69 Ruy Lopez: exchange, Gligoric variation
C69 Ruy Lopez: exchange, Bronstein variation
C70 Ruy Lopez
C70 Ruy Lopez: fianchetto defence deferred
C70 Ruy Lopez: Cozio defence deferred
C70 Ruy Lopez: Bird's defence deferred
C70 Ruy Lopez: Alapin's defence deferred
C70 Ruy Lopez: Classical defence deferred
C70 Ruy Lopez: Caro variation
C70 Ruy Lopez: Graz variation
C70 Ruy Lopez: Taimanov (chase/wing/accelerated counterthrust) variation
C70 Ruy Lopez: Schliemann defence deferred
C71 Ruy Lopez: modern Steinitz defence
C71 Ruy Lopez: Noah's ark trap
C71 Ruy Lopez: modern Steinitz defence, Three knights variation
C71 Ruy Lopez: modern Steinitz defence, Duras (Keres) variation
C72 Ruy Lopez: modern Steinitz defence, 5.O-O
C73 Ruy Lopez: modern Steinitz defence, Richter variation
C73 Ruy Lopez: modern Steinitz defence, Alapin variation
C74 Ruy Lopez: modern Steinitz defence
C74 Ruy Lopez: modern Steinitz defence, siesta variation
C74 Ruy Lopez: Siesta, Kopayev variation
C75 Ruy Lopez: modern Steinitz defence
C75 Ruy Lopez: modern Steinitz defence, Rubinstein variation
C76 Ruy Lopez: modern Steinitz defence, fianchetto (Bronstein) variation
C77 Ruy Lopez: Morphy defence
C77 Ruy Lopez: four knights (Tarrasch) variation
C77 Ruy Lopez: Treybal (Bayreuth) variation (exchange var. deferred)
C77 Ruy Lopez: Wormald (Alapin) attack
C77 Ruy Lopez: Wormald attack, Gruenfeld variation
C77 Ruy Lopez: Anderssen variation
C77 Ruy Lopez: Morphy defence, Duras variation
C78 Ruy Lopez: 5.O-O
C78 Ruy Lopez: Wing attack
C78 Ruy Lopez: ...b5 & ...d6
C78 Ruy Lopez: Rabinovich variation
C78 Ruy Lopez: Archangelsk (counterthrust) variation
C78 Ruy Lopez: Moeller defence
C79 Ruy Lopez: Steinitz defence deferred (Russian defence)
C79 Ruy Lopez: Steinitz defence deferred, Lipnitsky variation
C79 Ruy Lopez: Steinitz defence deferred, Rubinstein variation
C79 Ruy Lopez: Steinitz defence deferred, Boleslavsky variation
C80 Ruy Lopez: open (Tarrasch) defence
C80 Ruy Lopez: open, Tartakower variation
C80 Ruy Lopez: open, Knorre variation
C80 Ruy Lopez: open, 6.d4
C80 Ruy Lopez: open, Riga variation
C80 Ruy Lopez: open, 6.d4 b5
C80 Ruy Lopez: open, Friess attack
C80 Ruy Lopez: open, Richter variation
C80 Ruy Lopez: open, 7.Bb3
C80 Ruy Lopez: open, Schlechter defence
C80 Ruy Lopez: open, Berger variation
C80 Ruy Lopez: open, Harksen gambit
C80 Ruy Lopez: open, 8.de
C80 Ruy Lopez: open, Zukertort variation
C80 Ruy Lopez: open, 8...Be6
C80 Ruy Lopez: open, Bernstein variation
C80 Ruy Lopez: open, Bernstein variation, Karpov gambit
C81 Ruy Lopez: open, Howell attack
C81 Ruy Lopez: open, Howell attack, Ekstroem variation
C81 Ruy Lopez: open, Howell attack, Adam variation
C82 Ruy Lopez: open, 9.c3
C82 Ruy Lopez: open, Berlin variation
C82 Ruy Lopez: open, Italian variation
C82 Ruy Lopez: open, St. Petersburg variation
C82 Ruy Lopez: open, Dilworth variation
C82 Ruy Lopez: open, Motzko attack
C82 Ruy Lopez: open, Motzko attack, Nenarokov variation
C83 Ruy Lopez: open, classical defence
C83 Ruy Lopez: open, Malkin variation
C83 Ruy Lopez: open, 9...Be7, 10.Re1
C83 Ruy Lopez: open, Tarrasch trap
C83 Ruy Lopez: open, Breslau variation
C84 Ruy Lopez: closed defence
C84 Ruy Lopez: closed, centre attack
C84 Ruy Lopez: closed, Basque gambit (North Spanish variation)
C85 Ruy Lopez: Exchange variation doubly deferred (DERLD)
C86 Ruy Lopez: Worrall attack
C86 Ruy Lopez: Worrall attack, sharp line
C86 Ruy Lopez: Worrall attack, solid line
C87 Ruy Lopez: closed, Averbach variation
C88 Ruy Lopez: closed
C88 Ruy Lopez: closed, Leonhardt variation
C88 Ruy Lopez: closed, Balla variation
C88 Ruy Lopez: closed, 7...d6, 8.d4
C88 Ruy Lopez: Noah's ark trap
C88 Ruy Lopez: Trajkovic counter-attack
C88 Ruy Lopez: closed, 7...O-O
C88 Ruy Lopez: closed, anti-Marshall 8.a4
C88 Ruy Lopez: closed, 8.c3
C89 Ruy Lopez: Marshall counter-attack
C89 Ruy Lopez: Marshall counter-attack, 11...c6
C89 Ruy Lopez: Marshall, Kevitz variation
C89 Ruy Lopez: Marshall, main line, 12.d2d4
C89 Ruy Lopez: Marshall, main line, 14...Qh3
C89 Ruy Lopez: Marshall, main line, Spassky variation
C89 Ruy Lopez: Marshall, Herman Steiner variation
C90 Ruy Lopez: closed (with ...d6)
C90 Ruy Lopez: closed, Pilnik variation
C90 Ruy Lopez: closed, Lutikov variation
C90 Ruy Lopez: closed, Suetin variation
C91 Ruy Lopez: closed, 9.d4
C91 Ruy Lopez: closed, Bogolyubov variation
C92 Ruy Lopez: closed, 9.h3
C92 Ruy Lopez: closed, Keres (9...a5) variation
C92 Ruy Lopez: closed, Kholmov variation
C92 Ruy Lopez: closed, Ragozin-Petrosian (`Keres') variation
C92 Ruy Lopez: closed, Flohr-Zaitsev system (Lenzerheide variation)
C93 Ruy Lopez: closed, Smyslov defence
C94 Ruy Lopez: closed, Breyer defence
C95 Ruy Lopez: closed, Breyer, 10.d4
C95 Ruy Lopez: closed, Breyer, Borisenko variation
C95 Ruy Lopez: closed, Breyer, Gligoric variation
C95 Ruy Lopez: closed, Breyer, Simagin variation
C96 Ruy Lopez: closed (8...Na5)
C96 Ruy Lopez: closed, Rossolimo defence
C96 Ruy Lopez: closed (10...c5)
C96 Ruy Lopez: closed, Borisenko defence
C96 Ruy Lopez: closed, Keres (...Nd7) defence
C97 Ruy Lopez: closed, Chigorin defence
C97 Ruy Lopez: closed, Chigorin, Yugoslav system
C98 Ruy Lopez: closed, Chigorin, 12...Nc6
C98 Ruy Lopez: closed, Chigorin, Rauzer attack
C99 Ruy Lopez: closed, Chigorin, 12...c5d4
D00 Queen's pawn game
D00 Queen's pawn, Mason variation
D00 Queen's pawn, Mason variation, Steinitz counter-gambit
D00 Levitsky attack (Queen's bishop attack)
D00 Blackmar gambit
D00 Queen's pawn: stonewall attack
D00 Queen's pawn: Chigorin variation
D00 Queen's pawn: Anti-Veresov
D00 Blackmar-Diemer gambit
D00 Blackmar-Diemer: Euwe defence
D00 Blackmar-Diemer: Lemberg counter-gambit
D01 Richter-Veresov attack
D01 Richter-Veresov attack, Veresov variation
D01 Richter-Veresov attack, Richter variation
D02 Queen's pawn game
D02 Queen's pawn game, Chigorin variation
D02 Queen's pawn game, Krause variation
D02 Queen's pawn game
D02 Queen's bishop game
D03 Torre attack (Tartakower variation)
D04 Queen's pawn game
D05 Queen's pawn game
D05 Queen's pawn game, Zukertort variation
D05 Queen's pawn game
D05 Queen's pawn game, Rubinstein (Colle-Zukertort) variation
D05 Colle system
D06 Queen's Gambit
D06 QGD: Grau (Sahovic) defence
D06 QGD: Marshall defence
D06 QGD: symmetrical (Austrian) defence
D07 QGD: Chigorin defence
D07 QGD: Chigorin defence, Janowski variation
D08 QGD: Albin counter-gambit
D08 QGD: Albin counter-gambit, Lasker trap
D08 QGD: Albin counter-gambit
D08 QGD: Albin counter-gambit, Alapin variation
D08 QGD: Albin counter-gambit, Krenosz variation
D08 QGD: Albin counter-gambit, Janowski variation
D08 QGD: Albin counter-gambit, Balogh variation
D09 QGD: Albin counter-gambit, 5.g3
D10 QGD Slav defence
D10 QGD Slav defence, Alekhine variation
D10 QGD Slav: Winawer counter-gambit
D10 QGD Slav defence: exchange variation
D11 QGD Slav: 3.Nf3
D11 QGD Slav: Breyer variation
D11 QGD Slav: 4.e3
D12 QGD Slav: 4.e3 Bf5
D12 QGD Slav: Landau variation
D12 QGD Slav: exchange variation
D12 QGD Slav: Amsterdam variation
D13 QGD Slav: exchange variation
D14 QGD Slav: exchange variation, 6.Bf4 Bf5
D14 QGD Slav: exchange, Trifunovic variation
D15 QGD Slav: 4.Nc3
D15 QGD Slav: Suechting variation
D15 QGD Slav: Schlechter variation
D15 QGD Slav accepted
D15 QGD Slav: 5.e3 (Alekhine variation)
D15 QGD Slav: Slav gambit
D15 QGD Slav: Tolush-Geller gambit
D16 QGD Slav accepted: Alapin variation
D16 QGD Slav: Smyslov variation
D16 QGD Slav: Soultanbeieff variation
D16 QGD Slav: Steiner variation
D17 QGD Slav: Czech defence
D17 QGD Slav: Krause attack
D17 QGD Slav: Carlsbad variation
D17 QGD Slav: Wiesbaden variation
D18 QGD Slav: Dutch variation
D18 QGD Slav: Dutch, Lasker variation
D19 QGD Slav: Dutch variation
D19 QGD Slav: Dutch variation, main line
D19 QGD Slav: Dutch, Saemisch variation
D20 Queen's gambit accepted
D20 QGA: 3.e4
D20 QGA: Linares variation
D20 QGA: Schwartz defence
D21 QGA: 3.Nf3
D21 QGA: Ericson variation
D21 QGA: Alekhine defense, Borisenko-Furman variation
D22 QGA: Alekhine defence
D22 QGA: Alekhine defence, Alatortsev variation
D22 QGA: Haberditz variation
D23 Queen's gambit accepted
D23 QGA: Mannheim variation
D24 QGA, 4.Nc3
D24 QGA, Bogolyubov variation
D25 QGA, 4.e3
D25 QGA, Smyslov variation
D25 QGA, Janowsky-Larsen variation
D25 QGA, Flohr variation
D26 QGA: 4...e6
D26 QGA: classical variation
D26 QGA: classical, Furman variation
D26 QGA: classical variation, 6.O-O
D26 QGA: classical, Steinitz variation
D27 QGA: classical, 6...a6
D27 QGA: classical, Rubinstein variation
D27 QGA: classical, Geller variation
D28 QGA: classical, 7.Qe2
D28 QGA: classical, 7...b5
D28 QGA: classical, Flohr variation
D29 QGA: classical, 8...Bb7
D29 QGA: classical, Smyslov variation
D30 Queen's gambit declined
D30 QGD Slav
D30 QGD: Stonewall variation
D30 QGD Slav
D30 QGD Slav: Semmering variation
D30 QGD: Spielmann variation
D30 QGD
D30 QGD: Capablanca variation
D30 QGD: Vienna variation
D30 QGD: Capablanca-Duras variation
D30 QGD: Hastings variation
D31 QGD: 3.Nc3
D31 QGD: Janowski variation
D31 QGD: Alapin variation
D31 QGD: Charousek (Petrosian) variation
D31 QGD: semi-Slav
D31 QGD: semi-Slav, Noteboom variation
D31 QGD: semi-Slav, Koomen variation
D31 QGD: semi-Slav, Junge variation
D31 QGD: semi-Slav, Abrahams variation
D31 QGD: semi-Slav, Marshall gambit
D32 QGD: Tarrasch defence
D32 QGD: Tarrasch, von Hennig-Schara gambit
D32 QGD: Tarrasch defence, 4.cd ed
D32 QGD: Tarrasch defence, Tarrasch gambit
D32 QGD: Tarrasch defence, Marshall gambit
D32 QGD: Tarrasch defence
D33 QGD: Tarrasch, Schlechter-Rubinstein system
D33 QGD: Tarrasch, Folkestone (Swedish) variation
D33 QGD: Tarrasch, Schlechter-Rubinstein system, Rey Ardid variation
D33 QGD: Tarrasch, Prague variation
D33 QGD: Tarrasch, Wagner variation
D34 QGD: Tarrasch, Prague variation, 7...Be7
D34 QGD: Tarrasch, Prague variation, Normal position
D34 QGD: Tarrasch, Reti variation
D34 QGD: Tarrasch, Prague variation, 9.Bg5
D34 QGD: Tarrasch, Bogolyubov variation
D34 QGD: Tarrasch, Stoltz variation
D35 QGD: 3...Nf6
D35 QGD: Harrwitz attack
D35 QGD: exchange variation
D35 QGD: exchange, Saemisch variation
D35 QGD: exchange, positional line
D35 QGD: exchange, chameleon variation
D35 QGD: exchange, positional line, 5...c6
D36 QGD: exchange, positional line, 6.Qc2
D37 QGD: 4.Nf3
D37 QGD: classical variation (5.Bf4)
D38 QGD: Ragozin variation
D39 QGD: Ragozin, Vienna variation
D40 QGD: Semi-Tarrasch defence
D40 QGD: Semi-Tarrasch, symmetrical variation
D40 QGD: Semi-Tarrasch, Levenfish variation
D40 QGD: Semi-Tarrasch defence, Pillsbury variation
D41 QGD: Semi-Tarrasch, 5.cd
D41 QGD: Semi-Tarrasch, Kmoch variation
D41 QGD: Semi-Tarrasch, San Sebastian variation
D41 QGD: Semi-Tarrasch with e3
D42 QGD: Semi-Tarrasch, 7.Bd3
D43 QGD semi-Slav
D43 QGD semi-Slav: Hastings variation
D44 QGD semi-Slav: 5.Bg5 dc
D44 QGD semi-Slav: Botvinnik system (anti-Meran)
D44 QGD semi-Slav: Ekstrom variation
D44 QGD semi-Slav: anti-Meran gambit
D44 QGD semi-Slav: anti-Meran, Lilienthal variation
D44 QGD semi-Slav: anti-Meran, Szabo variation
D44 QGD semi-Slav: anti-Meran, Alatortsev system
D45 QGD semi-Slav: 5.e3
D45 QGD semi-Slav: stonewall defence
D45 QGD semi-Slav: accelerated Meran (Alekhine variation)
D45 QGD semi-Slav: 5...Nd7
D45 QGD semi-Slav: Stoltz variation
D45 QGD semi-Slav: Rubinstein (anti-Meran) system
D46 QGD semi-Slav: 6.Bd3
D46 QGD semi-Slav: Bogolyubov variation
D46 QGD semi-Slav: Romih variation
D46 QGD semi-Slav: Chigorin defence
D47 QGD semi-Slav: 7.Bc4
D47 QGD semi-Slav: Meran variation
D47 QGD semi-Slav: neo-Meran (Lundin variation)
D47 QGD semi-Slav: Meran, Wade variation
D48 QGD semi-Slav: Meran, 8...a6
D48 QGD semi-Slav: Meran, Pirc variation
D48 QGD semi-Slav: Meran
D48 QGD semi-Slav: Meran, Reynolds' variation
D48 QGD semi-Slav: Meran, old main line
D49 QGD semi-Slav: Meran, Blumenfeld variation
D49 QGD semi-Slav: Meran, Rabinovich variation
D49 QGD semi-Slav: Meran, Sozin variation
D49 QGD semi-Slav: Meran, Stahlberg variation
D49 QGD semi-Slav: Meran, Sozin variation
D49 QGD semi-Slav: Meran, Rellstab attack
D50 QGD: 4.Bg5
D50 QGD: Been-Koomen variation
D50 QGD: Semi-Tarrasch, Krause variation
D50 QGD: Semi-Tarrasch, Primitive Pillsbury variation
D50 QGD: Semi-Tarrasch
D50 QGD: Canal (Venice) variation
D51 QGD: 4.Bg5 Nbd7
D51 QGD: Rochlin variation
D51 QGD: Alekhine variation
D51 QGD
D51 QGD: Manhattan variation
D51 QGD: 5...c6
D51 QGD: Capablanca anti-Cambridge Springs variation
D52 QGD
D52 QGD: Cambridge Springs defence
D52 QGD: Cambridge Springs defence, Bogoljubow variation
D52 QGD: Cambridge Springs defence, Argentine variation
D52 QGD: Cambridge Springs defence, Rubinstein variation
D52 QGD: Cambridge Springs defence, Capablanca variation
D52 QGD: Cambridge Springs defence, 7.cd
D52 QGD: Cambridge Springs defence, Yugoslav variation
D53 QGD: 4.Bg5 Be7
D53 QGD: Lasker variation
D53 QGD: 4.Bg5 Be7, 5.e3 O-O
D54 QGD: Anti-neo-orthodox variation
D55 QGD: 6.Nf3
D55 QGD: Pillsbury attack
D55 QGD: Neo-orthodox variation
D55 QGD: Neo-orthodox variation, 7.Bxf6
D55 QGD: Petrosian variation
D55 QGD: Neo-orthodox variation, 7.Bh4
D56 QGD: Lasker defence
D56 QGD: Lasker defence, Teichmann variation
D56 QGD: Lasker defence, Russian variation
D57 QGD: Lasker defence, main line
D57 QGD: Lasker defence, Bernstein variation
D58 QGD: Tartakower (Makagonov-Bondarevsky) system
D59 QGD: Tartakower (Makagonov-Bondarevsky) system, 8.cd Nxd5
D59 QGD: Tartakower variation
D60 QGD: Orthodox defence
D60 QGD: Orthodox defence, Botvinnik variation
D60 QGD: Orthodox defence, Rauzer variation
D61 QGD: Orthodox defence, Rubinstein variation
D62 QGD: Orthodox defence, 7.Qc2 c5, 8.cd (Rubinstein)
D63 QGD: Orthodox defence, 7.Rc1
D63 QGD: Orthodox defence, Pillsbury attack
D63 QGD: Orthodox defence, Capablanca variation
D63 QGD: Orthodox defence, Swiss (Henneberger) variation
D63 QGD: Orthodox defence, Swiss, Karlsbad variation
D63 QGD: Orthodox defence
D64 QGD: Orthodox defence, Rubinstein attack (with Rc1)
D64 QGD: Orthodox defence, Rubinstein attack, Wolf variation
D64 QGD: Orthodox defence, Rubinstein attack, Karlsbad variation
D64 QGD: Orthodox defence, Rubinstein attack, Gruenfeld variation
D65 QGD: Orthodox defence, Rubinstein attack, main line
D66 QGD: Orthodox defence, Bd3 line
D66 QGD: Orthodox defence, Bd3 line, fianchetto variation
D67 QGD: Orthodox defence, Bd3 line, Capablanca freeing manoevre
D67 QGD: Orthodox defence, Bd3 line, Janowski variation
D67 QGD: Orthodox defence, Bd3 line
D67 QGD: Orthodox defence, Bd3 line, Alekhine variation
D67 QGD: Orthodox defence, Bd3 line, 11.O-O
D68 QGD: Orthodox defence, classical variation
D68 QGD: Orthodox defence, classical, 13.d1b1 (Maroczy)
D68 QGD: Orthodox defence, classical, 13.d1c2 (Vidmar)
D69 QGD: Orthodox defence, classical, 13.de
D70 Neo-Gruenfeld defence
D70 Neo-Gruenfeld (Kemeri) defence
D71 Neo-Gruenfeld, 5.cd
D72 Neo-Gruenfeld, 5.cd, main line
D73 Neo-Gruenfeld, 5.Nf3
D74 Neo-Gruenfeld, 6.cd Nxd5, 7.O-O
D75 Neo-Gruenfeld, 6.cd Nxd5, 7.O-O c5, 8.Nc3
D75 Neo-Gruenfeld, 6.cd Nxd5, 7.O-O c5, 8.dc
D76 Neo-Gruenfeld, 6.cd Nxd5, 7.O-O Nb6
D77 Neo-Gruenfeld, 6.O-O
D78 Neo-Gruenfeld, 6.O-O c6
D79 Neo-Gruenfeld, 6.O-O, main line
D80 Gruenfeld defence
D80 Gruenfeld: Spike gambit
D80 Gruenfeld: Stockholm variation
D80 Gruenfeld: Lundin variation
D81 Gruenfeld: Russian variation
D82 Gruenfeld: 4.Bf4
D83 Gruenfeld: Gruenfeld gambit
D83 Gruenfeld: Gruenfeld gambit, Capablanca variation
D83 Gruenfeld: Gruenfeld gambit, Botvinnik variation
D84 Gruenfeld: Gruenfeld gambit accepted
D85 Gruenfeld: exchange variation
D85 Gruenfeld: modern exchange variation
D86 Gruenfeld: exchange, classical variation
D86 Gruenfeld: exchange, Larsen variation
D86 Gruenfeld: exchange, Simagin's lesser variation
D86 Gruenfeld: exchange, Simagin's improved variation
D87 Gruenfeld: exchange, Spassky variation
D87 Gruenfeld: exchange, Seville variation
D88 Gruenfeld: Spassky variation, main line, 10...cd, 11.cd
D89 Gruenfeld: Spassky variation, main line, 13.Bd3
D89 Gruenfeld: exchange, Sokolsky variation
D90 Gruenfeld: Three knights variation
D90 Gruenfeld: Schlechter variation
D90 Gruenfeld: Three knights variation
D90 Gruenfeld: Flohr variation
D91 Gruenfeld: 5.Bg5
D92 Gruenfeld: 5.Bf4
D93 Gruenfeld with Bf4 e3
D94 Gruenfeld: 5.e3
D94 Gruenfeld: Makogonov variation
D94 Gruenfeld: Opovcensky variation
D94 Gruenfeld with e3 Bd3
D94 Gruenfeld: Smyslov defence
D94 Gruenfeld: Flohr defence
D95 Gruenfeld with e3 & Qb3
D95 Gruenfeld: Botvinnik variation
D95 Gruenfeld: Pachman variation
D96 Gruenfeld: Russian variation
D97 Gruenfeld: Russian variation with e4
D97 Gruenfeld: Russian, Alekhine (Hungarian) variation
D97 Gruenfeld: Russian, Szabo (Boleslavsky) variation
D97 Gruenfeld: Russian, Levenfish variation
D97 Gruenfeld: Russian, Byrne (Simagin) variation
D97 Gruenfeld: Russian, Prins variation
D98 Gruenfeld: Russian, Smyslov variation
D98 Gruenfeld: Russian, Keres variation
D99 Gruenfeld defence: Smyslov, main line
D99 Gruenfeld defence: Smyslov, Yugoslav variation
E00 Queen's pawn game
E00 Neo-Indian (Seirawan) attack
E00 Catalan opening
E01 Catalan: closed
E02 Catalan: open, 5.Qa4
E03 Catalan: open, Alekhine variation
E03 Catalan: open, 5.Qa4 Nbd7, 6.Qxc4
E04 Catalan: open, 5.Nf3
E05 Catalan: open, classical line
E06 Catalan: closed, 5.Nf3
E07 Catalan: closed, 6...Nbd7
E07 Catalan: closed, Botvinnik variation
E08 Catalan: closed, 7.Qc2
E08 Catalan: closed, Zagoryansky variation
E08 Catalan: closed, Qc2 & b3
E08 Catalan: closed, Spassky gambit
E09 Catalan: closed, main line
E09 Catalan: closed, Sokolsky variation
E10 Queen's pawn game
E10 Blumenfeld counter-gambit
E10 Blumenfeld counter-gambit accepted
E10 Blumenfeld counter-gambit, Dus-Chotimursky variation
E10 Blumenfeld counter-gambit, Spielmann variation
E10 Dzindzikhashvili defence
E10 Doery defence
E11 Bogo-Indian defence
E11 Bogo-Indian defence, Gruenfeld variation
E11 Bogo-Indian defence, Nimzovich variation
E11 Bogo-Indian defence, Monticelli trap
E12 Queen's Indian defence
E12 Queen's Indian: Miles variation
E12 Queen's Indian: Petrosian system
E12 Queen's Indian: 4.Nc3
E12 Queen's Indian: 4.Nc3, Botvinnik variation
E13 Queen's Indian: 4.Nc3, main line
E14 Queen's Indian: 4.e3
E14 Queen's Indian: Averbakh variation
E15 Queen's Indian: 4.g3
E15 Queen's Indian: Nimzovich variation (exaggerated fianchetto)
E15 Queen's Indian: 4.g3 Bb7
E15 Queen's Indian: Rubinstein variation
E15 Queen's Indian: Buerger variation
E16 Queen's Indian: Capablanca variation
E16 Queen's Indian: Yates variation
E16 Queen's Indian: Riumin variation
E17 Queen's Indian: 5.Bg2 Be7
E17 Queen's Indian: anti-Queen's Indian system
E17 Queen's Indian: Opovcensky variation
E17 Queen's Indian: old main line, 6.O-O
E17 Queen's Indian: Euwe variation
E18 Queen's Indian: old main line, 7.Nc3
E19 Queen's Indian: old main line, 9.Qxc3
E20 Nimzo-Indian defence
E20 Nimzo-Indian: Kmoch variation
E20 Nimzo-Indian: Mikenas attack
E20 Nimzo-Indian: Romanishin-Kasparov (Steiner) system
E21 Nimzo-Indian: three knights variation
E21 Nimzo-Indian: three knights, Korchnoi variation
E21 Nimzo-Indian: three knights, Euwe variation
E22 Nimzo-Indian: Spielmann variation
E23 Nimzo-Indian: Spielmann, 4...c5, 5.dc Nc6
E23 Nimzo-Indian: Spielmann, Karlsbad variation
E23 Nimzo-Indian: Spielmann, San Remo variation
E23 Nimzo-Indian: Spielmann, Staahlberg variation
E24 Nimzo-Indian: Saemisch variation
E24 Nimzo-Indian: Saemisch, Botvinnik variation
E25 Nimzo-Indian: Saemisch variation
E25 Nimzo-Indian: Saemisch, Keres variation
E25 Nimzo-Indian: Saemisch, Romanovsky variation
E26 Nimzo-Indian: Saemisch variation
E26 Nimzo-Indian: Saemisch, O'Kelly variation
E27 Nimzo-Indian: Saemisch variation
E28 Nimzo-Indian: Saemisch variation
E29 Nimzo-Indian: Saemisch, main line
E29 Nimzo-Indian: Saemisch, Capablanca variation
E30 Nimzo-Indian: Leningrad variation
E30 Nimzo-Indian: Leningrad, ...b5 gambit
E31 Nimzo-Indian: Leningrad, main line
E32 Nimzo-Indian: classical variation
E32 Nimzo-Indian: classical, Adorjan gambit
E33 Nimzo-Indian: classical, 4...Nc6
E33 Nimzo-Indian: classical, Milner-Barry (Zurich) variation
E34 Nimzo-Indian: classical, Noa variation
E35 Nimzo-Indian: classical, Noa variation, 5.cd ed
E36 Nimzo-Indian: classical, Noa variation, 5.a3
E36 Nimzo-Indian: classical, Botvinnik variation
E36 Nimzo-Indian: classical, Noa variation, main line
E37 Nimzo-Indian: classical, Noa variation, main line, 7.Qc2
E37 Nimzo-Indian: classical, San Remo variation
E38 Nimzo-Indian: classical, 4...c5
E39 Nimzo-Indian: classical, Pirc variation
E40 Nimzo-Indian: 4.e3
E40 Nimzo-Indian: 4.e3, Taimanov variation
E41 Nimzo-Indian: 4.e3 c5
E41 Nimzo-Indian: e3, Huebner variation
E42 Nimzo-Indian: 4.e3 c5, 5.Ne2 (Rubinstein)
E43 Nimzo-Indian: Fischer variation
E44 Nimzo-Indian: Fischer variation, 5.Ne2
E45 Nimzo-Indian: 4.e3, Bronstein (Byrne) variation
E46 Nimzo-Indian: 4.e3 O-O
E46 Nimzo-Indian: Reshevsky variation
E46 Nimzo-Indian: Simagin variation
E47 Nimzo-Indian: 4.e3 O-O, 5.Bd3
E48 Nimzo-Indian: 4.e3 O-O, 5.Bd3 d5
E49 Nimzo-Indian: 4.e3, Botvinnik system
E50 Nimzo-Indian: 4.e3 e8g8, 5.Nf3, without ...d5
E51 Nimzo-Indian: 4.e3 e8g8, 5.Nf3 d7d5
E51 Nimzo-Indian: 4.e3, Ragozin variation
E52 Nimzo-Indian: 4.e3, main line with ...b6
E53 Nimzo-Indian: 4.e3, main line with ...c5
E53 Nimzo-Indian: 4.e3, Keres variation
E53 Nimzo-Indian: 4.e3, Gligoric system with 7...Nbd7
E54 Nimzo-Indian: 4.e3, Gligoric system with 7...dc
E54 Nimzo-Indian: 4.e3, Gligoric system, Smyslov variation
E55 Nimzo-Indian: 4.e3, Gligoric system, Bronstein variation
E56 Nimzo-Indian: 4.e3, main line with 7...Nc6
E57 Nimzo-Indian: 4.e3, main line with 8...dc and 9...cd
E58 Nimzo-Indian: 4.e3, main line with 8...Bxc3
E59 Nimzo-Indian: 4.e3, main line
E60 King's Indian defence
E60 King's Indian, 3.Nf3
E60 Queen's pawn: Mengarini attack
E60 King's Indian: Anti-Gruenfeld
E60 King's Indian: Danube gambit
E60 King's Indian: 3.g3
E60 King's Indian: 3.g3, counterthrust variation
E61 King's Indian defence, 3.Nc3
E61 King's Indian: Smyslov system
E62 King's Indian: fianchetto variation
E62 King's Indian: fianchetto, Larsen system
E62 King's Indian: fianchetto, Kavalek (Bronstein) variation
E62 King's Indian: fianchetto with ...Nc6
E62 King's Indian: fianchetto, Uhlmann (Szabo) variation
E62 King's Indian: fianchetto, lesser Simagin (Spassky) variation
E62 King's Indian: fianchetto, Simagin variation
E63 King's Indian: fianchetto, Panno variation
E64 King's Indian: fianchetto, Yugoslav system
E65 King's Indian: fianchetto, Yugoslav, 7.O-O
E66 King's Indian: fianchetto, Yugoslav Panno
E67 King's Indian: fianchetto with ...Nd7
E67 King's Indian: fianchetto, classical variation
E68 King's Indian: fianchetto, classical variation, 8.e4
E69 King's Indian: fianchetto, classical main line
E70 King's Indian: 4.e4
E70 King's Indian: Kramer system
E70 King's Indian: accelerated Averbakh system
E71 King's Indian: Makagonov system (5.h3)
E72 King's Indian with e4 & g3
E72 King's Indian: Pomar system
E73 King's Indian: 5.Be2
E73 King's Indian: Semi-Averbakh system
E73 King's Indian: Averbakh system
E74 King's Indian: Averbakh, 6...c5
E75 King's Indian: Averbakh, main line
E76 King's Indian: Four pawns attack
E76 King's Indian: Four pawns attack, dynamic line
E77 King's Indian: Four pawns attack, 6.Be2
E77 King's Indian: Six pawns attack
E77 King's Indian: Four pawns attack
E77 King's Indian: Four pawns attack, Florentine gambit
E78 King's Indian: Four pawns attack, with Be2 and Nf3
E79 King's Indian: Four pawns attack, main line
E80 King's Indian: Saemisch variation
E81 King's Indian: Saemisch, 5...O-O
E81 King's Indian: Saemisch, Byrne variation
E82 King's Indian: Saemisch, double fianchetto variation
E83 King's Indian: Saemisch, 6...Nc6
E83 King's Indian: Saemisch, Ruban variation
E83 King's Indian: Saemisch, Panno formation
E84 King's Indian: Saemisch, Panno main line
E85 King's Indian: Saemisch, orthodox variation
E86 King's Indian: Saemisch, orthodox, 7.Nge2 c6
E87 King's Indian: Saemisch, orthodox, 7.d5
E87 King's Indian: Saemisch, orthodox, Bronstein variation
E88 King's Indian: Saemisch, orthodox, 7.d5 c6
E89 King's Indian: Saemisch, orthodox main line
E90 King's Indian: 5.Nf3
E90 King's Indian: Larsen variation
E90 King's Indian: Zinnowitz variation
E91 King's Indian: 6.Be2
E91 King's Indian: Kazakh variation
E92 King's Indian: classical variation
E92 King's Indian: Andersson variation
E92 King's Indian: Gligoric-Taimanov system
E92 King's Indian: Petrosian system
E92 King's Indian: Petrosian system, Stein variation
E93 King's Indian: Petrosian system, main line
E93 King's Indian: Petrosian system, Keres variation
E94 King's Indian: orthodox variation
E94 King's Indian: orthodox, Donner variation
E94 King's Indian: orthodox, 7...Nbd7
E95 King's Indian: orthodox, 7...Nbd7, 8.Re1
E96 King's Indian: orthodox, 7...Nbd7, main line
E97 King's Indian: orthodox, Aronin-Taimanov variation
E97 King's Indian: orthodox, Aronin-Taimanov, bayonet attack
E98 King's Indian: orthodox, Aronin-Taimanov, 9.Ne1
E99 King's Indian: orthodox, Aronin-Taimanov, main line
E99 King's Indian: orthodox, Aronin-Taimanov, Benko attack";
		
		Reg._ecoOpeningsNotationsTemp = "1.b2b4
1.b2b4 g8h6
1.b2b4 c7c6
1.g2g3
1.g2g3 h7h5
1.g2g3 e7e5 g1f3
1.g2g4
1.g2g4 d7d5 f1g2 c7c6 g4g5
1.g2g4 d7d5 f1g2 c8g4 c2c4
1.g2g4 d7d5 f1g2 c8g4 c2c4 d5d4
1.h2h3
1.h2h3 e7e5 a2a3
1.g1h3
1.g1h3 d7d5 g2g3 e7e5 f2f4 c8h3 f1h3 e5f4
1.b1c3
1.b1c3 e7e5
1.b1c3 e7e5 a2a3
1.b1c3 c7c5 d2d4 c5d4 d1d4 b8c6 d4h4
1.a2a3
1.a2a4
1.a2a4 e7e5 h2h4
1.c2c3
1.d2d3
1.d2d3 e7e5
1.d2d3 e7e5 b1d2
1.d2d3 c7c5 b1c3 b8c6 g2g3
1.e2e3
1.e2e3 e7e5 c2c4 d7d6 b1c3 b8c6 b2b3 g8f6
1.f2f3
1.f2f3 e7e5 e1f2
1.h2h4
1.b1a3
1.b2b3
1.b2b3 e7e5
1.b2b3 g8f6
1.b2b3 d7d5
1.b2b3 c7c5
1.b2b3 f7f5
1.b2b3 b7b5
1.b2b3 b7b6
1.f2f4
1.f2f4 e7e5
1.f2f4 e7e5 f4e5 d7d6 e5d6 f8d6 g1f3 g7g5
1.f2f4 e7e5 f4e5 d7d6 e5d6 f8d6 g1f3 g8h6 d2d4
1.f2f4 f7f5 e2e4 f5e4 b1c3 g8f6 g2g4
1.f2f4 g7g5
1.f2f4 d7d5
1.f2f4 d7d5 c2c4
1.f2f4 d7d5 e2e4
1.f2f4 d7d5 g1f3 g8f6 e2e3 c7c5
1.g1f3
1.g1f3 f7f5
1.g1f3 f7f5 e2e4
1.g1f3 f7f5 d2d3 g8f6 e2e4
1.g1f3 d7d6
1.g1f3 d7d6 e2e4 c8g4
1.g1f3 g7g5
1.g1f3 g8f6
1.g1f3 g8f6 g2g3 b7b5
1.g1f3 g8f6 g2g3 g7g6
1.g1f3 g8f6 g2g3 g7g6 b2b4
1.g1f3 d7d5
1.g1f3 d7d5 d2d3
1.g1f3 d7d5 b2b4
1.g1f3 d7d5 e2e4
1.g1f3 d7d5 b2b3
1.g1f3 d7d5 g2g3
1.g1f3 d7d5 g2g3 g8f6 f1g2 c7c6 e1g1 c8g4
1.g1f3 d7d5 g2g3 c8g4 f1g2 b8d7
1.g1f3 d7d5 g2g3 g7g6
1.g1f3 d7d5 g2g3 g7g6 f1g2 f8g7 e1g1 e7e5 d2d3 g8e7
1.g1f3 d7d5 g2g3 c7c5
1.g1f3 d7d5 g2g3 c7c5 f1g2
1.g1f3 d7d5 g2g3 c7c5 f1g2 b8c6 e1g1 e7e6 d2d3 g8f6 b1d2 f8e7 e2e4 e8g8 f1e1
1.g1f3 d7d5 c2c4
1.g1f3 d7d5 c2c4 d5d4
1.g1f3 d7d5 c2c4 d5c4
1.g1f3 d7d5 c2c4 d5c4 e2e3 c8e6
1.c2c4
1.c2c4 g7g6
1.c2c4 g7g6 e2e4 e7e5
1.c2c4 b7b5
1.c2c4 f7f5
1.c2c4 c7c6
1.c2c4 c7c6 g1f3 d7d5 b2b3
1.c2c4 c7c6 g1f3 d7d5 b2b3 g8f6 g2g3 c8g4
1.c2c4 c7c6 g1f3 d7d5 b2b3 g8f6 g2g3 c8f5
1.c2c4 c7c6 g1f3 d7d5 b2b3 g8f6 c1b2
1.c2c4 c7c6 g1f3 d7d5 b2b3 g8f6 c1b2 g7g6
1.c2c4 c7c6 g1f3 d7d5 b2b3 g8f6 c1b2 c8f5
1.c2c4 c7c6 g1f3 d7d5 b2b3 g8f6 c1b2 c8g4
1.c2c4 c7c6 g1f3 d7d5 b2b3 c8g4
1.c2c4 e7e6
1.c2c4 e7e6 g1f3 g8f6 g2g3 a7a6 f1g2 b7b5
1.c2c4 e7e6 g1f3 d7d5
1.c2c4 e7e6 g1f3 d7d5 b2b3 g8f6 c1b2 c7c5 e2e3
1.c2c4 e7e6 g1f3 d7d5 g2g3
1.c2c4 e7e6 g1f3 d7d5 g2g3 c7c6
1.c2c4 e7e6 g1f3 d7d5 g2g3 g8f6
1.c2c4 e7e6 g1f3 d7d5 g2g3 g8f6 f1g2 d5c4
1.c2c4 e7e6 g1f3 d7d5 g2g3 g8f6 f1g2 f8e7 e1g1
1.c2c4 e7e6 g1f3 d7d5 g2g3 g8f6 f1g2 f8e7 e1g1 c7c5 c4d5 f6d5 b1c3 b8c6
1.c2c4 g8f6
1.c2c4 g8f6 b2b4
1.c2c4 g8f6 g1f3
1.c2c4 g8f6 b1c3
1.c2c4 g8f6 b1c3 d7d5
1.c2c4 g8f6 b1c3 d7d5 c4d5 f6d5 g2g3 g7g6 f1g2 d5c3
1.c2c4 g8f6 b1c3 d7d5 c4d5 f6d5 g2g3 g7g6 f1g2 d5b6
1.c2c4 g8f6 b1c3 d7d5 c4d5 f6d5 g1f3
1.c2c4 g8f6 b1c3 d7d5 c4d5 f6d5 g1f3 g7g6 g2g3 f8g7 f1g2 e7e5
1.c2c4 g8f6 b1c3 e7e6
1.c2c4 g8f6 b1c3 e7e6 g1f3 b7b6
1.c2c4 g8f6 b1c3 e7e6 g1f3 b7b6 e2e4 c8b7 f1d3
1.c2c4 g8f6 b1c3 e7e6 g1f3 f8b4
1.c2c4 g8f6 b1c3 e7e6 e2e4
1.c2c4 g8f6 b1c3 e7e6 e2e4 d7d5 e4e5
1.c2c4 g8f6 b1c3 e7e6 e2e4 b8c6
1.c2c4 g8f6 b1c3 e7e6 e2e4 c7c5
1.c2c4 e7e5
1.c2c4 e7e5 g1f3
1.c2c4 e7e5 g1f3 e5e4
1.c2c4 e7e5 b1c3
1.c2c4 e7e5 b1c3 d7d6 g2g3 c8e6 f1g2 b8c6
1.c2c4 e7e5 b1c3 d7d6 g2g3 c7c6
1.c2c4 e7e5 b1c3 d7d6 g1f3
1.c2c4 e7e5 b1c3 d7d6 g1f3 c8g4
1.c2c4 e7e5 b1c3 f8b4
1.c2c4 e7e5 b1c3 g8f6
1.c2c4 e7e5 b1c3 g8f6 g1f3 e5e4 f3g5 b7b5
1.c2c4 e7e5 b1c3 g8f6 g2g3
1.c2c4 e7e5 b1c3 g8f6 g2g3 d7d5
1.c2c4 e7e5 b1c3 g8f6 g2g3 f8b4
1.c2c4 e7e5 b1c3 g8f6 g2g3 c7c6
1.c2c4 e7e5 b1c3 g8f6 g2g3 g7g6
1.c2c4 e7e5 b1c3 b8c6
1.c2c4 e7e5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7
1.c2c4 e7e5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 e2e3 d7d6 g1e2 g8h6
1.c2c4 e7e5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 e2e3 d7d6 g1e2 c8e6
1.c2c4 e7e5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 a1b1
1.c2c4 e7e5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 a1b1 g8h6
1.c2c4 e7e5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 d2d3
1.c2c4 e7e5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 d2d3 d7d6
1.c2c4 e7e5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 d2d3 d7d6 e2e4
1.c2c4 e7e5 b1c3 b8c6 g1f3
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6 d2d4 e5d4 f3d4 f8b4 c1g5 h7h6 g5h4 b4c3 b2c3 c6e5
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6 d2d4 e5e4
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6 e2e4
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6 a2a3
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6 d2d3
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6 e2e3
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6 e2e3 f8b4 d1c2 e8g8 c3d5 f8e8 c2f5
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6 e2e3 f8b4 d1c2 b4c3
1.c2c4 e7e5 b1c3 b8c6 g1f3 g8f6 g2g3
1.c2c4 c7c5
1.c2c4 c7c5 g1f3 g8f6 g2g3 b7b6 f1g2 c8b7 e1g1 e7e6 b1c3 f8e7
1.c2c4 c7c5 g1f3 g8f6 g2g3 b7b6 f1g2 c8b7 e1g1 e7e6 b1c3 f8e7 d2d4 c5d4 d1d4 d7d6 f1d1 a7a6 b2b3 b8d7
1.c2c4 c7c5 g1f3 g8f6 d2d4
1.c2c4 c7c5 g1f3 g8f6 d2d4 c5d4 f3d4 e7e6
1.c2c4 c7c5 g1f3 g8f6 d2d4 c5d4 f3d4 e7e6 b1c3 b8c6
1.c2c4 c7c5 g1f3 g8f6 d2d4 c5d4 f3d4 e7e6 b1c3 b8c6 g2g3 d8b6
1.c2c4 c7c5 b1c3
1.c2c4 c7c5 b1c3 g8f6 g1f3 d7d5 c4d5 f6d5
1.c2c4 c7c5 b1c3 g8f6 g2g3
1.c2c4 c7c5 b1c3 g8f6 g2g3 d7d5 c4d5 f6d5 f1g2 d5c7
1.c2c4 c7c5 b1c3 b8c6
1.c2c4 c7c5 b1c3 b8c6 g1f3 g8f6
1.c2c4 c7c5 b1c3 b8c6 g2g3
1.c2c4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7
1.c2c4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 e2e3 e7e5
1.c2c4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 e2e4
1.c2c4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 g1f3
1.c2c4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 g1f3 e7e5
1.c2c4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 g1f3 g8f6
1.c2c4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 g1f3 g8f6 e1g1 e8g8 d2d3
1.c2c4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 g1f3 g8f6 e1g1 e8g8 b2b3
1.c2c4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 g1f3 g8f6 e1g1 e8g8 d2d4
1.d2d4
1.d2d4 b8c6
1.d2d4 e7e5
1.d2d4 e7e5 d4e5 b8c6 g1f3 d8e7 d1d5 f7f6 e5f6 g8f6
1.d2d4 b7b6
1.d2d4 b7b5
1.d2d4 e7e6
1.d2d4 e7e6 c2c4 b7b6
1.d2d4 e7e6 c2c4 f8b4
1.d2d4 g7g6
1.d2d4 g7g6 c2c4 f8g7 b1c3 c7c5 d4d5 g7c3 b2c3 f7f5
1.d2d4 d7d6
1.d2d4 d7d6 g1f3 c8g4
1.d2d4 d7d6 c2c4
1.d2d4 d7d6 c2c4 g7g6 b1c3 f8g7
1.e2e4 g7g6 d2d4 f8g7 g1f3 d7d6 c2c4 c8g4
1.d2d4 d7d6 c2c4 g7g6 b1c3 f8g7 e2e4
1.d2d4 d7d6 c2c4 g7g6 b1c3 f8g7 e2e4 c7c5 g1f3 d8a5
1.d2d4 d7d6 c2c4 g7g6 b1c3 f8g7 e2e4 f7f5
1.d2d4 d7d6 c2c4 g7g6 b1c3 f8g7 e2e4 b8c6
1.d2d4 c7c5
1.d2d4 c7c5 d4d5 e7e6 e2e4
1.d2d4 c7c5 d4d5 f7f5
1.d2d4 c7c5 d4d5 g8f6
1.d2d4 c7c5 d4d5 g8f6 b1c3 d8a5
1.d2d4 c7c5 d4d5 g8f6 g1f3
1.d2d4 c7c5 d4d5 g8f6 g1f3 c5c4
1.d2d4 c7c5 d4d5 d7d6
1.d2d4 c7c5 d4d5 d7d6 b1c3 g7g6
1.d2d4 c7c5 d4d5 e7e5
1.d2d4 c7c5 d4d5 e7e5 e2e4 d7d6
1.d2d4 g8f6
1.d2d4 g8f6 g2g4
1.d2d4 g8f6 f2f4
1.d2d4 g8f6 f2f3
1.d2d4 g8f6 f2f3 d7d5 e2e4
1.d2d4 g8f6 f2f3 d7d5 g2g4
1.d2d4 g8f6 c1g5
1.d2d4 g8f6 g1f3
1.d2d4 g8f6 g1f3 e7e6 c1g5
1.d2d4 g8f6 g1f3 e7e6 c1g5 c7c5 e2e4
1.d2d4 g8f6 g1f3 e7e6 e2e3
1.d2d4 g8f6 g1f3 f6e4
1.d2d4 g8f6 g1f3 b7b6
1.d2d4 g8f6 g1f3 b7b6 g2g3 c8b7 f1g2 c7c5
1.d2d4 g8f6 g1f3 b7b6 g2g3 c8b7 f1g2 c7c5 c2c4 c5d4 d1d4
1.d2d4 g8f6 g1f3 g7g6
1.d2d4 g8f6 g1f3 g7g6 c1g5
1.d2d4 g8f6 g1f3 g7g6 c1f4
1.d2d4 g8f6 g1f3 g7g6 g2g3
1.d2d4 g8f6 c2c4
1.d2d4 g8f6 c2c4 b8c6
1.d2d4 g8f6 c2c4 b7b6
1.d2d4 g8f6 c2c4 e7e5
1.d2d4 g8f6 c2c4 e7e5 d4e5 f6e4
1.d2d4 g8f6 c2c4 e7e5 d4e5 f6e4 d1c2
1.d2d4 g8f6 c2c4 e7e5 d4e5 f6g4
1.d2d4 g8f6 c2c4 e7e5 d4e5 f6g4 g1f3
1.d2d4 g8f6 c2c4 e7e5 d4e5 f6g4 c1f4
1.d2d4 g8f6 c2c4 e7e5 d4e5 f6g4 e2e4
1.d2d4 g8f6 c2c4 e7e5 d4e5 f6g4 e2e4 g4e5 f2f4 e5c6
1.d2d4 g8f6 c2c4 e7e5 d4e5 f6g4 e2e4 d7d6
1.d2d4 g8f6 c2c4 d7d6
1.d2d4 g8f6 c2c4 d7d6 b1c3 c8f5
1.d2d4 g8f6 c2c4 d7d6 b1c3 e7e5
1.d2d4 g8f6 c2c4 d7d6 b1c3 e7e5 e2e3 b8d7 f1d3
1.d2d4 g8f6 c2c4 d7d6 b1c3 e7e5 g1f3
1.d2d4 g8f6 c2c4 d7d6 b1c3 e7e5 g1f3 b8d7 e2e4
1.d2d4 g8f6 c2c4 c7c5
1.d2d4 g8f6 c2c4 c7c5 d4d5 d7d6
1.d2d4 g8f6 c2c4 c7c5 d4d5 f6e4
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e5
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e5 b1c3 d7d6 e2e4 g7g6
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6 b1c3
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6 b1c3 a6b5 e2e4 b5b4 c3b5 d7d6 f1c4
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6 b5a6
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6 b5a6 c8a6 b1c3 d7d6 g1f3 g7g6 f3d2
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6 b5a6 c8a6 b1c3 d7d6 g1f3 g7g6 g2g3
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6 b5a6 c8a6 b1c3 d7d6 e2e4
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6 b5a6 c8a6 b1c3 d7d6 e2e4 a6f1 e1f1 g7g6 g1e2
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6 b5a6 c8a6 b1c3 d7d6 e2e4 a6f1 e1f1 g7g6 g2g3
1.d2d4 g8f6 c2c4 c7c5 d4d5 b7b5 c4b5 a7a6 b5a6 c8a6 b1c3 d7d6 e2e4 a6f1 e1f1 g7g6 g2g3 f8g7 f1g2 e8g8 g1f3
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 g1f3 g7g6
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 g1f3 g7g6 c1g5
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 g1f3 g7g6 f3d2
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 g1f3 g7g6 g2g3
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 g1f3 g7g6 g2g3 f8g7 f1g2 e8g8
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 g1f3 g7g6 g2g3 f8g7 f1g2 e8g8 e1g1 b8d7
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 g1f3 g7g6 g2g3 f8g7 f1g2 e8g8 e1g1 b8d7 f3d2 a7a6 a2a4 f8e8
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 f2f4
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 f2f4 f8g7 e4e5
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 f2f4 f8g7 f1b5
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 f2f4 f8g7 g1f3 e8g8
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 f2f4 f8g7 g1f3 e8g8 f1e2 f8e8
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 f1e2
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 c1g5
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 f1e2 e8g8
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 f1e2 e8g8 e1g1
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 f1e2 e8g8 e1g1 a7a6 a2a4
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 f1e2 e8g8 e1g1 a7a6 a2a4 c8g4
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 f1e2 e8g8 e1g1 f8e8
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 f1e2 e8g8 e1g1 f8e8 f3d2
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 f1e2 e8g8 e1g1 f8e8 f3d2 b8a6
1.d2d4 g8f6 c2c4 c7c5 d4d5 e7e6 b1c3 e6d5 c4d5 d7d6 e2e4 g7g6 g1f3 f8g7 f1e2 e8g8 e1g1 f8e8 f3d2 b8a6 f2f3
1.d2d4 f7f5
1.d2d4 f7f5 b1c3 g8f6 g2g4
1.d2d4 f7f5 d1d3
1.d2d4 f7f5 d1d3 e7e6 g2g4
1.d2d4 f7f5 h2h3
1.d2d4 f7f5 g2g4
1.d2d4 f7f5 c1g5
1.d2d4 f7f5 g2g3
1.d2d4 f7f5 g2g3 g8f6 f1g2 e7e6 g1h3
1.d2d4 f7f5 g2g3 g8f6 f1g2 g7g6
1.d2d4 f7f5 g2g3 g7g6 f1g2 f8g7 g1f3 c7c6 e1g1 g8h6
1.d2d4 f7f5 g2g3 g7g6 f1g2 f8g7 g1h3
1.d2d4 f7f5 e2e4
1.d2d4 f7f5 e2e4 d7d6
1.d2d4 f7f5 e2e4 f5e4
1.d2d4 f7f5 e2e4 f5e4 b1c3 g8f6 g2g4
1.d2d4 f7f5 e2e4 f5e4 b1c3 g8f6 c1g5
1.d2d4 f7f5 e2e4 f5e4 b1c3 g8f6 c1g5 g7g6 h2h4
1.d2d4 f7f5 e2e4 f5e4 b1c3 g8f6 c1g5 g7g6 f2f3
1.d2d4 f7f5 e2e4 f5e4 b1c3 g8f6 c1g5 c7c6
1.d2d4 f7f5 e2e4 f5e4 b1c3 g8f6 c1g5 b7b6
1.d2d4 f7f5 c2c4
1.d2d4 f7f5 c2c4 g7g6 b1c3 g8h6
1.d2d4 f7f5 c2c4 e7e6
1.d2d4 f7f5 c2c4 e7e6 b1c3
1.d2d4 f7f5 c2c4 e7e6 e2e4
1.d2d4 f7f5 c2c4 g8f6
1.d2d4 f7f5 c2c4 g8f6 b1c3
1.d2d4 f7f5 c2c4 g8f6 g2g3
1.d2d4 f7f5 c2c4 g8f6 g2g3 d7d6 f1g2 c7c6 b1c3 d8c7
1.d2d4 f7f5 c2c4 g8f6 g2g3 g7g6
1.d2d4 f7f5 c2c4 g8f6 g2g3 g7g6 f1g2 f8g7 g1f3
1.d2d4 f7f5 c2c4 g8f6 g2g3 g7g6 f1g2 f8g7 g1f3 e8g8 e1g1 d7d6 b1c3 c7c6
1.d2d4 f7f5 c2c4 g8f6 g2g3 g7g6 f1g2 f8g7 g1f3 e8g8 e1g1 d7d6 b1c3 b8c6
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8b4
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8b4 c1d2 b4e7
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 f6e4
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d5
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d5 b1c3
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d5 b2b3
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d5 b2b3 c7c6 c1a3
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d5 b1c3 c7c6
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d5 b1c3 c7c6 d1c2 d8e8 c1g5
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d6
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d6 b1c3 d8e8
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d6 b1c3 d8e8 f1e1
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d6 b1c3 d8e8 d1c2
1.d2d4 f7f5 c2c4 g8f6 g2g3 e7e6 f1g2 f8e7 g1f3 e8g8 e1g1 d7d6 b1c3 d8e8 b2b3
1.e2e4
1.e2e4 g8h6 d2d4 g7g6 c2c4 f7f6
1.e2e4 a7a5
1.e2e4 b8a6
1.e2e4 f7f5
1.e2e4 f7f6
1.e2e4 f7f6 d2d4 e8f7
1.e2e4 h7h6
1.e2e4 g7g5
1.e2e4 a7a6
1.e2e4 b7b6
1.e2e4 b7b6 d2d4 c8a6
1.e2e4 b8c6
1.e2e4 b8c6 b2b4 c6b4 c2c3 b4c6 d2d4
1.e2e4 b8c6 g1f3
1.e2e4 b8c6 g1f3 f7f5
1.e2e4 b8c6 d2d4
1.e2e4 b8c6 d2d4 d7d5 e4d5 d8d5 b1c3
1.e2e4 b8c6 d2d4 d7d5 b1c3
1.e2e4 b8c6 d2d4 f7f6
1.e2e4 d7d5
1.e2e4 d7d5 e4d5 d8d5 b1c3 d5a5 d2d4 g8f6 g1f3 c8g4 h2h3
1.e2e4 d7d5 e4d5 d8d5 b1c3 d5a5 d2d4 g8f6 g1f3 c8f5
1.e2e4 d7d5 e4d5 d8d5 b1c3 d5a5 d2d4 g8f6 g1f3 c8f5 f3e5 c7c6 g2g4
1.e2e4 d7d5 e4d5 d8d5 b1c3 d5a5 d2d4 e7e5
1.e2e4 d7d5 e4d5 d8d5 b1c3 d5a5 d2d4 e7e5 d4e5 f8b4 c1d2 b8c6 g1f3
1.e2e4 d7d5 e4d5 d8d5 b1c3 d5a5 d2d4 e7e5 g1f3
1.e2e4 d7d5 e4d5 d8d5 b1c3 d5a5 d2d4 e7e5 g1f3 c8g4
1.e2e4 d7d5 e4d5 d8d5 b1c3 d5a5 b2b4
1.e2e4 d7d5 e4d5 d8d5 b1c3 d5d6
1.e2e4 d7d5 e4d5 g8f6
1.e2e4 d7d5 e4d5 g8f6 c2c4 e7e6
1.e2e4 d7d5 e4d5 g8f6 c2c4 c7c6
1.e2e4 d7d5 e4d5 g8f6 d2d4
1.e2e4 d7d5 e4d5 g8f6 d2d4 f6d5
1.e2e4 d7d5 e4d5 g8f6 d2d4 f6d5 c2c4 d5b4
1.e2e4 d7d5 e4d5 g8f6 d2d4 g7g6
1.e2e4 g8f6
1.e2e4 g8f6 b1c3 d7d5
1.e2e4 g8f6 b1c3 d7d5 e4e5 f6d7 e5e6
1.e2e4 g8f6 d2d3
1.e2e4 g8f6 f1c4
1.e2e4 g8f6 e4e5 f6e4
1.e2e4 g8f6 e4e5 f6g8
1.e2e4 g8f6 e4e5 f6d5
1.e2e4 g8f6 e4e5 f6d5 f1c4 d5b6 c4b3 c7c5 d2d3
1.e2e4 g8f6 e4e5 f6d5 b1c3
1.e2e4 g8f6 e4e5 f6d5 b2b3
1.e2e4 g8f6 e4e5 f6d5 c2c4
1.e2e4 g8f6 e4e5 f6d5 c2c4 d5b6 b2b3
1.e2e4 g8f6 e4e5 f6d5 c2c4 d5b6 c4c5
1.e2e4 g8f6 e4e5 f6d5 c2c4 d5b6 c4c5 b6d5 f1c4 e7e6 b1c3 d7d6
1.e2e4 g8f6 e4e5 f6d5 d2d4
1.e2e4 g8f6 e4e5 f6d5 d2d4 b7b5
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 f1c4
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 e5d6
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 e5d6 c7d6 g1f3 g7g6 f1e2 f8g7 e1g1 e8g8 h2h3 b8c6 b1c3 c8f5 c1f4
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 f2f4
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 f2f4 d6e5 f4e5 c8f5 b1c3 e7e6 g1f3 f8e7 f1e2 e8g8 e1g1 f7f6
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 f2f4 d6e5 f4e5 b8c6
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 f2f4 d6e5 f4e5 b8c6 g1f3 c8g4 e5e6 f7e6 c4c5
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 f2f4 d6e5 f4e5 b8c6 c1e3
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 f2f4 d6e5 f4e5 b8c6 c1e3 c8f5 b1c3 e7e6 g1f3 d8d7 f1e2 e8c8 e1g1 f8e7
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 f2f4 g7g5
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 f2f4 g7g6
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 c2c4 d5b6 f2f4 c8f5
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3 d6e5
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3 d5b6
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3 g7g6
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3 g7g6 f1c4 d5b6 c4b3 f8g7 a2a4
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3 c8g4
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3 c8g4 f1e2 c7c6
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3 c8g4 h2h3
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3 c8g4 c2c4
1.e2e4 g8f6 e4e5 f6d5 d2d4 d7d6 g1f3 c8g4 c2c4 d5b6 d4d5
1.e2e4 g7g6
1.e2e4 g7g6 d2d4 g8f6 e4e5 f6h5 g2g4 h5g7
1.e2e4 g7g6 d2d4 f8g7
1.e2e4 g7g6 d2d4 f8g7 f2f4
1.e2e4 g7g6 d2d4 f8g7 b1c3
1.e2e4 g7g6 d2d4 f8g7 b1c3 c7c6 f2f4 d7d5 e4e5 h7h5
1.e2e4 g7g6 d2d4 f8g7 b1c3 d7d6
1.e2e4 g7g6 d2d4 f8g7 b1c3 d7d6 g1f3
1.e2e4 g7g6 d2d4 f8g7 b1c3 d7d6 g1f3 c7c6
1.e2e4 g7g6 d2d4 f8g7 b1c3 d7d6 f2f4
1.e2e4 d7d6 d2d4 g8f6 b1c3
1.e2e4 d7d6 d2d4 g8f6 b1c3 c7c6
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 c1e3 c7c6 d1d2
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 g2g3
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f1c4
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 c1g5
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f1e2
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f1e2 f8g7 g2g4
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f1e2 f8g7 h2h4
1.e2e4 g7g6 d2d4 f8g7 g1f3 d7d6 c2c3
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 g1f3
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 g1f3 f8g7
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 g1f3 f8g7 h2h3
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 g1f3 f8g7 f1e2
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f2f4
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f2f4 f8g7 g1f3 e8g8
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f2f4 f8g7 g1f3 e8g8 e4e5
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f2f4 f8g7 g1f3 e8g8 c1e3
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f2f4 f8g7 g1f3 e8g8 f1d3
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f2f4 f8g7 g1f3 c7c5
1.e2e4 d7d6 d2d4 g8f6 b1c3 g7g6 f2f4 f8g7 f1c4
1.e2e4 c7c6
1.e2e4 c7c6 f1c4
1.e2e4 c7c6 c2c4
1.e2e4 c7c6 c2c4 d7d5
1.e2e4 c7c6 d2d3
1.e2e4 c7c6 b1c3
1.e2e4 c7c6 b1c3 d7d5 d1f3
1.e2e4 c7c6 b1c3 d7d5 g1f3
1.e2e4 c7c6 b1c3 d7d5 g1f3 c8g4
1.e2e4 c7c6 d2d4
1.e2e4 c7c6 d2d4 b8a6 b1c3 a6c7
1.e2e4 c7c6 d2d4 g8f6
1.e2e4 c7c6 d2d4 d7d5
1.e2e4 c7c6 d2d4 d7d5 f2f3
1.e2e4 c7c6 d2d4 d7d5 b1d2
1.e2e4 c7c6 d2d4 d7d5 b1d2 d8b6
1.e2e4 c7c6 d2d4 d7d5 e4e5
1.e2e4 c7c6 d2d4 d7d5 e4e5 c8f5 c2c3 e7e6 f1e2
1.e2e4 c7c6 d2d4 d7d5 e4d5
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 f1d3 b8c6 c2c3 g8f6 c1f4
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 c2c4
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 c2c4 g8f6 c4c5
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 c2c4 g8f6 b1c3
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 c2c4 g8f6 b1c3 b8c6 c1g5 d5c4 d4d5 c6a5
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 c2c4 g8f6 b1c3 b8c6 c1g5 e7e6
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 c2c4 g8f6 b1c3 b8c6 c1g5 d8a5
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 c2c4 g8f6 b1c3 b8c6 c1g5 d8b6
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 c2c4 g8f6 b1c3 e7e6
1.e2e4 c7c6 d2d4 d7d5 e4d5 c6d5 c2c4 g8f6 b1c3 g7g6
1.e2e4 c7c6 d2d4 d7d5 b1c3
1.e2e4 c7c6 d2d4 d7d5 b1c3 b7b5
1.e2e4 c7c6 d2d4 d7d5 b1c3 g7g6
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 f2f3
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 g8f6 f1d3
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 g8f6 e4f6 e7f6
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 g8f6 e4f6 e7f6 f1c4
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 g8f6 e4f6 g7f6
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 b8d7
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 c8f5
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 c8f5 e4g3 f5g6 g1h3
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 c8f5 e4g3 f5g6 f2f4
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 c8f5 e4g3 f5g6 h2h4
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 c8f5 e4g3 f5g6 h2h4 h7h6 g1f3 b8d7
1.e2e4 c7c6 d2d4 d7d5 b1c3 d5e4 c3e4 c8f5 e4g3 f5g6 h2h4 h7h6 g1f3 b8d7 h4h5
1.e2e4 c7c5
1.e2e4 c7c5 c2c4 d7d6 b1c3 b8c6 g2g3 h7h5
1.e2e4 c7c5 g2g3
1.e2e4 c7c5 b2b4
1.e2e4 c7c5 b2b4 c5b4 c2c4
1.e2e4 c7c5 b2b4 c5b4 a2a3
1.e2e4 c7c5 b2b4 c5b4 a2a3 d7d5 e4d5 d8d5 c1b2
1.e2e4 c7c5 b2b4 c5b4 a2a3 b4a3
1.e2e4 c7c5 g1e2
1.e2e4 c7c5 f2f4
1.e2e4 c7c5 d2d4
1.e2e4 c7c5 d2d4 c5d4 g1f3 e7e5 c2c3
1.e2e4 c7c5 d2d4 c5d4 c2c3
1.e2e4 c7c5 d2d4 c5d4 c2c3 d4c3 b1c3 b8c6 g1f3 d7d6 f1c4 e7e6 e1g1 a7a6 d1e2 b7b5 c4b3 a8a7
1.e2e4 c7c5 c2c3
1.e2e4 c7c5 c2c3 g8f6 e4e5 f6d5 g1f3 b8c6 b1a3
1.e2e4 c7c5 b1c3
1.e2e4 c7c5 b1c3 e7e6 g2g3 d7d5
1.e2e4 c7c5 b1c3 b8c6
1.e2e4 c7c5 b1c3 b8c6 g1e2
1.e2e4 c7c5 b1c3 b8c6 f2f4
1.e2e4 c7c5 b1c3 b8c6 f2f4 g7g6 g1f3 f8g7 f1c4 e7e6 f4f5
1.e2e4 c7c5 b1c3 b8c6 g2g3
1.e2e4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 d2d3 e7e6 c1e3 c6d4 c3e2
1.e2e4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 d2d3 d7d6
1.e2e4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 d2d3 d7d6 g1e2 e7e5
1.e2e4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 d2d3 d7d6 f2f4
1.e2e4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 d2d3 d7d6 f2f4 e7e5
1.e2e4 c7c5 b1c3 b8c6 g2g3 g7g6 f1g2 f8g7 d2d3 d7d6 c1e3
1.e2e4 c7c5 g1f3
1.e2e4 c7c5 g1f3 d8a5
1.e2e4 c7c5 g1f3 d8c7
1.e2e4 c7c5 g1f3 b7b6
1.e2e4 c7c5 g1f3 g7g6
1.e2e4 c7c5 g1f3 g7g6 c2c4 f8h6
1.e2e4 c7c5 g1f3 a7a6
1.e2e4 c7c5 g1f3 g8f6
1.e2e4 c7c5 g1f3 g8f6 e4e5 f6d5 b1c3 e7e6 c3d5 e6d5 d2d4 b8c6
1.e2e4 c7c5 g1f3 b8c6
1.e2e4 c7c5 g1f3 b8c6 f1b5
1.e2e4 c7c5 g1f3 b8c6 f1b5 g7g6
1.e2e4 c7c5 g1f3 b8c6 f1b5 g7g6 e1g1 f8g7 f1e1 e7e5 b2b4
1.e2e4 c7c5 g1f3 b8c6 d2d4
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 d8c7
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 d7d5
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 e7e5
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 e7e5 d4b5 d7d6
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g8f6
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e5
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e5 d4b5 d7d6 c1g5 a7a6 b5a3 c8e6
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e5 d4b5 d7d6 c1g5 a7a6 b5a3 b7b5
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e5 d4b5 d7d6 c1g5 a7a6 b5a3 b7b5 g5f6 g7f6 c3d5 f6f5
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g7g6 d4c6
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g7g6 b1c3
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g7g6 b1c3 f8g7 c1e3 g8f6 f1c4
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g7g6 c2c4
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g7g6 c2c4 g8f6 b1c3 c6d4 d1d4 d7d6
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g7g6 c2c4 f8g7
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g7g6 c2c4 f8g7 d4c2 d7d6 f1e2 g8h6
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g7g6 c2c4 f8g7 c1e3
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g7g6 c2c4 f8g7 c1e3 g8f6 b1c3 f6g4
1.e2e4 c7c5 g1f3 e7e6
1.e2e4 c7c5 g1f3 e7e6 d2d4 d7d5
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 g8f6
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 g8f6 b1c3 f8b4
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 g8f6 b1c3 f8b4 f1d3 e6e5
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 g8f6 b1c3 f8b4 e4e5
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 a7a6
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 a7a6 c2c4
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 a7a6 c2c4 g8f6 b1c3 f8b4 f1d3 b8c6 d3c2
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 a7a6 f1d3
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 a7a6 f1d3 g8f6 e1g1 d7d6 c2c4 g7g6
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 a7a6 f1d3 f8c5
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 a7a6 f1d3 g7g6
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 a7a6 b1c3
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6 d4b5
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6 d4b5 d7d6 c2c4 g8f6 b1c3 a7a6 b5a3 f8e7 f1e2 e8g8 e1g1 b7b6
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6 d4b5 d7d6 c2c4 g8f6 b1c3 a7a6 b5a3 d6d5
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6 b1c3
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6 b1c3 g8f6 d4b5 f8b4 b5d6
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6 b1c3 a7a6
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6 b1c3 d8c7
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6 b1c3 d8c7 c1e3
1.e2e4 c7c5 g1f3 e7e6 d2d4 c5d4 f3d4 b8c6 b1c3 d8c7 c1e3 a7a6 f1e2
1.e2e4 c7c5 g1f3 d7d6
1.e2e4 c7c5 g1f3 d7d6 b2b4
1.e2e4 c7c5 g1f3 d7d6 f1b5
1.e2e4 c7c5 g1f3 d7d6 f1b5 c8d7
1.e2e4 c7c5 g1f3 d7d6 f1b5 c8d7 b5d7 d8d7 e1g1 b8c6 c2c3 g8f6 d2d4
1.e2e4 c7c5 g1f3 d7d6 f1b5 c8d7 b5d7 d8d7 c2c4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 d1d4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 d1d4 b8c6 f1b5 d8d7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 f2f3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 f2f3 e7e5 f1b5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e5 f1b5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 f1c4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 f1c4 g7g6 d4c6 b7c6 e4e5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 f1c4 d8b6
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g8f6 b1c3 d7d6 f1e2
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g8f6 b1c3 d7d6 f1e2 e7e5
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g8f6 b1c3 d7d6 f1e2 e7e5 d4c6
1.e2e4 c7c5 g1f3 b8c6 d2d4 c5d4 f3d4 g8f6 b1c3 d7d6 f1e2 e7e5 d4b3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 g7g6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 c8d7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 c8d7 d1d2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d4b3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 f1b5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d4c6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2 f8e7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2 f8e7 e1c1 e8g8 f2f4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2 f8e7 e1c1 e8g8 f2f4 e6e5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2 f8e7 e1c1 e8g8 f2f4 c6d4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2 f8e7 e1c1 e8g8 f2f4 c6d4 d2d4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2 a7a6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2 a7a6 e1c1 c8d7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2 a7a6 e1c1 c8d7 f2f4 f8e7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 b8c6 c1g5 e7e6 d1d2 a7a6 e1c1 c8d7 f2f4 f8e7 d4f3 b7b5 g5f6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 f2f4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 f2f4 b8d7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 d1d2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 d1d2 e8g8 e1c1
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 d4b3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 e1g1
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 e1g1 e8g8 f2f4 d8b6 e4e5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 e1g1 e8g8 d1d2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 e1g1 e8g8 d4b3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 e1g1 e8g8 d4b3 c8e6 f2f4 c6a5 f4f5 e6c4 b3a5 c4e2 d1e2 d8a5 g2g4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 e1g1 e8g8 d4b3 c8e6 f2f4 c6a5 f4f5 e6c4 e2d3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 e1g1 e8g8 d4b3 c8e6 f2f4 c6a5 f4f5 e6c4 e2d3 c4d3 c2d3 d6d5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 e1g1 e8g8 d4b3 c8e6 f2f4 d8c8
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f1e2 b8c6 e1g1 e8g8 d4b3 a7a5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f2f3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f2f3 e8g8
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f2f3 e8g8 d1d2 b8c6 e1c1
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f2f3 e8g8 d1d2 b8c6 f1c4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f2f3 e8g8 d1d2 b8c6 f1c4 a7a5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f2f3 e8g8 d1d2 b8c6 f1c4 c8d7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f2f3 e8g8 d1d2 b8c6 f1c4 c8d7 e1c1
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 g7g6 c1e3 f8g7 f2f3 e8g8 d1d2 b8c6 f1c4 c8d7 e1c1 d8a5 c4b3 f8c8 h2h4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 c1e3 a7a6 d1d2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1b5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 g2g3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 g2g4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f2f4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f2f4 b8c6 c1e3 f8e7 d1f3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 b8c6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 b8c6 e1g1 f8e7 c1e3 e8g8 f2f4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 b8c6 e1g1 f8e7 c1e3 e8g8 f2f4 c8d7 d4b3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 a7a6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 a7a6 e1g1 b8d7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 a7a6 e1g1 d8c7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 a7a6 e1g1 d8c7 f2f4 b8c6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 a7a6 e1g1 d8c7 f2f4 b8c6 g1h1 f8e7 a2a4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 a7a6 e1g1 d8c7 f2f4 b8c6 c1e3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1e2 a7a6 e1g1 d8c7 f2f4 b8c6 c1e3 f8e7 d1e1 e8g8
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1c4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1c4 a7a6 c4b3 b7b5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1c4 b8c6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1c4 b8c6 c4b3 f8e7 c1e3 e8g8 f2f4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1c4 b8c6 c1e3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 e7e6 f1c4 b8c6 c1e3 f8e7 d1e2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 h2h3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 f1c4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1e3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 g2g3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 f1e2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 f2f4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 b8d7 f1c4 d8a5 d1d2 e7e6 e1c1 b7b5 c4b3 c8b7 h1e1 d7c5 e4e5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4 b7b5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4 b7b5 e4e5 d6e5 f4e5 d8c7 d1e2
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4 d8b6
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4 d8b6 d1d2 b6b2 a1b1 b2a3
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4 f8e7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4 f8e7 d1f3 h7h6 g5h4 d8c7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4 f8e7 d1f3 h7h6 g5h4 g7g5
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4 f8e7 d1f3 d8c7
1.e2e4 c7c5 g1f3 d7d6 d2d4 c5d4 f3d4 g8f6 b1c3 a7a6 c1g5 e7e6 f2f4 f8e7 d1f3 d8c7 e1c1 b8d7
1.e2e4 e7e6
1.e2e4 e7e6 c2c4
1.e2e4 e7e6 b2b3
1.e2e4 e7e6 e4e5
1.e2e4 e7e6 f2f4
1.e2e4 e7e6 g1f3
1.e2e4 e7e6 g1f3 d7d5 e4e5 c7c5 b2b4
1.e2e4 e7e6 b1c3
1.e2e4 e7e6 b1c3 d7d5 f2f4
1.e2e4 e7e6 b1c3 d7d5 g1f3
1.e2e4 e7e6 d1e2
1.e2e4 e7e6 d2d3
1.e2e4 e7e6 d2d3 d7d5 b1d2 g8f6 g1f3 b8c6 f1e2
1.e2e4 e7e6 d2d4
1.e2e4 e7e6 d2d4 d7d6
1.e2e4 e7e6 d2d4 a7a6
1.e2e4 e7e6 d2d4 d7d5
1.e2e4 e7e6 d2d4 d7d5 f1d3
1.e2e4 e7e6 d2d4 d7d5 c1e3
1.e2e4 e7e6 d2d4 d7d5 e4d5
1.e2e4 e7e6 d2d4 d7d5 e4d5 e6d5 b1c3 g8f6 c1g5
1.e2e4 e7e6 d2d4 d7d5 e4d5 e6d5 b1c3 g8f6 c1g5 b8c6
1.e2e4 e7e6 d2d4 d7d5 e4e5
1.e2e4 e7e6 d2d4 d7d5 e4e5 c7c5 d4c5
1.e2e4 e7e6 d2d4 d7d5 e4e5 c7c5 d1g4
1.e2e4 e7e6 d2d4 d7d5 e4e5 c7c5 g1f3
1.e2e4 e7e6 d2d4 d7d5 e4e5 c7c5 c2c3
1.e2e4 e7e6 d2d4 d7d5 e4e5 c7c5 c2c3 d8b6 g1f3 c8d7
1.e2e4 e7e6 d2d4 d7d5 e4e5 c7c5 c2c3 b8c6
1.e2e4 e7e6 d2d4 d7d5 e4e5 c7c5 c2c3 b8c6 g1f3
1.e2e4 e7e6 d2d4 d7d5 e4e5 c7c5 c2c3 b8c6 g1f3 d8b6 f1d3
1.e2e4 e7e6 d2d4 d7d5 e4e5 c7c5 c2c3 b8c6 g1f3 c8d7
1.e2e4 e7e6 d2d4 d7d5 b1d2
1.e2e4 e7e6 d2d4 d7d5 b1d2 f7f5
1.e2e4 e7e6 d2d4 d7d5 b1d2 b8c6
1.e2e4 e7e6 d2d4 d7d5 b1d2 b8c6 g1f3 g8f6
1.e2e4 e7e6 d2d4 d7d5 b1d2 g8f6
1.e2e4 e7e6 d2d4 d7d5 b1d2 g8f6 e4e5 f6d7 f1d3 c7c5 c2c3 b7b6
1.e2e4 e7e6 d2d4 d7d5 b1d2 g8f6 e4e5 f6d7 f1d3 c7c5 c2c3 b8c6
1.e2e4 e7e6 d2d4 d7d5 b1d2 g8f6 e4e5 f6d7 f1d3 c7c5 c2c3 b8c6 g1e2 c5d4 c3d4
1.e2e4 e7e6 d2d4 d7d5 b1d2 g8f6 e4e5 f6d7 f1d3 c7c5 c2c3 b8c6 g1e2 c5d4 c3d4 d7b6
1.e2e4 e7e6 d2d4 d7d5 b1d2 c7c5
1.e2e4 e7e6 d2d4 d7d5 b1d2 c7c5 e4d5 d8d5 g1f3 c5d4 f1c4 d5d8
1.e2e4 e7e6 d2d4 d7d5 b1d2 c7c5 e4d5 e6d5
1.e2e4 e7e6 d2d4 d7d5 b1d2 c7c5 e4d5 e6d5 g1f3 b8c6
1.e2e4 e7e6 d2d4 d7d5 b1c3
1.e2e4 e7e6 d2d4 d7d5 b1c3 c7c5
1.e2e4 e7e6 d2d4 d7d5 b1c3 d5e4
1.e2e4 e7e6 d2d4 d7d5 b1c3 d5e4 c3e4 c8d7 g1f3 d7c6
1.e2e4 e7e6 d2d4 d7d5 b1c3 d5e4 c3e4 b8d7
1.e2e4 e7e6 d2d4 d7d5 b1c3 d5e4 c3e4 b8d7 g1f3 g8f6 e4f6 d7f6 f3e5
1.e2e4 e7e6 d2d4 d7d5 b1c3 d5e4 c3e4 d8d5
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 f1d3
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1e3
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 e4e5
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 e4e5 f6d7 f2f4 c7c5 d4c5 f8c5 d1g4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 e4e5 f6d7 f2f4 c7c5 d4c5 b8c6
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 e4e5 f6d7 f2f4 c7c5 d4c5 b8c6 a2a3 f8c5 d1g4 e8g8 g1f3 f7f6
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 e4e5 f6d7 f2f4 c7c5 g1f3
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 e4e5 f6d7 f2f4 c7c5 g1f3 b8c6 c1e3
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 e4e5 f6d7 d1g4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 d5e4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4d5 d8d5 g5f6 g7f6 d1d2 d5a5
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5 h7h6 e5f6
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5 h7h6 e5f6 h6g5 f6g7 h8g8 h2h4 g5h4 d1g4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5 h7h6 g5h4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5 h7h6 g5e3
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5 h7h6 g5c1
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5 h7h6 g5d2 f6d7
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5 h7h6 g5d2 b4c3
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5 h7h6 g5d2 b4c3 b2c3 f6e4 d1g4 e8f8 d2c1
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8b4 e4e5 h7h6 g5d2 b4c3 b2c3 f6e4 d1g4 g7g6
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 g5f6
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 g5f6 e7f6 e4e5 f6e7 d1g4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6g8
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6g8 g5e3 b7b6
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6e4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 h2h4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 h2h4 a7a6
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 h2h4 c7c5
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 h2h4 f7f6
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 h2h4 e8g8
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 g5e7 d8e7
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 g5e7 d8e7 f1d3
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 g5e7 d8e7 d1d2
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 g5e7 d8e7 c3b5
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 g5e7 d8e7 d1g4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 g5e7 d8e7 f2f4
1.e2e4 e7e6 d2d4 d7d5 b1c3 g8f6 c1g5 f8e7 e4e5 f6d7 g5e7 d8e7 f2f4 e8g8 g1f3 c7c5 d1d2 b8c6 e1c1 c5c4
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 f1d3 c7c5 e4d5 d8d5 c1d2
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 c1d2
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 g1e2
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 g1e2 d5e4 a2a3 b4e7 c3e4 g8f6 e2g3 e8g8 f1e2 b8c6
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 g1e2 d5e4 a2a3 b4c3
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 g1e2 d5e4 a2a3 b4c3 e2c3 b8c6
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 d8d7
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 c1d2
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 d1g4
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3 c5d4 a3b4 d4c3 g1f3
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3 b4c3 b2c3
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3 b4c3 b2c3 d8c7
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3 b4c3 b2c3 g8e7
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3 b4c3 b2c3 g8e7 a3a4
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3 b4c3 b2c3 g8e7 g1f3
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3 b4c3 b2c3 g8e7 d1g4
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3 b4c3 b2c3 g8e7 d1g4 d8c7 g4g7 h8g8 g7h7 c5d4 e1d1
1.e2e4 e7e6 d2d4 d7d5 b1c3 f8b4 e4e5 c7c5 a2a3 b4c3 b2c3 g8e7 d1g4 d8c7 g4g7 h8g8 g7h7 c5d4 g1e2
1.e2e4 e7e5
1.e2e4 e7e5 d2d3
1.e2e4 e7e5 a2a3
1.e2e4 e7e5 f2f3
1.e2e4 e7e5 d1h5
1.e2e4 e7e5 d1f3
1.e2e4 e7e5 c2c3
1.e2e4 e7e5 g1e2
1.e2e4 e7e5 d2d4 e5d4
1.e2e4 e7e5 d2d4 e5d4 g1f3 c7c5 f1c4 b7b5
1.e2e4 e7e5 d2d4 e5d4 f2f4
1.e2e4 e7e5 d2d4 e5d4 c2c3
1.e2e4 e7e5 d2d4 e5d4 c2c3 d4c3 f1c4 c3b2 c1b2 d8e7
1.e2e4 e7e5 d2d4 e5d4 c2c3 d4c3 f1c4 c3b2 c1b2 d7d5
1.e2e4 e7e5 d2d4 e5d4 c2c3 d7d5
1.e2e4 e7e5 d2d4 e5d4 d1d4
1.e2e4 e7e5 d2d4 e5d4 d1d4 b8c6
1.e2e4 e7e5 d2d4 e5d4 d1d4 b8c6 d4e3
1.e2e4 e7e5 d2d4 e5d4 d1d4 b8c6 d4e3 f8b4 c2c3 b4e7
1.e2e4 e7e5 d2d4 e5d4 d1d4 b8c6 d4e3 f7f5
1.e2e4 e7e5 d2d4 e5d4 d1d4 b8c6 d4e3 g8f6
1.e2e4 e7e5 d2d4 e5d4 d1d4 b8c6 d4e3 g8f6 b1c3 f8b4 c1d2 e8g8 e1c1 f8e8 f1c4 d7d6 g1h3
1.e2e4 e7e5 d2d4 e5d4 d1d4 b8c6 d4c4
1.e2e4 e7e5 f1c4
1.e2e4 e7e5 f1c4 c7c6
1.e2e4 e7e5 f1c4 c7c6 d2d4 d7d5 e4d5 c6d5 c4b5 c8d7 b5d7 b8d7 d4e5 d7e5 g1e2
1.e2e4 e7e5 f1c4 f7f5
1.e2e4 e7e5 f1c4 f7f5 d2d3
1.e2e4 e7e5 f1c4 f8c5
1.e2e4 e7e5 f1c4 f8c5 d1e2 b8c6 c2c3 g8f6 f2f4
1.e2e4 e7e5 f1c4 f8c5 c2c3
1.e2e4 e7e5 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 e4e5 d7d5 e5f6 d5c4 d1h5 e8g8
1.e2e4 e7e5 f1c4 f8c5 c2c3 d7d5
1.e2e4 e7e5 f1c4 f8c5 c2c3 d8g5
1.e2e4 e7e5 f1c4 f8c5 d2d4
1.e2e4 e7e5 f1c4 f8c5 b2b4
1.e2e4 e7e5 f1c4 f8c5 b2b4 c5b4 f2f4
1.e2e4 e7e5 f1c4 f8c5 b2b4 c5b4 f2f4 e5f4 g1f3 b4e7 d2d4 e7h4 g2g3 f4g3 e1g1 g3h2 g1h1
1.e2e4 e7e5 f1c4 g8f6
1.e2e4 e7e5 f1c4 g8f6 f2f4
1.e2e4 e7e5 f1c4 g8f6 d2d4
1.e2e4 e7e5 f1c4 g8f6 d2d4 e5d4 g1f3
1.e2e4 e7e5 f1c4 g8f6 d2d4 e5d4 g1f3 d7d5 e4d5 f8b4 c2c3 d8e7
1.e2e4 e7e5 b1c3
1.e2e4 e7e5 b1c3 f8b4 d1g4 g8f6
1.e2e4 e7e5 b1c3 b8c6
1.e2e4 e7e5 b1c3 b8c6 g2g3
1.e2e4 e7e5 b1c3 b8c6 d2d4
1.e2e4 e7e5 b1c3 b8c6 f2f4
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 d2d4
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 d2d4 d8h4 e1e2 d7d5
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 d2d4 d8h4 e1e2 b7b6
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 g1f3
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5 d7d6
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 e1g1
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 e1g1 g4f3 d1f3 c6e5 f3f4 d8f6
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 g1f3 g7g5 d2d4
1.e2e4 e7e5 b1c3 b8c6 f2f4 e5f4 g1f3 g7g5 d2d4 g5g4 f1c4 g4f3 e1g1 d7d5 e4d5 c8g4 d5c6
1.e2e4 e7e5 b1c3 g8f6
1.e2e4 e7e5 b1c3 g8f6 a2a3
1.e2e4 e7e5 b1c3 g8f6 g2g3
1.e2e4 e7e5 b1c3 g8f6 f1c4
1.e2e4 e7e5 b1c3 g8f6 f1c4 f6e4
1.e2e4 e7e5 b1c3 g8f6 f1c4 f6e4 d1h5 e4d6 c4b3 b8c6 c3b5 g7g6 h5f3 f7f5 f3d5 d8e7 b5c7 e8d8 c7a8 b7b6
1.e2e4 e7e5 b1c3 g8f6 f1c4 f6e4 d1h5 e4d6 c4b3 b8c6 d2d4
1.e2e4 e7e5 b1c3 g8f6 f1c4 f6e4 d1h5 e4d6 c4b3 f8e7
1.e2e4 e7e5 b1c3 g8f6 f1c4 f6e4 d1h5 e4d6 c4b3 f8e7 g1f3 b8c6 f3e5
1.e2e4 e7e5 b1c3 g8f6 f1c4 f6e4 g1f3
1.e2e4 e7e5 b1c3 g8f6 f1c4 f6e4 g1f3 d7d5
1.e2e4 e7e5 b1c3 g8f6 f1c4 b8c6
1.e2e4 e7e5 b1c3 g8f6 f2f4 d7d5
1.e2e4 e7e5 b1c3 g8f6 f2f4 d7d5 f4e5 f6e4 g1f3 c8g4 d1e2
1.e2e4 e7e5 b1c3 g8f6 f2f4 d7d5 f4e5 f6e4 g1f3 f8e7
1.e2e4 e7e5 b1c3 g8f6 f2f4 d7d5 f4e5 f6e4 d1f3
1.e2e4 e7e5 b1c3 g8f6 f2f4 d7d5 f4e5 f6e4 d1f3 f7f5
1.e2e4 e7e5 b1c3 g8f6 f2f4 d7d5 f4e5 f6e4 d1f3 f7f5 d2d4
1.e2e4 e7e5 b1c3 g8f6 f2f4 d7d5 f4e5 f6e4 d2d3
1.e2e4 e7e5 b1c3 g8f6 f2f4 d7d5 f4e5 f6e4 d2d3 d8h4 g2g3 e4g3 g1f3 h4h5 c3d5
1.e2e4 e7e5 b1c3 g8f6 f2f4 d7d5 d2d3
1.e2e4 e7e5 f2f4
1.e2e4 e7e5 f2f4 d8h4 g2g3 h4e7
1.e2e4 e7e5 f2f4 c7c5
1.e2e4 e7e5 f2f4 d8f6
1.e2e4 e7e5 f2f4 d8f6 g1f3 f6f4 b1c3 f8b4 f1c4
1.e2e4 e7e5 f2f4 f8c5
1.e2e4 e7e5 f2f4 f8c5 g1f3 d7d6 b1c3 g8f6 f1c4 b8c6 d2d3 c8g4 h2h3 g4f3 d1f3 e5f4
1.e2e4 e7e5 f2f4 f8c5 g1f3 d7d6 b1c3 b8d7
1.e2e4 e7e5 f2f4 f8c5 g1f3 d7d6 c2c3
1.e2e4 e7e5 f2f4 f8c5 g1f3 d7d6 c2c3 c8g4 f4e5 d6e5 d1a4
1.e2e4 e7e5 f2f4 f8c5 g1f3 d7d6 c2c3 f7f5
1.e2e4 e7e5 f2f4 f8c5 g1f3 d7d6 c2c3 f7f5 f4e5 d6e5 d2d4 e5d4 f1c4
1.e2e4 e7e5 f2f4 f8c5 g1f3 d7d6 f4e5
1.e2e4 e7e5 f2f4 f8c5 g1f3 d7d6 b2b4
1.e2e4 e7e5 f2f4 g8f6
1.e2e4 e7e5 f2f4 d7d5
1.e2e4 e7e5 f2f4 d7d5 g1f3
1.e2e4 e7e5 f2f4 d7d5 b1c3
1.e2e4 e7e5 f2f4 d7d5 e4d5
1.e2e4 e7e5 f2f4 d7d5 e4d5 c7c6
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 b1c3 g8f6 d1e2
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 f1b5
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3 g8f6 b1c3 f8b4 c1d2 e4e3
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3 g8f6 d3e4
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3 g8f6 d3e4 f6e4 g1f3 f8c5 d1e2 c5f2 e1d1 d8d5 f3d2
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3 g8f6 d3e4 f6e4 g1f3 f8c5 d1e2 c8f5
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3 g8f6 d3e4 f6e4 g1f3 f8c5 d1e2 c8f5 g2g4 e8g8
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3 g8f6 d3e4 f6e4 d1e2
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3 g8f6 d3e4 f6e4 d1e2 d8d5 b1d2 f7f5 g2g4
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3 g8f6 b1d2
1.e2e4 e7e5 f2f4 d7d5 e4d5 e5e4 d2d3 g8f6 d1e2
1.e2e4 e7e5 f2f4 e5f4
1.e2e4 e7e5 f2f4 e5f4 e1f2
1.e2e4 e7e5 f2f4 e5f4 b2b3
1.e2e4 e7e5 f2f4 e5f4 h2h4
1.e2e4 e7e5 f2f4 e5f4 f1d3
1.e2e4 e7e5 f2f4 e5f4 d1e2
1.e2e4 e7e5 f2f4 e5f4 d2d4
1.e2e4 e7e5 f2f4 e5f4 b1c3
1.e2e4 e7e5 f2f4 e5f4 d1f3
1.e2e4 e7e5 f2f4 e5f4 f1e2
1.e2e4 e7e5 f2f4 e5f4 f1c4
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 d7d5 c4d5 g7g5 g2g3
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 f8c5
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 g7g5
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 g7g5 b1c3 f8g7 d2d4 d7d6 e4e5
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 g7g5 b1c3 f8g7 d2d4 g8e7
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 g7g5 b1c3 f8g7 d2d4 g8e7 g2g3
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 g7g5 b1c3 f8g7 g2g3
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 g7g5 b1c3 f8g7 g2g3 f4g3 d1f3
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 g7g5 d1f3
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 b8c6
1.e2e4 e7e5 f2f4 e5f4 f1c4 d8h4 e1f1 b7b5
1.e2e4 e7e5 f2f4 e5f4 f1c4 b7b5
1.e2e4 e7e5 f2f4 e5f4 f1c4 g8e7
1.e2e4 e7e5 f2f4 e5f4 f1c4 b8c6
1.e2e4 e7e5 f2f4 e5f4 f1c4 c7c6
1.e2e4 e7e5 f2f4 e5f4 f1c4 f7f5
1.e2e4 e7e5 f2f4 e5f4 f1c4 f7f5 d1e2 d8h4 e1d1 f5e4 b1c3 e8d8
1.e2e4 e7e5 f2f4 e5f4 f1c4 d7d5
1.e2e4 e7e5 f2f4 e5f4 f1c4 d7d5 c4d5 d8h4 e1f1 g7g5 g2g3
1.e2e4 e7e5 f2f4 e5f4 f1c4 d7d5 c4d5 d8h4 e1f1 f8d6
1.e2e4 e7e5 f2f4 e5f4 f1c4 d7d5 c4d5 c7c6
1.e2e4 e7e5 f2f4 e5f4 f1c4 d7d5 c4d5 g8f6
1.e2e4 e7e5 f2f4 e5f4 f1c4 g8f6
1.e2e4 e7e5 f2f4 e5f4 f1c4 g8f6 b1c3
1.e2e4 e7e5 f2f4 e5f4 f1c4 g8f6 b1c3 f8b4 e4e5
1.e2e4 e7e5 f2f4 e5f4 f1c4 g8f6 b1c3 c7c6
1.e2e4 e7e5 f2f4 e5f4 g1f3
1.e2e4 e7e5 f2f4 e5f4 g1f3 g8e7
1.e2e4 e7e5 f2f4 e5f4 g1f3 f7f5
1.e2e4 e7e5 f2f4 e5f4 g1f3 d7d6
1.e2e4 e7e5 f2f4 e5f4 g1f3 h7h6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g8f6
1.e2e4 e7e5 f2f4 e5f4 g1f3 f8e7
1.e2e4 e7e5 f2f4 e5f4 g1f3 f8e7 f1c4 e7h4 g2g3
1.e2e4 e7e5 f2f4 e5f4 g1f3 f8e7 f1c4 e7h4 g2g3 f4g3 e1g1 g3h2 g1h1
1.e2e4 e7e5 f2f4 e5f4 g1f3 f8e7 f1c4 g8f6
1.e2e4 e7e5 f2f4 e5f4 g1f3 d7d5
1.e2e4 e7e5 f2f4 e5f4 g1f3 d7d5 e4d5 g8f6
1.e2e4 e7e5 f2f4 e5f4 g1f3 d7d5 e4d5 g8f6 f1b5 c7c6 d5c6 b7c6 b5c4 f6d5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 b1c3
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 d2d4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 d2d4 g5g4 f3e5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 b8c6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 c4f7
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 c4f7 e8f7 e1g1 g4f3 d1f3 d8f6 d2d4 f6d4 c1e3 d4f6 b1c3
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 d2d4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 b1c3
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 f3e5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 f3e5 d8h4 e1f1 g8h6 d2d4 f4f3
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 f3e5 d8h4 e1f1 g8h6 d2d4 d7d6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 f3e5 d8h4 e1f1 f4f3
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 f3e5 d8h4 e1f1 b8c6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 e1g1
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 e1g1 g4f3 d1f3 d8f6 e4e5 f6e5 d2d3 f8h6 b1c3 g8e7 c1d2 b8c6 a1e1
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 e1g1 g4f3 d1f3 d8f6 e4e5 f6e5 c4f7
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 e1g1 g4f3 d1f3 d8e7
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 e1g1 g4f3 d1f3 b8c6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 e1g1 d8e7
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 g5g4 e1g1 d7d5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 f8g7
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 f8g7 e1g1
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 f8g7 h2h4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 f8g7 h2h4 h7h6 d2d4 d7d6 b1c3 c7c6 h4g5 h6g5 h1h8 g7h8 f3e5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 f1c4 f8g7 h2h4 h7h6 d2d4 d7d6 d1d3
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5 h7h6 g5f7 e8f7 d1g4 g8f6 g4f4 f8d6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5 h7h6 g5f7 e8f7 d2d4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5 h7h6 g5f7 e8f7 d2d4 d7d5 c1f4 d5e4 f1c4 f7g7 f4e5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5 h7h6 g5f7 e8f7 b1c3
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5 h7h6 g5f7 e8f7 f1c4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5 h7h6 g5f7 e8f7 f1c4 d7d5 c4d5 f7g7 d2d4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3g5 g8f6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 f8g7
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 h7h5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 h7h5 f1c4 h8h7 d2d4 f8h6 b1c3
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 d7d5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 d7d5 d2d4 g8f6 e4d5 d8d5 b1c3 f8b4 e1f2
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 d7d5 d2d4 g8f6 c1f4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 d7d5 d2d4 g8f6 c1f4 f6e4 b1d2
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 d8e7
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 d8e7 d2d4 f7f5 f1c4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 f8e7
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 b8c6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 d7d6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 g8f6
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 g8f6 e5g4 d7d5
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 g8f6 f1c4
1.e2e4 e7e5 f2f4 e5f4 g1f3 g7g5 h2h4 g5g4 f3e5 g8f6 f1c4 d7d5 e4d5 f8d6 e1g1
1.e2e4 e7e5 g1f3
1.e2e4 e7e5 g1f3 d8e7
1.e2e4 e7e5 g1f3 d8f6
1.e2e4 e7e5 g1f3 f7f6
1.e2e4 e7e5 g1f3 d7d5
1.e2e4 e7e5 g1f3 d7d5 e4d5 f8d6
1.e2e4 e7e5 g1f3 f7f5
1.e2e4 e7e5 g1f3 f7f5 f3e5 d8f6 d2d4 d7d6 e5c4 f5e4 c4e3
1.e2e4 e7e5 g1f3 f7f5 f3e5 b8c6
1.e2e4 e7e5 g1f3 f7f5 f1c4
1.e2e4 e7e5 g1f3 f7f5 f1c4 f5e4 f3e5 d8g5 e5f7 g5g2 h1f1 d7d5 f7h8 g8f6
1.e2e4 e7e5 g1f3 f7f5 f1c4 f5e4 f3e5 d7d5
1.e2e4 e7e5 g1f3 f7f5 f1c4 f5e4 f3e5 g8f6
1.e2e4 e7e5 g1f3 d7d6
1.e2e4 e7e5 g1f3 d7d6 f1c4 f8e7 c2c3
1.e2e4 e7e5 g1f3 d7d6 f1c4 f7f5
1.e2e4 e7e5 g1f3 d7d6 f1c4 f7f5 d2d4 e5d4 f3g5 g8h6 g5h7
1.e2e4 e7e5 g1f3 d7d6 d2d4
1.e2e4 e7e5 g1f3 d7d6 d2d4 f7f5
1.e2e4 e7e5 g1f3 d7d6 d2d4 f7f5 d4e5 f5e4 f3g5 d6d5 e5e6
1.e2e4 e7e5 g1f3 d7d6 d2d4 f7f5 d4e5 f5e4 f3g5 d6d5 e5e6 f8c5 b1c3
1.e2e4 e7e5 g1f3 d7d6 d2d4 f7f5 b1c3
1.e2e4 e7e5 g1f3 d7d6 d2d4 e5d4
1.e2e4 e7e5 g1f3 d7d6 d2d4 e5d4 d1d4 c8d7
1.e2e4 e7e5 g1f3 d7d6 d2d4 e5d4 f3d4
1.e2e4 e7e5 g1f3 d7d6 d2d4 e5d4 f3d4 d6d5 e4d5
1.e2e4 e7e5 g1f3 d7d6 d2d4 e5d4 f3d4 g8f6
1.e2e4 e7e5 g1f3 d7d6 d2d4 e5d4 f3d4 g8f6 b1c3 f8e7 f1e2 e8g8 e1g1 c7c5 d4f3 b8c6 c1g5 c8e6 f1e1
1.e2e4 e7e5 g1f3 d7d6 d2d4 e5d4 f3d4 g7g6
1.e2e4 e7e5 g1f3 d7d6 d2d4 g8f6
1.e2e4 e7e5 g1f3 d7d6 d2d4 g8f6 b1c3 b8d7
1.e2e4 e7e5 g1f3 d7d6 d2d4 g8f6 b1c3 b8d7 f1c4 f8e7 e1g1 e8g8 d1e2 c7c6 a2a4 e5d4
1.e2e4 e7e5 g1f3 d7d6 d2d4 g8f6 b1c3 b8d7 f1c4 f8e7 f3g5 e8g8 c4f7
1.e2e4 e7e5 g1f3 d7d6 d2d4 g8f6 d4e5
1.e2e4 e7e5 g1f3 d7d6 d2d4 g8f6 d4e5 f6e4 b1d2
1.e2e4 e7e5 g1f3 d7d6 d2d4 g8f6 d4e5 f6e4 d1d5
1.e2e4 e7e5 g1f3 d7d6 d2d4 g8f6 f3g5
1.e2e4 e7e5 g1f3 d7d6 d2d4 g8f6 f1c4
1.e2e4 e7e5 g1f3 d7d6 d2d4 b8d7
1.e2e4 e7e5 g1f3 d7d6 d2d4 b8d7 f1c4 c7c6 e1g1
1.e2e4 e7e5 g1f3 d7d6 d2d4 b8d7 f1c4 c7c6 e1g1 f8e7 d4e5
1.e2e4 e7e5 g1f3 d7d6 d2d4 b8d7 f1c4 c7c6 f3g5
1.e2e4 e7e5 g1f3 d7d6 d2d4 b8d7 f1c4 c7c6 f3g5 g8h6 f2f4 f8e7 e1g1 e8g8 c2c3 d6d5
1.e2e4 e7e5 g1f3 d7d6 d2d4 b8d7 f1c4 c7c6 b1c3
1.e2e4 e7e5 g1f3 d7d6 d2d4 b8d7 f1c4 c7c6 c2c3
1.e2e4 e7e5 g1f3 g8f6
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d3
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 c2c4
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 b1c3
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d1e2
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 d6d5 f1d3 f8e7 e1g1 b8c6 f1e1
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 d6d5 f1d3 f8e7 e1g1 b8c6 f1e1 c8g4 c2c3 f7f5 b1d2
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 d6d5 f1d3 f8e7 e1g1 b8c6 f1e1 c8g4 c2c3 f7f5 c3c4
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 d6d5 f1d3 f8e7 e1g1 b8c6 f1e1 c8g4 c2c3 f7f5 c3c4 e7h4
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 d6d5 f1d3 f8e7 e1g1 b8c6 c2c4
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 d6d5 f1d3 f8e7 e1g1 e8g8
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 d6d5 f1d3 f8d6
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 d6d5 f1d3 f8d6 e1g1 e8g8 c2c4 c8g4
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 d6d5 f1d3 f8d6 e1g1 e8g8 c2c4 c8g4 c4d5 f7f5 f1e1 d6h2
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f3 f6e4 d2d4 e4f6
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5f7
1.e2e4 e7e5 g1f3 g8f6 f3e5 d7d6 e5c4
1.e2e4 e7e5 g1f3 g8f6 f3e5 f6e4
1.e2e4 e7e5 g1f3 g8f6 b1c3
1.e2e4 e7e5 g1f3 g8f6 f1c4
1.e2e4 e7e5 g1f3 g8f6 d2d4
1.e2e4 e7e5 g1f3 g8f6 d2d4 e5d4 e4e5 f6e4 d1d4
1.e2e4 e7e5 g1f3 g8f6 d2d4 e5d4 e4e5 f6e4 d1e2
1.e2e4 e7e5 g1f3 g8f6 d2d4 e5d4 e4e5 f6e4 d1e2 e4c5 f3d4 b8c6
1.e2e4 e7e5 g1f3 g8f6 d2d4 e5d4 f1c4
1.e2e4 e7e5 g1f3 g8f6 d2d4 f6e4
1.e2e4 e7e5 g1f3 g8f6 d2d4 f6e4 f1d3 d7d5 f3e5 f8d6 e1g1 e8g8 c2c4 d6e5
1.e2e4 e7e5 g1f3 b8c6
1.e2e4 e7e5 g1f3 b8c6 f3e5 c6e5 d2d4
1.e2e4 e7e5 g1f3 b8c6 g2g3
1.e2e4 e7e5 g1f3 b8c6 c2c4
1.e2e4 e7e5 g1f3 b8c6 f1e2
1.e2e4 e7e5 g1f3 b8c6 f1e2 g8f6 d2d3 d7d5 b1d2
1.e2e4 e7e5 g1f3 b8c6 f1e2 g8f6 d2d4
1.e2e4 e7e5 g1f3 b8c6 c2c3
1.e2e4 e7e5 g1f3 b8c6 c2c3 d7d5 d1a4 c8d7
1.e2e4 e7e5 g1f3 b8c6 c2c3 d7d5 d1a4 g8f6
1.e2e4 e7e5 g1f3 b8c6 c2c3 d7d5 d1a4 f7f6
1.e2e4 e7e5 g1f3 b8c6 c2c3 g8f6
1.e2e4 e7e5 g1f3 b8c6 c2c3 g8f6 d2d4 f6e4 d4d5 f8c5
1.e2e4 e7e5 g1f3 b8c6 c2c3 g8e7
1.e2e4 e7e5 g1f3 b8c6 c2c3 f8e7
1.e2e4 e7e5 g1f3 b8c6 c2c3 f7f5
1.e2e4 e7e5 g1f3 b8c6 c2c3 f7f5 d2d4 d7d6 d4d5
1.e2e4 e7e5 g1f3 b8c6 c2c3 f7f5 d2d4 d7d6 d4d5 f5e4 f3g5 c6b8 g5e4 g8f6 f1d3 f8e7
1.e2e4 e7e5 g1f3 b8c6 d2d4
1.e2e4 e7e5 g1f3 b8c6 d2d4 c6d4
1.e2e4 e7e5 g1f3 b8c6 d2d4 c6d4 f3e5 d4e6 f1c4 c7c6 e1g1 g8f6 e5f7
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1b5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 c2c3
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 c2c3 d4c3 b1c3 d7d6 f1c4 c8g4 e1g1 c6e5 f3e5 g4d1 c4f7 e8e7 c3d5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 c2c3 d4c3 b1c3 f8b4
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 c2c3 d4c3 b1c3 f8b4 f1c4 g8f6
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 f8c5 e1g1 d7d6 c2c3 c8g4
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 f8c5 f3g5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 f8c5 f3g5 g8h6 g5f7 h6f7 c4f7 e8f7 d1h5 g7g6 h5c5 d7d5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 f8c5 f3g5 g8h6 d1h5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 f8b4
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 f8b4 c2c3 d4c3 e1g1 c3b2 c1b2 g8f6 f3g5 e8g8 e4e5 c6e5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 f8b4 c2c3 d4c3 b2c3
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 f8b4 c2c3 d4c3 b2c3 b4a5 e4e5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 f8e7
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f1c4 g8f6
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 c6d4 d1d4 d7d6 f1d3
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 d8h4
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 d8h4 d4b5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 d8h4 d4b5 f8b4 b1d2 h4e4 f1e2 e4g2 e2f3 g2h3 b5c7 e8d8 c7a8 g8f6 a2a3
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 d8h4 d4b5 f8b4 c1d2
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 d8h4 d4b5 f8b4 c1d2 h4e4 f1e2 e8d8 e1g1 b4d2 b1d2 e4g6
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 d8h4 d4f3
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 d8h4 b1c3
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 g8f6
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 g8f6 d4c6 b7c6 e4e5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 g8f6 d4c6 b7c6 b1d2
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 f8c5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 f8c5 c1e3 d8f6 c2c3 g8e7 d1d2
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 f8c5 c1e3 d8f6 c2c3 g8e7 d1d2 d7d5 d4b5 c5e3 d2e3 e8g8 b5c7 a8b8 c7d5 e7d5 e4d5 c6b4
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 f8c5 c1e3 d8f6 c2c3 g8e7 f1b5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 f8c5 c1e3 d8f6 c2c3 g8e7 f1b5 c6d8
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 f8c5 c1e3 d8f6 c2c3 g8e7 d4c2
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 f8c5 c1e3 d8f6 d4b5
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 f8c5 d4b3
1.e2e4 e7e5 g1f3 b8c6 d2d4 e5d4 f3d4 f8c5 d4b3 c5b4
1.e2e4 e7e5 g1f3 b8c6 b1c3
1.e2e4 e7e5 g1f3 b8c6 b1c3 f8b4 c3d5 g8f6
1.e2e4 e7e5 g1f3 b8c6 b1c3 f7f5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g7g6
1.e2e4 e7e5 g1f3 b8c6 b1c3 g7g6 d2d4 e5d4 c3d5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f3e5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1c4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 a2a3
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 d2d4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 d2d4 f8b4 f3e5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 d2d4 e5d4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 d2d4 e5d4 c3d5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 a7a6 b5c6
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 a7a6 b5c6 d7c6 f3e5 f6e4 c3e4 d8d4 e1g1 d4e5 f1e1 c8e6 d2d4 e5d5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8c5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8c5 e1g1 e8g8 f3e5 c6e5 d2d4 c5d6 f2f4 e5c6 e4e5 d6b4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8c5 e1g1 e8g8 f3e5 c6d4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 c6d4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 c6d4 f3e5 d8e7 f2f4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 c6d4 b5e2
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 c6d4 b5e2 d4f3 e2f3 f8c5 e1g1 e8g8 d2d3 d7d6 c3a4 c5b6
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 c6d4 f3d4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 c6d4 e1g1
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 c3d5 f6d5 e4d5 e5e4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 d8e7 c3e2 d7d5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 b4c3
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 b4c3 b2c3 d7d6 f1e1
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 b4c3 b2c3 d7d5
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 d7d6
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 d7d6 c1g5 b4c3 b2c3 d8e7
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 d7d6 c1g5 b4c3 b2c3 d8e7 f1e1 c6d8 d3d4 c8g4
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 d7d6 c1g5 c6e7
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 d7d6 c1g5 c6e7 f3h4 c7c6 b5c4 d6d5 c4b3 d8d6
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 d7d6 c1g5 c8e6
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 d2d3 d7d6 c3e2
1.e2e4 e7e5 g1f3 b8c6 b1c3 g8f6 f1b5 f8b4 e1g1 e8g8 b5c6
1.e2e4 e7e5 g1f3 b8c6 f1c4
1.e2e4 e7e5 g1f3 b8c6 f1c4 c6d4 f3e5 d8g5 e5f7 g5g2 h1f1 g2e4 c4e2 d4f3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f7f5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8e7
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8e7 d2d4 e5d4 c2c3 g8f6 e4e5 f6e4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b1c3 g8f6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c4f7
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 d2d3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 d2d3 f7f5 f3g5 f5f4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 d2d3 g8f6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 d2d3 g8f6 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 d2d3 g8f6 b1c3 d7d6 c1g5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b6 b4b5 c6a5 f3e5 g8h6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b6 b4b5 c6a5 f3e5 g8h6 d2d4 d7d6 c1h6 d6e5 h6g7 h8g8 c4f7 e8f7 g7e5 d8g5 b1d2
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b6 b4b5 c6a5 f3e5 d8g5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b6 b4b5 c6a5 f3e5 d8g5 c4f7 e8e7 d1h5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b6 b4b5 c6a5 f3e5 d8g5 d1f3 g5e5 f3f7 e8d8 c1b2
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b6 a2a4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b6 a2a4 a7a6 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b6 c1b2
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 d7d5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4c5 d2d4 e5d4 e1g1 d7d6 c3d4 c5b6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4c5 d2d4 e5d4 e1g1 d7d6 c3d4 c5b6 d4d5 c6a5 c1b2
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4c5 d2d4 e5d4 e1g1 d7d6 c3d4 c5b6 d4d5 c6a5 c1b2 g8e7
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4c5 d2d4 e5d4 e1g1 d7d6 c3d4 c5b6 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4c5 d2d4 e5d4 e1g1 d7d6 c3d4 c5b6 b1c3 c6a5 c1g5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4c5 d2d4 e5d4 e1g1 d7d6 c3d4 c5b6 b1c3 c6a5 c1g5 f7f6 g5e3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4c5 d2d4 e5d4 e1g1 d7d6 c3d4 c5b6 b1c3 c8g4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4c5 d2d4 e5d4 e1g1 d7d6 c3d4 c5b6 b1c3 c8g4 d1a4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4c5 d2d4 e5d4 e1g1 d7d6 c3d4 c5b6 b1c3 c8g4 d1a4 g4d7 a4b3 c6a5 c4f7 e8f8 b3c2
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4d6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4f8
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4e7
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4e7 d2d4 c6a5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 d2d4 e5d4 e1g1 d4c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 d2d4 e5d4 e1g1 d4c3 d1b3 d8f6 e4e5 f6g6 b1c3 g8e7 c1a3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 d2d4 e5d4 e1g1 d4c3 d1b3 d8f6 e4e5 f6g6 b1c3 g8e7 f1d1
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 d2d4 b7b5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 d2d4 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 d2d4 d7d6 d1b3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 d2d4 d7d6 d1b3 d8d7 d4e5 d6e5 e1g1 a5b6 c1a3 c6a5 f3e5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 d2d4 d7d6 c1g5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 e1g1
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 e1g1 g8f6 d2d4 e8g8 f3e5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 e1g1 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 e1g1 d7d6 d2d4 e5d4 d1b3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 e1g1 d7d6 d2d4 a5b6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 e1g1 d7d6 d2d4 c8d7
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 b2b4 c5b4 c2c3 b4a5 e1g1 d7d6 d2d4 c8g4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 d7d6 d2d4 e5d4 c3d4 c5b6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 d8e7
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 d8e7 d2d4 c5b6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 d8e7 d2d4 c5b6 e1g1 g8f6 a2a4 a7a6 f1e1 d7d6 h2h3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 d8e7 d2d4 c5b6 c1g5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 d8e7 d2d4 c5b6 d4d5 c6b8 d5d6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 b2b4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 e4e5 f6e4 c4d5 e4f2 e1f2 d4c3 f2g3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 e4e5 d7d5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 e4e5 d7d5 c4b5 f6e4 c3d4 c5b4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 c1d2 f6e4 d2b4 c6b4 c4f7 e8f7 d1b3 d7d5 f3e5 f7f6 f2f3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 e1f1
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 b1c3 f6e4 e1g1 e4c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 b1c3 f6e4 e1g1 e4c3 b2c3 b4c3 d1b3 d7d5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 b1c3 f6e4 e1g1 e4c3 b2c3 b4c3 c1a3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 b1c3 f6e4 e1g1 b4c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 b1c3 f6e4 e1g1 b4c3 b2c3 d7d5 c1a3
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 b1c3 f6e4 e1g1 b4c3 d4d5
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 b1c3 f6e4 e1g1 b4c3 d4d5 c3f6 f1e1 c6e7 e1e4 d7d6 c1g5 f6g5 f3g5 e8g8 g5h7
1.e2e4 e7e5 g1f3 b8c6 f1c4 f8c5 c2c3 g8f6 d2d4 e5d4 c3d4 c5b4 b1c3 f6e4 e1g1 b4c3 d4d5 c3f6 f1e1 c6e7 e1e4 d7d6 g2g4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 e1g1 f8c5 d2d4 c5d4 f3d4 c6d4 c1g5 h7h6 g5h4 g7g5 f2f4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 e1g1 f8c5 d2d4 c5d4 f3d4 c6d4 c1g5 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 e1g1 f8c5 d2d4 c5d4 f3d4 c6d4 c1g5 d7d6 f2f4 d8e7 f4e5 d6e5 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d3
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e4e5 d7d5 c4b5 f6e4 f3d4 f8c5 d4c6 c5f2 e1f1 d8h4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 f3g5
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f8c5 e4e5
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f8c5 e4e5 d7d5 e5f6 d5c4 f1e1 c8e6 f3g5 d8d5 b1c3 d5f5 g2g4 f5g6 c3e4 c5b6 f2f4 e8c8
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f8c5 e4e5 d7d5 e5f6 d5c4 f1e1 c8e6 f3g5 d8d5 b1c3 d5f5 c3e4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f8c5 e4e5 d7d5 e5f6 d5c4 f1e1 c8e6 f3g5 d8d5 b1c3 d5f5 c3e4 c5f8
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f8c5 e4e5 d7d5 e5f6 d5c4 f1e1 c8e6 f3g5 g7g6
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f8c5 e4e5 d7d5 e5f6 d5c4 f1e1 c8e6 f6g7
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f8c5 e4e5 f6g4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f8c5 e4e5 f6g4 c2c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f6e4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f6e4 f1e1 d7d5 c4d5 d8d5 b1c3 d5a5 c3e4 c8e6 c1g5 h7h6 g5h4 g7g5 e4f6 e8e7 b2b4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 d2d4 e5d4 e1g1 f6e4 f1e1 d7d5 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 f8c5
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 b7b5
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6d4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6d4 c2c3 b7b5 c4f1 f6d5 g5e4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 f6d5 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 f6d5 d2d4 f8b4
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 f6d5 g5f7
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 f6d5 g5f7 e8f7 d1f3 f7e6 b1c3 c6b4 f3e4 c7c6 a2a3 b4a6 d2d4 a6c7
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 f6d5 g5f7 e8f7 d1f3 f7e6 b1c3 c6e7
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 d2d3
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 d2d3 h7h6 g5f3 e5e4 d1e2 a5c4 d3c4 f8c5 f3d2
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 d2d3 h7h6 g5f3 e5e4 d1e2 a5c4 d3c4 f8e7
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5 c7c6 d5c6 b7c6 d1f3
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5 c7c6 d5c6 b7c6 d1f3 d8c7 b5d3
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5 c7c6 d5c6 b7c6 d1f3 a8b8
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5 c7c6 d5c6 b7c6 d1f3 c6b5
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5 c7c6 d5c6 b7c6 b5e2
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5 c7c6 d5c6 b7c6 b5e2 h7h6
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5 c7c6 d5c6 b7c6 b5e2 h7h6 g5f3 e5e4 f3e5 f8d6 d2d4 d8c7 c1d2
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5 c7c6 d5c6 b7c6 b5e2 h7h6 g5f3 e5e4 f3e5 d8c7
1.e2e4 e7e5 g1f3 b8c6 f1c4 g8f6 f3g5 d7d5 e4d5 c6a5 c4b5 c7c6 d5c6 b7c6 b5e2 h7h6 g5h3
1.e2e4 e7e5 g1f3 b8c6 f1b5
1.e2e4 e7e5 g1f3 b8c6 f1b5 f7f6
1.e2e4 e7e5 g1f3 b8c6 f1b5 c6a5
1.e2e4 e7e5 g1f3 b8c6 f1b5 f8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 d8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 g7g5
1.e2e4 e7e5 g1f3 b8c6 f1b5 g7g6
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8e7 b1c3 g7g6
1.e2e4 e7e5 g1f3 b8c6 f1b5 c6d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 c6d4 f3d4 e5d4 e1g1 g8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1b5 d7d6 d2d4 c8d7 b1c3 g8f6 b5c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 d7d6 d2d4 c8d7 c2c4
1.e2e4 e7e5 g1f3 b8c6 f1b5 f7f5
1.e2e4 e7e5 g1f3 b8c6 f1b5 f7f5 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 f8c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 f8c5 e1g1 c6d4 b2b4
1.e2e4 e7e5 g1f3 b8c6 f1b5 f8c5 c2c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 f8c5 c2c3 g8f6 e1g1 e8g8 d2d4 c5b6
1.e2e4 e7e5 g1f3 b8c6 f1b5 f8c5 c2c3 c5b6
1.e2e4 e7e5 g1f3 b8c6 f1b5 f8c5 c2c3 d8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 f8c5 c2c3 f7f5
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 d2d4 e5d4 e1g1
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 d2d3 c6e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 d2d3 c6e7 f3e5 c7c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 d2d3 d7d6 b5c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 d2d3 d7d6 c2c4
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 d2d3 f8c5 c1e3)
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f8c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 d7d6 d2d4 c8d7 b1c3 f8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 d7d6 d2d4 c8d7 b1c3 f8e7 f1e1 e8g8
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 d7d6 d2d4 c8d7 b1c3 f8e7 c1g5
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 d7d6 d2d4 c8d7 b1c3 f8e7 b5c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 d7d6 d2d4 c8d7 b1c3 e5d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 d7d6 d2d4 f6d7
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 e4d6 d4e5
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 e4d6 b5a4
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 f8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 f8e7 d1e2 e4d6 b5c6 b7c6 d4e5 d6b7 b1c3 e8g8 f1e1 b7c5 f3d4 c5e6 c1e3 e6d4 e3d4 c6c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 f8e7 d1e2 e4d6 b5c6 b7c6 d4e5 d6b7 c2c4
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 f8e7 d1e2 e4d6 b5c6 b7c6 d4e5 d6b7 b2b3
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 f8e7 d1e2 e4d6 b5c6 b7c6 d4e5 d6b7 f3d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 f8e7 d1e2 e4d6 b5c6 b7c6 d4e5 d6f5
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 f8e7 d1e2 d7d5
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 f8e7 d4e5
1.e2e4 e7e5 g1f3 b8c6 f1b5 g8f6 e1g1 f6e4 d2d4 a7a6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5c6 d7c6 d2d4 e5d4 d1d4 d8d4 f3d4 c8d7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5c6 d7c6 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5c6 d7c6 b1c3 f7f6 d2d3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5c6 d7c6 e1g1
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5c6 d7c6 e1g1 c8g4 h2h3 h7h5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5c6 d7c6 e1g1 f7f6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5c6 d7c6 e1g1 d8d6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g7g6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 c6d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 f8b4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 f8c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 b7b5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 b7b5 a4b3 f8c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 b7b5 a4b3 c6a5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 f7f5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 d2d4 b7b5 a4b3 c6d4 f3d4 e5d4 d1d4 c7c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 c2c4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 e1g1
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 a4c6 b7c6 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 a4c6 b7c6 d2d4 f7f6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 c2c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 c2c3 f7f5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 c2c3 f7f5 e4f5 c8f5 e1g1
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 c2c3 c8d7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 c2c3 c8d7 d2d4 g8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 d7d6 c2c3 c8d7 d2d4 g7g6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 a4c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 d1e2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 d1e2 b7b5 a4b3 f8e7 d2d4 d7d6 c2c3 c8g4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 d2d3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 d2d3 d7d6 c2c4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 b7b5 a4b3 f8e7 a2a4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 b7b5 a4b3 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 b7b5 a4b3 d7d6 f3g5 d6d5 e4d5 c6d4 f1e1 f8c5 e1e5 e8f8
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 b7b5 a4b3 c8b7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 d7d6 a4c6 b7c6 d2d4 c8g4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 d7d6 a4c6 b7c6 d2d4 f6e4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 d7d6 a4c6 b7c6 d2d4 f6e4 f1e1 f7f5 d4e5 d6d5 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d1e2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 e5d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 f3e5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 d4d5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 a2a4 c6d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 a2a4 c6d4 f3d4 e5d4 b1c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 c2c4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c6e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 b1d2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 b1d2 e4c5 c2c3 d5d4 f3g5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 d1e2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 d1e2 f8e7 f1d1 e8g8 c2c4 b5c4 b3c4 d8d7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 d1e2 f8e7 c2c4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 e4c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8c5 b1d2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8c5 b1d2 e8g8 b3c2 e4f2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8c5 d1d3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8c5 d1d3 c6e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8e7 b1d2 e8g8 d1e2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8e7 f1e1
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8e7 f1e1 e8g8 f3d4 d8d7 d4e6 f7e6 e1e4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f6e4 d2d4 b7b5 a4b3 d7d5 d4e5 c8e6 c2c3 f8e7 f1e1 e8g8 f3d4 c6e5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 d2d4 e5d4 e4e5 f6e4 c2c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 a4c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 d1e2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 d1e2 b7b5 a4b3 e8g8
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 d1e2 b7b5 a4b3 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 d7d6 c2c3 c6a5 b3c2 c7c5 d2d4 d8c7 h2h3 a5c6 d4d5 c6b8 b1d2 g7g5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 d7d6 c2c3 c6a5 b3c2 c7c5 d2d4 d8c7 a2a4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 d7d6 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 d7d6 d2d4 c6d4 f3d4 e5d4 d1d4 c7c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 c8b7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 a2a4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d5 e4d5 f6d5 f3e5 c6e5 e1e5 c7c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d5 e4d5 f6d5 f3e5 c6e5 e1e5 c7c6 b3d5 c6d5 d2d4 e7d6 e5e3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d5 e4d5 f6d5 f3e5 c6e5 e1e5 c7c6 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d5 e4d5 f6d5 f3e5 c6e5 e1e5 c7c6 d2d4 e7d6 e5e1 d8h4 g2g3 h4h3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d5 e4d5 f6d5 f3e5 c6e5 e1e5 c7c6 d2d4 e7d6 e5e1 d8h4 g2g3 h4h3 c1e3 c8g4 d1d3 a8e8 b1d2 e8e6 a2a4 h3h5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d5 e4d5 e5e4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 d2d3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 b3c2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 a2a3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 d2d4 c8g4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 a6a5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c8e6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 f6d7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c8b7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 h7h6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6b8
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6b8 d2d4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6b8 d2d4 b8d7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6b8 d2d4 b8d7 b1d2 c8b7 b3c2 c7c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6b8 d2d4 b8d7 f3h4
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2 c7c6 d2d4 d8c7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2 c7c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2 c7c5 d2d4 a5c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2 c7c5 d2d4 f6d7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2 c7c5 d2d4 d8c7
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2 c7c5 d2d4 d8c7 b1d2 c8d7 d2f1 f8e8 f1e3 g7g6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2 c7c5 d2d4 d8c7 b1d2 a5c6
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2 c7c5 d2d4 d8c7 b1d2 a5c6 d4c5
1.e2e4 e7e5 g1f3 b8c6 f1b5 a7a6 b5a4 g8f6 e1g1 f8e7 f1e1 b7b5 a4b3 e8g8 c2c3 d7d6 h2h3 c6a5 b3c2 c7c5 d2d4 d8c7 b1d2 c5d4 c3d4
1.d2d4 d7d5
1.d2d4 d7d5 c1f4
1.d2d4 d7d5 c1f4 c7c5
1.d2d4 d7d5 c1g5
1.d2d4 d7d5 e2e4
1.d2d4 d7d5 e2e3 g8f6 f1d3
1.d2d4 d7d5 b1c3
1.d2d4 d7d5 b1c3 c8g4
1.d2d4 d7d5 b1c3 g8f6 e2e4
1.d2d4 d7d5 b1c3 g8f6 e2e4 d5e4 f2f3 e4f3 g1f3 e7e6
1.d2d4 d7d5 b1c3 g8f6 e2e4 e7e5
1.d2d4 d7d5 b1c3 g8f6 c1g5
1.d2d4 d7d5 b1c3 g8f6 c1g5 c8f5 g5f6
1.d2d4 d7d5 b1c3 g8f6 c1g5 c8f5 f2f3
1.d2d4 d7d5 g1f3
1.d2d4 d7d5 g1f3 b8c6
1.d2d4 d7d5 g1f3 c7c5
1.d2d4 d7d5 g1f3 g8f6
1.d2d4 d7d5 g1f3 g8f6 c1f4
1.d2d4 d7d5 g1f3 g8f6 c1g5
1.d2d4 d7d5 g1f3 g8f6 e2e3
1.d2d4 d7d5 g1f3 g8f6 e2e3 e7e6
1.d2d4 d7d5 g1f3 g8f6 e2e3 e7e6 b1d2 c7c5 b2b3
1.d2d4 d7d5 g1f3 g8f6 e2e3 e7e6 f1d3
1.d2d4 d7d5 g1f3 g8f6 e2e3 e7e6 f1d3 c7c5 b2b3
1.d2d4 d7d5 g1f3 g8f6 e2e3 e7e6 f1d3 c7c5 c2c3
1.d2d4 d7d5 c2c4
1.d2d4 d7d5 c2c4 c8f5
1.d2d4 d7d5 c2c4 g8f6
1.d2d4 d7d5 c2c4 c7c5
1.d2d4 d7d5 c2c4 b8c6
1.d2d4 d7d5 c2c4 b8c6 b1c3 d5c4 g1f3
1.d2d4 d7d5 c2c4 e7e5
1.d2d4 d7d5 c2c4 e7e5 d4e5 d5d4 e2e3 f8b4 c1d2 d4e3
1.d2d4 d7d5 c2c4 e7e5 d4e5 d5d4 g1f3
1.d2d4 d7d5 c2c4 e7e5 d4e5 d5d4 g1f3 b8c6 b1d2
1.d2d4 d7d5 c2c4 e7e5 d4e5 d5d4 g1f3 b8c6 b1d2 c8g4 h2h3 g4f3 d2f3 f8b4 c1d2 d8e7
1.d2d4 d7d5 c2c4 e7e5 d4e5 d5d4 g1f3 b8c6 b1d2 f7f6
1.d2d4 d7d5 c2c4 e7e5 d4e5 d5d4 g1f3 b8c6 b1d2 d8e7
1.d2d4 d7d5 c2c4 e7e5 d4e5 d5d4 g1f3 b8c6 g2g3
1.d2d4 d7d5 c2c4 c7c6
1.d2d4 d7d5 c2c4 c7c6 b1c3 d5c4 e2e4
1.d2d4 d7d5 c2c4 c7c6 b1c3 e7e5
1.d2d4 d7d5 c2c4 c7c6 c4d5
1.d2d4 d7d5 c2c4 c7c6 g1f3
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1d2
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 e2e3
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 e2e3 c8f5
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 e2e3 c8f5 c4d5 c6d5 d1b3 d8c8 c1d2 e7e6 b1a3
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 e2e3 c8f5 c4d5 c6d5 b1c3
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 e2e3 c8f5 c4d5 c6d5 b1c3 e7e6 f3e5 f6d7
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 c4d5 c6d5
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 c4d5 c6d5 b1c3 b8c6 c1f4 c8f5
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 c4d5 c6d5 b1c3 b8c6 c1f4 c8f5 e2e3 e7e6 d1b3 f8b4
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d8b6
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 g7g6
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 e2e3
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 e2e4
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 e2e4 b7b5 e4e5
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 b8a6 e2e4 c8g4
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 e7e6
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8g4
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8f5
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8f5 f3e5
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8f5 f3e5 b8d7 e5c4 d8c7 g2g3 e7e5
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8f5 f3e5 e7e6
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8f5 e2e3
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8f5 e2e3 b8a6
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8f5 e2e3 e7e6 f1c4 f8b4 e1g1
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8f5 e2e3 e7e6 f1c4 f8b4 e1g1 e8g8 d1e2
1.d2d4 d7d5 c2c4 c7c6 g1f3 g8f6 b1c3 d5c4 a2a4 c8f5 e2e3 e7e6 f1c4 f8b4 e1g1 e8g8 d1e2 f6e4 g2g4
1.d2d4 d7d5 c2c4 d5c4
1.d2d4 d7d5 c2c4 d5c4 e2e4
1.d2d4 d7d5 c2c4 d5c4 e2e4 c7c5 d4d5 g8f6 b1c3 b7b5
1.d2d4 d7d5 c2c4 d5c4 e2e4 f7f5
1.d2d4 d7d5 c2c4 d5c4 g1f3
1.d2d4 d7d5 c2c4 d5c4 g1f3 b7b5
1.d2d4 d7d5 c2c4 d5c4 g1f3 a7a6 e2e4
1.d2d4 d7d5 c2c4 d5c4 g1f3 a7a6
1.d2d4 d7d5 c2c4 d5c4 g1f3 a7a6 e2e3 c8g4 f1c4 e7e6 d4d5
1.d2d4 d7d5 c2c4 d5c4 g1f3 a7a6 e2e3 b7b5
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 d1a4
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 b1c3
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 b1c3 a7a6 e2e4
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 g7g6
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 c8g4
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 c8e6
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 d1e2 a7a6 d4c5 f8c5 e1g1 b8c6 e3e4 b7b5 e4e5
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1 c5d4
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1 a7a6
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1 a7a6 a2a4
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1 a7a6 e3e4
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1 a7a6 d1e2
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1 a7a6 d1e2 b7b5
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1 a7a6 d1e2 b7b5 c4b3 b8c6 f1d1 c5c4 b3c2 c6b4 b1c3 b4c2 e2c2 c8b7 d4d5 d8c7
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1 a7a6 d1e2 b7b5 c4b3 c8b7
1.d2d4 d7d5 c2c4 d5c4 g1f3 g8f6 e2e3 e7e6 f1c4 c7c5 e1g1 a7a6 d1e2 b7b5 c4b3 c8b7 f1d1 b8d7 b1c3 f8d6
1.d2d4 d7d5 c2c4 e7e6
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 e2e3 c7c6 b1d2
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 e2e3 c7c6 b1d2 f6e4 f1d3 f7f5
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 e2e3 c7c6 b1d2 b8d7
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 e2e3 c7c6 b1d2 b8d7 f1d3 c6c5
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 e2e3 c7c6 b1d2 g7g6
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 c1g5
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 c1g5 b8d7 e2e3 c7c6 b1d2
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 c1g5 f8b4
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 c1g5 h7h6
1.d2d4 d7d5 c2c4 e7e6 g1f3 g8f6 c1g5 h7h6 g5f6 d8f6 b1c3 c7c6 d1b3
1.d2d4 d7d5 c2c4 e7e6 b1c3
1.d2d4 d7d5 c2c4 e7e6 b1c3 a7a6
1.d2d4 d7d5 c2c4 e7e6 b1c3 b7b6
1.d2d4 d7d5 c2c4 e7e6 b1c3 f8e7
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c6
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c6 g1f3 d5c4
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c6 g1f3 d5c4 a2a4 f8b4 e2e3 b7b5 c1d2 d8e7
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c6 g1f3 d5c4 a2a4 f8b4 e2e3 b7b5 c1d2 d8b6
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c6 g1f3 d5c4 a2a4 f8b4 e2e3 b7b5 c1d2 a7a5
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c6 e2e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 c5d4
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 d4c5 d5d4 c3a4 b7b5
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 e2e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 c5c4
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 c5c4 e2e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 g8f6
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 g8f6 f1g2 c8g4
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 g8f6 f1g2 f8e7
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 g8f6 f1g2 f8e7 e1g1 e8g8
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 g8f6 f1g2 f8e7 e1g1 e8g8 d4c5 e7c5 c3a4
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 g8f6 f1g2 f8e7 e1g1 e8g8 c1g5
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 g8f6 f1g2 f8e7 e1g1 e8g8 c1g5 c8e6 a1c1 c5c4
1.d2d4 d7d5 c2c4 e7e6 b1c3 c7c5 c4d5 e6d5 g1f3 b8c6 g2g3 g8f6 f1g2 f8e7 e1g1 e8g8 c1g5 c8e6 a1c1 b7b6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1f4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c4d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c4d5 e6d5 g1f3 b8d7 c1f4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c4d5 e6d5 c1g5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c4d5 e6d5 c1g5 f8e7 e2e3 e8g8 f1d3 b8d7 d1c2 f8e8 g1e2 d7f8 e1c1
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c4d5 e6d5 c1g5 c7c6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c4d5 e6d5 c1g5 c7c6 d1c2
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 f8e7 c1f4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 f8b4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 f8b4 c1g5 d5c4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c5 e2e3 b8c6 f1d3 f8d6 e1g1 e8g8
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c5 e2e3 b8c6 f1d3 f8d6 e1g1 e8g8 d1e2 d8e7 d4c5 d6c5 e3e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c5 c1g5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c5 c4d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c5 c4d5 f6d5 e2e4 d5c3 b2c3 c5d4 c3d4 f8b4 c1d2 b4d2 d1d2 e8g8 f1b5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c5 c4d5 f6d5 e2e4 d5c3 b2c3 c5d4 c3d4 f8b4 c1d2 d8a5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c5 c4d5 f6d5 e2e3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c5 c4d5 f6d5 e2e3 b8c6 f1d3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 c1g5 h7h6 g5f6 d8f6 d1b3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 c1g5 d5c4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 c1g5 d5c4 e2e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 c1g5 d5c4 e2e4 b7b5 e4e5 h7h6 g5h4 g7g5 e5f6 g5h4 f3e5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 c1g5 d5c4 e2e4 b7b5 e4e5 h7h6 g5h4 g7g5 f3g5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 c1g5 d5c4 e2e4 b7b5 e4e5 h7h6 g5h4 g7g5 f3g5 h6g5 h4g5 b8d7 g2g3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 c1g5 d5c4 e2e4 b7b5 e4e5 h7h6 g5h4 g7g5 f3g5 h6g5 h4g5 b8d7 d1f3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 c1g5 d5c4 e2e4 b7b5 e4e5 h7h6 g5h4 g7g5 f3g5 f6d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 f6e4 f1d3 f7f5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 a7a6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 d1c2
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f3e5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 f8e7
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 f8b4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 f8d6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 b5b4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 c8b7
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 b5b4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 c6c5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 c6c5 d4d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 c6c5 e4e5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 c6c5 e4e5 c5d4 c3b5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 c6c5 e4e5 c5d4 c3b5 f6g4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 c6c5 e4e5 c5d4 c3b5 d7e5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 c6c5 e4e5 c5d4 c3b5 d7e5 f3e5 a6b5 d1f3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 c6c5 e4e5 c5d4 c3b5 d7e5 f3e5 a6b5 e1g1
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 g1f3 c7c6 e2e3 b8d7 f1d3 d5c4 d3c4 b7b5 c4d3 a7a6 e3e4 c6c5 e4e5 c5d4 c3b5 d7e5 f3e5 a6b5 e1g1 d8d5 d1e2 c8a6 c1g5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 c7c5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 c7c5 g1f3 c5d4 f3d4 e6e5 d4b5 a7a6 d1a4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 c7c5 g1f3 c5d4 d1d4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 c7c5 c4d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 c7c5 c4d5 d8b6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 g1f3 c7c6 a1c1 d8a5 g5d2
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 g1f3 c7c6 e2e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 f8b4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6 a2a3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6 g1f3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6 g1f3 d8a5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6 g1f3 d8a5 f3d2 f8b4 d1c2
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6 g1f3 d8a5 f3d2 f8b4 d1c2 e8g8 g5h4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6 g1f3 d8a5 f3d2 d5c4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6 g1f3 d8a5 g5f6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6 g1f3 d8a5 c4d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b8d7 e2e3 c7c6 g1f3 d8a5 c4d5 f6d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 f6e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 a1c1
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b7b6 f1d3 c8b7 c4d5 e6d5 f3e5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5f6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5f6 e7f6 a1c1 c7c6 f1d3 b8d7 e1g1 d5c4 d3c4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5h4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5h4 f6e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5h4 f6e4 h4e7 d8e7 d1c2
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5h4 f6e4 h4e7 d8e7 d1c2 e4f6 f1d3 d5c4 d3c4 c7c5 e1g1 b8c6 f1d1 c8d7
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5h4 f6e4 h4e7 d8e7 c4d5 e4c3 b2c3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5h4 f6e4 h4e7 d8e7 c4d5 e4c3 b2c3 e6d5 d1b3 e7d6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5h4 b7b6 
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5h4 b7b6 c4d5 f6d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 h7h6 g5h4 b7b6 c4d5 f6d5 h4e7 d8e7 c3d5 e6d5 a1c1 c8e6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 f1d3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 d1b3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 d1c2
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 d1c2 c7c5 c4d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 b7b6 c4d5 e6d5 f1d3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 b7b6 c4d5 e6d5 f1b5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 a7a6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 a7a6 c4d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 d1c2
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 d1c2 f6e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 d1c2 a7a6
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 d1c2 a7a6 a2a3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 d1c2 a7a6 c4d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 b7b5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 f6d5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 f6d5 h2h4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 f6d5 g5e7 d8e7
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 f6d5 g5e7 d8e7 c3e4
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 f6d5 g5e7 d8e7 e1g1
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 f6d5 g5e7 d8e7 e1g1 d5c3 c1c3 e6e5
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 f6d5 g5e7 d8e7 e1g1 d5c3 c1c3 e6e5 d1b1
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 f6d5 g5e7 d8e7 e1g1 d5c3 c1c3 e6e5 d1c2
1.d2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 f8e7 e2e3 e8g8 g1f3 b8d7 a1c1 c7c6 f1d3 d5c4 d3c4 f6d5 g5e7 d8e7 e1g1 d5c3 c1c3 e6e5 d4e5 d7e5 f3e5 e7e5
1.d2d4 g8f6 c2c4 g7g6 f2f3 d7d5
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 c4d5 f6d5
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 c4d5 f6d5 e2e4 d5b6 g1e2
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 g1f3
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 g1f3 e8g8 c4d5 f6d5 e1g1
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 g1f3 e8g8 c4d5 f6d5 e1g1 c7c5 b1c3
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 g1f3 e8g8 c4d5 f6d5 e1g1 c7c5 d4c5
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 g1f3 e8g8 c4d5 f6d5 e1g1 d5b6
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 g1f3 e8g8 e1g1
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 g1f3 e8g8 e1g1 c7c6
1.d2d4 g8f6 c2c4 g7g6 g2g3 d7d5 f1g2 f8g7 g1f3 e8g8 e1g1 c7c6 c4d5 c6d5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g2g4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c1g5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c1g5 f6e4 c3e4 d5e4 d1d2 c7c5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 d1b3
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c1f4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c1f4 f8g7 e2e3 e8g8
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c1f4 f8g7 e2e3 e8g8 a1c1
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c1f4 f8g7 e2e3 e8g8 a1c1 c7c5 d4c5 c8e6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c1f4 f8g7 e2e3 e8g8 c4d5 f6d5 c3d5 d8d5 f4c7
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 g1f3
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 f1c4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 f1c4 e8g8 g1e2 d8d7 e1g1 b7b6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 f1c4 e8g8 g1e2 b7b6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 f1c4 e8g8 g1e2 b8c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 f1c4 e8g8 g1e2 c7c5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 f1c4 e8g8 g1e2 c7c5 e1g1 b8c6 c1e3 c8g4 f2f3 c6a5 c4f7
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 f1c4 e8g8 g1e2 c7c5 e1g1 b8c6 c1e3 c5d4 c3d4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 f1c4 e8g8 g1e2 c7c5 e1g1 b8c6 c1e3 c5d4 c3d4 c8g4 f2f3 c6a5 c4d3 g4e6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 c4d5 f6d5 e2e4 d5c3 b2c3 f8g7 f1c4 e8g8 g1e2 c7c5 e1g1 b8c6 c1e3 c5d4 c3d4 c8g4 f2f3 c6a5 c4d3 g4e6 d4d5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 c7c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1a4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 c1g5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 c1f4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 c1f4 e8g8 e2e3
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 e2e3
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 e2e3 e8g8 b2b4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 e2e3 e8g8 c1d2
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 e2e3 e8g8 f1d3
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 e2e3 e8g8 f1d3 c7c6 e1g1 c8g4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 e2e3 e8g8 f1d3 c7c6 e1g1 c8f5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 e2e3 e8g8 d1b3
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 e2e3 e8g8 d1b3 e7e6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 e2e3 e8g8 d1b3 d5c4 f1c4 b8d7 f3g5
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4 a7a6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4 c7c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4 b7b6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4 b8c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4 b8a6
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4 c8g4
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4 c8g4 c1e3 f6d7 f1e2 d7b6 c4d3 b8c6 e1c1
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4 c8g4 c1e3 f6d7 c4b3
1.d2d4 g8f6 c2c4 g7g6 b1c3 d7d5 g1f3 f8g7 d1b3 d5c4 b3c4 e8g8 e2e4 c8g4 c1e3 f6d7 c4b3 c7c5
1.d2d4 g8f6 c2c4 e7e6
1.d2d4 g8f6 c2c4 e7e6 c1g5
1.d2d4 g8f6 c2c4 e7e6 g2g3
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 d5c4 d1a4
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 d5c4 d1a4 b8d7 a4c4 a7a6 c4c2
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 d5c4 d1a4 b8d7 a4c4
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 d5c4 g1f3
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 d5c4 g1f3 f8e7
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 f8e7 g1f3
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 f8e7 g1f3 e8g8 e1g1 b8d7
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 f8e7 g1f3 e8g8 e1g1 b8d7 b1c3 c7c6 d1d3
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 f8e7 g1f3 e8g8 e1g1 b8d7 d1c2
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 f8e7 g1f3 e8g8 e1g1 b8d7 d1c2 c7c6 f1d1 b7b6 a2a4
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 f8e7 g1f3 e8g8 e1g1 b8d7 d1c2 c7c6 b2b3
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 f8e7 g1f3 e8g8 e1g1 b8d7 d1c2 c7c6 b2b3 b7b6 f1d1 c8b7 b1c3 b6b5
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 f8e7 g1f3 e8g8 e1g1 b8d7 d1c2 c7c6 b1d2
1.d2d4 g8f6 c2c4 e7e6 g2g3 d7d5 f1g2 f8e7 g1f3 e8g8 e1g1 b8d7 d1c2 c7c6 b1d2 b7b6 b2b3 a7a5 c1b2 c8a6
1.d2d4 g8f6 c2c4 e7e6 g1f3
1.d2d4 g8f6 c2c4 e7e6 g1f3 c7c5 d4d5 b7b5
1.d2d4 g8f6 c2c4 e7e6 g1f3 c7c5 d4d5 b7b5 d5e6 f7e6 c4b5 d7d5
1.d2d4 g8f6 c2c4 e7e6 g1f3 c7c5 d4d5 b7b5 c1g5
1.d2d4 g8f6 c2c4 e7e6 g1f3 c7c5 d4d5 b7b5 c1g5 e6d5 c4d5 h7h6
1.d2d4 g8f6 c2c4 e7e6 g1f3 a7a6
1.d2d4 g8f6 c2c4 e7e6 g1f3 f6e4
1.d2d4 g8f6 c2c4 e7e6 g1f3 f8b4
1.d2d4 g8f6 c2c4 e7e6 g1f3 f8b4 b1d2
1.d2d4 g8f6 c2c4 e7e6 g1f3 f8b4 c1d2 d8e7
1.d2d4 g8f6 c2c4 e7e6 g1f3 f8b4 c1d2 b4d2 d1d2 b7b6 g2g3 c8b7 f1g2 e8g8 b1c3 f6e4 d2c2 e4c3 f3g5
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 c1f4
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 a2a3
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 b1c3
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 b1c3 c8b7 c1g5 h7h6 g5h4 g7g5 h4g3 f6h5
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 b1c3 c8b7 c1g5 h7h6 g5h4 f8b4
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 e2e3
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 e2e3 c8b7 f1d3 c7c5 e1g1 f8e7 b2b3 e8g8 c1b2 c5d4 f3d4
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8a6
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 c7c5 d4d5 e6d5 f3h4
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 c7c5 d4d5 e6d5 f3g5
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8b4
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8b4 c1d2 a7a5
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8b4 c1d2 b4e7
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8e7
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8e7 b1c3
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8e7 b1c3 f6e4 c1d2
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8e7 e1g1
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8e7 e1g1 e8g8 b2b3
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8e7 e1g1 e8g8 b1c3
1.d2d4 g8f6 c2c4 e7e6 g1f3 b7b6 g2g3 c8b7 f1g2 f8e7 e1g1 e8g8 b1c3 f6e4 d1c2 e4c3 c2c3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 f2f3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1d3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 g2g3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 g1f3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 g1f3 c7c5 d4d5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 g1f3 c7c5 d4d5 f6e4
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1b3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1b3 c7c5 d4c5 b8c6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1b3 c7c5 d4c5 b8c6 g1f3 f6e4 c1d2 e4d2
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1b3 c7c5 d4c5 b8c6 g1f3 f6e4 c1d2 e4c5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1b3 c7c5 d4c5 b8c6 g1f3 f6e4 c1d2 e4c5 b3c2 f7f5 g2g3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 c7c5 f2f3 d7d5 e2e3 e8g8 c4d5 f6d5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 c7c5 f2f3 d7d5 c4d5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 c7c5 f2f3 d7d5 c4d5 f6d5 d4c5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 c7c5 f2f3 d7d5 c4d5 f6d5 d4c5 f7f5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 c7c5 e2e3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 c7c5 e2e3 b7b6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 e8g8
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 e8g8 e2e3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 e8g8 e2e3 c7c5 f1d3 b8c6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 a2a3 b4c3 b2c3 e8g8 e2e3 c7c5 f1d3 b8c6 g1e2 b7b6 e3e4 f6e8
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 c1g5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 c1g5 h7h6 g5h4 c7c5 d4d5 b7b5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 c1g5 h7h6 g5h4 c7c5 d4d5 d7d6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 e8g8 a2a3 b4c3 c2c3 b7b5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 b8c6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 b8c6 g1f3 d7d6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 d7d5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 d7d5 c4d5 e6d5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 d7d5 a2a3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 d7d5 a2a3 b4c3 c2c3 b8c6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 d7d5 a2a3 b4c3 c2c3 f6e4
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 d7d5 a2a3 b4c3 c2c3 f6e4 c3c2
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 d7d5 a2a3 b4c3 c2c3 f6e4 c3c2 b8c6 e2e3 e6e5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 c7c5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 d1c2 c7c5 d4c5 e8g8
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 b8c6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 c7c5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 c7c5 f1d3 b8c6 g1f3 b4c3 b2c3 d7d6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 c7c5 g1e2
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 b7b6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 b7b6 g1e2
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 b7b6 g1e2 c8a6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1e2
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1e2 d7d5 a2a3 b4d6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 f1d3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 f1d3 d7d5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 f1d3 d7d5 a2a3 b4c3 b2c3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 b8c6 e1g1 d5c4
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 b7b6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5 e1g1 b7b6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5 e1g1 b8d7
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5 e1g1 d5c4 d3c4
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5 e1g1 d5c4 d3c4 d8e7
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5 e1g1 d5c4 d3c4 b8d7
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5 e1g1 b8c6
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5 e1g1 b8c6 a2a3 d5c4 d3c4 c5d4
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5 e1g1 b8c6 a2a3 b4c3 b2c3
1.d2d4 g8f6 c2c4 e7e6 b1c3 f8b4 e2e3 e8g8 g1f3 d7d5 f1d3 c7c5 e1g1 b8c6 a2a3 b4c3 b2c3 d5c4 d3c4
1.d2d4 g8f6 c2c4 g7g6
1.d2d4 g8f6 c2c4 g7g6 g1f3
1.d2d4 g8f6 c2c4 g7g6 d1c2
1.d2d4 g8f6 c2c4 g7g6 d4d5
1.d2d4 g8f6 c2c4 g7g6 d4d5 b7b5
1.d2d4 g8f6 c2c4 g7g6 g2g3
1.d2d4 g8f6 c2c4 g7g6 g2g3 f8g7 f1g2 d7d5
1.d2d4 g8f6 c2c4 g7g6 b1c3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 c1g5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 c7c6 e1g1 c8f5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 c7c6 e1g1 d8a5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 b8c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 b8c6 e1g1 e7e5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 b8c6 e1g1 c8f5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 b8c6 e1g1 c8g4
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 b8c6 e1g1 a7a6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 c7c5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 c7c5 e1g1
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 c7c5 e1g1 b8c6 d4d5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 b8d7
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 b8d7 e1g1 e7e5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 b8d7 e1g1 e7e5 e2e4
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 g1f3 d7d6 g2g3 e8g8 f1g2 b8d7 e1g1 e7e5 e2e4 c7c6 h2h3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1e2
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 c1g5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 h2h3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g2g3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g2g3 e8g8 f1g2 e7e5 g1e2
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f1e2
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f1e2 e8g8 c1e3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f1e2 e8g8 c1g5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f1e2 e8g8 c1g5 c7c5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f1e2 e8g8 c1g5 c7c5 d4d5 e7e6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f4
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f4 e8g8 g1f3 c7c5 d4d5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f4 e8g8 f1e2
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f4 e8g8 f1e2 c7c5 d4d5 e7e6 d5e6 f7e6 g2g4 b8c6 h2h4
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f4 e8g8 f1e2 c7c5 d4d5 e7e6 g1f3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f4 e8g8 f1e2 c7c5 d4d5 e7e6 g1f3 e6d5 e4e5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f4 e8g8 f1e2 c7c5 g1f3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f4 e8g8 f1e2 c7c5 g1f3 c5d4 f3d4 b8c6 c1e3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 c7c6 f1d3 a7a6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 b7b6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 b8c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 b8c6 g1e2 a8b8
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 b8c6 g1e2 a7a6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 b8c6 g1e2 a7a6 d1d2 a8b8
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 e7e5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 e7e5 g1e2 c7c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 e7e5 d4d5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 e7e5 d4d5 f6h5 d1d2 d8h4 g2g3 h5g3 d2f2 g3f1 f2h4 f1e3 e1e2 e3c4
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 e7e5 d4d5 c7c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 f2f3 e8g8 c1e3 e7e5 d4d5 c7c6 g1e2 c6d5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 c1e3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 c1g5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 b8a6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 d4e5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 c1e3
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 d4d5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 d4d5 a7a5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 d4d5 b8d7
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 d4d5 b8d7 c1g5 h7h6 g5h4 g6g5 h4g3 f6h5 h2h4
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1 c7c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1 b8d7
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1 b8d7 f1e1
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1 b8d7 f1e1 c7c6 e2f1 a7a5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1 b8c6
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1 b8c6 d4d5 c6e7 b2b4
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1 b8c6 d4d5 c6e7 f3e1
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1 b8c6 d4d5 c6e7 f3e1 f6d7 f2f3 f7f5
1.d2d4 g8f6 c2c4 g7g6 b1c3 f8g7 e2e4 d7d6 g1f3 e8g8 f1e2 e7e5 e1g1 b8c6 d4d5 c6e7 f3e1 f6d7 f2f3 f7f5 g2g4";
	}
	
	public static function listToArray():Void
	{
		Reg._ecoOpeningsNames = Reg._ecoOpeningsNamesTemp.split("\r\n");
		Reg._ecoOpeningsNotations = Reg._ecoOpeningsNotationsTemp.split("\r\n");
	}
}