# TicTacToeKit

iTIC TAC TOE - TDD

Traditional 3 x 3 TTT board board
2 players
Take in turn to place our token ( O or X )

First game : X first then O 
Game 2  : O than X .. and so on

TTT Game Manager -
 - State board
 - Who’s turn it is
 - Delegate .. for return comms
 
Return placement Result (ENUM??)
 - Valid placement ??? Think about associatedType
 - Invalid placement
 - Winning placement
 - Stalemate

Board Representation
Vacant
Occupied (player)


Enum Player {
 Case player1
 Case player2
}

[
 [ CellState.Vacant, CellState.Vacant, CellState.Vacant ],
 [ CellState.Vacant, CellState.Occupied(), CellState.Vacant  ],
 [ CellState.Vacant, CellState.Vacant, CellState.Vacant  ]
]

~ ~ ~
~ ~ ~
~ ~ ~

x x x
~ o ~
~ x ~


ENTITIES
TicTacToeModel Library

VC -> TTTGameManager
VC <- TTTGameManagerDelegate 

TTTGameManager
TTTGameManagerDelegate
TTTGameBoardRespresentation
TTTSquare 
Player
PlacementResult - Valid or Invalid(reason)



VC -> Create New Game (optionally with startingPlayer?)
VC <- BoardRepresentation (empty board)
VC -> Who is player (return PlayerO or PlayerX)
VC -> playerX select cell at location x, y
VC <- PlacementResult, BoardRepresentation
VC -> IsGameWon (return true(player))
VC -> IsGameStalemate (return Bool)	
….
VC > ResetGame ()



TicTacToeUI Library
UI - GameBoardBuilder
