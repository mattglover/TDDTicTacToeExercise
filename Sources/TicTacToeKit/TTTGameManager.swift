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
    
    func place(player: Player, x: Int, y: Int) {
        squares[0] = .occupiedPlayerOne
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
                string += "0"
            }
        }
        
        return string
    }
}
