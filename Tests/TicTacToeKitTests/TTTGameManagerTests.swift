import XCTest
@testable import TicTacToeKit

class TTTGameManagerTests: XCTestCase {

    var sut: TTTGameManager!
    
    //MARK: - Initialisation
    func testCanInstantiateWith3x3Grid() {
        sut = Helper.defaultSUT()
        
        XCTAssertNotNil(sut)
    }

    func testInstantiated3x3Grid_returnCorrectRepresentation_empty() {
        sut = Helper.defaultSUT()
        
        let gridRepresentationString = sut.gridRepresentationString
        
        XCTAssertEqual(gridRepresentationString, Constants.empty_3x3)
    }
    
    //MARK: - Starting Game
    func testCanStartGame_startingPlayer_Player1() {
        
        sut = Helper.defaultSUT()
        
        sut.startGame(player: .player1)
        
        XCTAssertEqual(sut.currentPlayer, .player1)
    }
    
    func testCanStartGame_startingPlayer_Player2() {
        
        sut = Helper.defaultSUT()
        
        sut.startGame(player: .player2)
        
        XCTAssertEqual(sut.currentPlayer, .player2)
    }
    
    //MARK: - Placing Token
    func testFirstPlay_Player1MakesMove_0_0() {
        sut = Helper.defaultSUT()
        let player: Player = .player1
        sut.startGame(player: player)
        
        sut.place(player: player, x: 0, y: 0)
        
        XCTAssertEqual(sut.gridRepresentationString, Constants.topLeftX_3x3)
    }
    
    struct Constants {
        static let empty_3x3 = "~~~\n~~~\n~~~"
//        static let centredO_3x3 = "~~~\n~o~\n~~~"
        static let topLeftX_3x3 = "X~~\n~~~\n~~~"
    }
    
    struct Helper {
        static func defaultSUT() -> TTTGameManager {
            return TTTGameManager(gridSize: 3)
        }
    }
}
