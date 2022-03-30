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
    
    //MARK: - Making first plays
    func testFirstPlay_Player1MakesMove_0_0() {
        sut = Helper.defaultSUT()
        let player: Player = .player1
        sut.startGame(player: player)
        
        let outcome = sut.place(player: player, x: 0, y: 0)
        
        XCTAssertEqual(sut.gridRepresentationString, Constants.topLeftX_3x3)
        XCTAssertEqual(outcome.gridRepresentation, Constants.topLeftX_3x3)
        XCTAssertTrue(outcome.wasValid)
    }

    func testFirstPlay_Player1MakesMove_0_0_SwitchesCurrentPlayerToPlayer2() {
        sut = Helper.defaultSUT()
        let player: Player = .player1
        sut.startGame(player: player)
        let _ = sut.place(player: player, x: 0, y: 0)

        let currentPlayer = sut.currentPlayer

        XCTAssertEqual(currentPlayer, .player2)
    }

    func testFirstPlay_Player1MakesMoveOutsideOfGrid() {
        sut = Helper.defaultSUT()
        let player: Player = .player1
        sut.startGame(player: player)

        let testCoordinates: [(x: Int, y: Int)] = [
            (-1, 0),
            (0, -1),
            (-1, -1),
            (3, 0),
            (0, 3),
            (3, 3),
        ]

        for testCoordinate in testCoordinates {
            let outcome = sut.place(player: player, x: testCoordinate.x, y: testCoordinate.y)
            XCTAssertFalse(outcome.wasValid)
            XCTAssertEqual(sut.currentPlayer, .player1)
        }

    }

    //MARK: - Making second plays
    func testSecondPlay_Player2MakesMove_0_1() {
        sut = Helper.defaultSUT()
        sut.startGame(player: .player1)
        let _ = sut.place(player: .player1, x: 0, y: 0)

        let outcome = sut.place(player: .player2, x: 0, y: 1)

        XCTAssertEqual(outcome.gridRepresentation, Constants.XO_3x3)
    }

    func testSecondPlay_Player2MakeMove_OccupiedSquare() {
        sut = Helper.defaultSUT()
        sut.startGame(player: .player1)
        let _ = sut.place(player: .player1, x: 0, y: 0)

        let outcome = sut.place(player: .player2, x: 0, y: 0)

        XCTAssertFalse(outcome.wasValid)
        XCTAssertEqual(outcome.gridRepresentation, Constants.topLeftX_3x3)
    }

    func testSecondPlay_PlayerOneFollowsPlayer1() {
        sut = Helper.defaultSUT()
        sut.startGame(player: .player1)
        let _ = sut.place(player: .player1, x: 0, y: 0)

        let outcome = sut.place(player: .player1, x: 0, y: 1)

        XCTAssertFalse(outcome.wasValid)
        XCTAssertEqual(outcome.gridRepresentation, Constants.topLeftX_3x3)
    }

    //MARK: - Winning Plays

    func testPlayerOneWinsGame_RowWin() {
        sut = Helper.defaultSUT()
        sut.startGame(player: .player1)
        let _ = sut.place(player: .player1, x: 0, y: 0)
        let _ = sut.place(player: .player2, x: 2, y: 2)
        let _ = sut.place(player: .player1, x: 0, y: 1)
        let _ = sut.place(player: .player2, x: 2, y: 1)

        let outcome = sut.place(player: .player1, x: 0, y: 2)

        XCTAssertTrue(outcome.wasValid)
        XCTAssertEqual(outcome.endGame, .win)
        XCTAssertEqual(outcome.gridRepresentation, Constants.topRowX_Win)
    }

    func testPlayerTwoWinsGame_RowWin() {
        sut = Helper.defaultSUT()
        sut.startGame(player: .player2)
        let _ = sut.place(player: .player2, x: 0, y: 0)
        let _ = sut.place(player: .player1, x: 2, y: 2)
        let _ = sut.place(player: .player2, x: 0, y: 1)
        let _ = sut.place(player: .player1, x: 2, y: 1)

        let outcome = sut.place(player: .player2, x: 0, y: 2)

        XCTAssertEqual(outcome.endGame, .win)
    }

    func testPlayerOneWinsGame_DiagonalWin() {
        sut = Helper.defaultSUT()
        sut.startGame(player: .player1)
        let _ = sut.place(player: .player1, x: 0, y: 0)
        let _ = sut.place(player: .player2, x: 0, y: 1)
        let _ = sut.place(player: .player1, x: 1, y: 1)
        let _ = sut.place(player: .player2, x: 0, y: 2)

        let outcome = sut.place(player: .player1, x: 2, y: 2)

        XCTAssertTrue(outcome.wasValid)
        XCTAssertEqual(outcome.endGame, .win)
        XCTAssertEqual(outcome.gridRepresentation, Constants.X_DiagonalWin)
    }

    func testPlayerTwoWinsGame_DiagonalWin() {
        sut = Helper.defaultSUT()
        sut.startGame(player: .player2)
        let _ = sut.place(player: .player2, x: 0, y: 0)
        let _ = sut.place(player: .player1, x: 0, y: 1)
        let _ = sut.place(player: .player2, x: 1, y: 1)
        let _ = sut.place(player: .player1, x: 0, y: 2)

        let outcome = sut.place(player: .player2, x: 2, y: 2)

        XCTAssertEqual(outcome.endGame, .win)
    }

    func testPlayerOneWinsGame_ColumnWin() {
        sut = Helper.defaultSUT()
        sut.startGame(player: .player1)
        let _ = sut.place(player: .player1, x: 0, y: 0)
        let _ = sut.place(player: .player2, x: 0, y: 1)
        let _ = sut.place(player: .player1, x: 1, y: 0)
        let _ = sut.place(player: .player2, x: 0, y: 2)

        let outcome = sut.place(player: .player1, x: 2, y: 0)

        XCTAssertTrue(outcome.wasValid)
        XCTAssertEqual(outcome.endGame, .win)
        XCTAssertEqual(outcome.gridRepresentation, Constants.X_ColumnWin)
    }

    func testPlayerTwoWinsGame_ColumnWin() {
        sut = Helper.defaultSUT()
        sut.startGame(player: .player2)
        let _ = sut.place(player: .player2, x: 0, y: 0)
        let _ = sut.place(player: .player1, x: 0, y: 1)
        let _ = sut.place(player: .player2, x: 1, y: 0)
        let _ = sut.place(player: .player1, x: 0, y: 2)

        let outcome = sut.place(player: .player2, x: 2, y: 0)

        XCTAssertEqual(outcome.endGame, .win)
    }

    func testStalemate() {
//        sut = Helper.defaultSUT()
//        sut.startGame(player: .player1)
//        let _ = sut.place(player: .player1, x: 0, y: 0)
//        let _ = sut.place(player: .player2, x: 0, y: 1)
//        let _ = sut.place(player: .player1, x: 1, y: 0)
//        let _ = sut.place(player: .player2, x: 0, y: 2)
//
//        let outcome = sut.place(player: .player1, x: 2, y: 0)
//
//        XCTAssertTrue(outcome.wasValid)
//        XCTAssertEqual(outcome.endGame, .win)
//        XCTAssertEqual(outcome.gridRepresentation, Constants.X_ColumnWin)
        XCTFail("To be implemented")
    }

    /*
     XXO
     OXX
     XOO
     */
    
}

extension TTTGameManagerTests {
    struct Constants {
        static let empty_3x3 = "~~~\n~~~\n~~~"
        static let topLeftX_3x3 = "X~~\n~~~\n~~~"
        static let XO_3x3 = "XO~\n~~~\n~~~"
        static let topRowX_Win = "XXX\n~~~\n~OO"
        static let X_DiagonalWin = "XOO\n~X~\n~~X"
        static let X_ColumnWin = "XOO\nX~~\nX~~"
    }

    struct Helper {
        static func defaultSUT() -> TTTGameManager {
            return TTTGameManager(gridSize: 3)
        }
    }
}
