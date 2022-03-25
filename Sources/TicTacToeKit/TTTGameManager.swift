import Foundation

enum Player {
    case player1
    case player2
}

enum SquareState {
    case occupiedPlayerOne
    case occupiedPlayerTwo
    case vacant
}

enum EndGameStatus {
    case win
    case stalemate
}

struct PlacementOutcome {
    var wasValid: Bool
    var gridRepresentation: String
    var endGame: EndGameStatus?
}

class TTTGameManager {
    
    private(set) var gridSize: Int!
    private(set) var currentPlayer: Player?
    
    private var squares: [SquareState] = []
    
    convenience init(gridSize: Int) {
        self.init()
        self.gridSize = gridSize
        self.squares = Array(repeating: .vacant, count: gridSize * gridSize)
    }
    
    func startGame(player: Player) {
        self.currentPlayer = player
    }
    
    func place(player: Player, x: Int, y: Int) -> PlacementOutcome {
        guard currentPlayer == player else {
            return placementOutcome(wasSuccessful: false)
        }

        guard isWithinBoundsOfArray(x: x, y: y, gridSize: gridSize) else {
            return placementOutcome(wasSuccessful: false)
        }

        let index = (x * gridSize) + y
        guard squares[index] == SquareState.vacant else {
            return placementOutcome(wasSuccessful: false)
        }

        let occupiedPlayer = player == .player1 ? SquareState.occupiedPlayerOne : SquareState.occupiedPlayerTwo
        squares[index] = occupiedPlayer

        let endGame = calculateEndGame()

        switch endGame {
        case .win:
            return placementOutcome(wasSuccessful: true, endGame: .win)
        case .stalemate:
            return placementOutcome(wasSuccessful: true, endGame: .stalemate)
        case .none:
            switchCurrentPlayer()
            return placementOutcome(wasSuccessful: true)
        }
    }

    private func placementOutcome(wasSuccessful success: Bool, endGame: EndGameStatus? = nil) -> PlacementOutcome {
        return PlacementOutcome(wasValid: success, gridRepresentation: gridRepresentationString, endGame: endGame)
    }

    private func isWithinBoundsOfArray(x: Int, y: Int, gridSize: Int) -> Bool {
        return x >= 0 && x < gridSize && y >= 0 && y < gridSize
    }

    private func calculateEndGame() -> EndGameStatus? {
        if hasRowWin() || hasDiagonalWin() {
            return .win
        }
        return nil
    }

    private func hasRowWin() -> Bool {
        return gridRepresentationString.contains("XXX") || gridRepresentationString.contains("OOO")
    }

    private func hasDiagonalWin() -> Bool {
        return squares[0] == .occupiedPlayerOne && squares[4] == .occupiedPlayerOne && squares[8] == .occupiedPlayerOne ||
        squares[2] == .occupiedPlayerOne && squares[4] == .occupiedPlayerOne && squares[6] == .occupiedPlayerOne
    }

    func switchCurrentPlayer() {
        switch currentPlayer {
        case .player1:
            self.currentPlayer = .player2
        case .player2:
            self.currentPlayer = .player1
        case .none:
            break
        }
    }
    
    var gridRepresentationString: String {
        var string = ""
        
        for (index, squareState) in squares.enumerated() {
            if index % gridSize == 0 && index > 0 {
                string += "\n"
            }
            
            if squareState == .vacant {
                string += "~"
            } else if squareState == .occupiedPlayerOne {
                string += "X"
            } else if squareState == .occupiedPlayerTwo {
                string += "O"
            }
        }
        
        return string
    }
}
