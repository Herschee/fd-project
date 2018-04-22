//
//  fd_projectTests.swift
//  fd-projectTests
//
//  Created by Henry Wrightman on 4/17/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import XCTest
@testable import fd_project

class fd_projectTests: XCTestCase {
    
    var ds: DataService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        ds = DataService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_gameQuery() {
        ds.loadData()
        
        let game = ds.loadDetailsForGame(game_id: 1)
        
        XCTAssert(game?.away_team == "Cavaliers")
        XCTAssert(game?.home_team == "Lakers")
        XCTAssert(game?.broadcast == "ESPN")
        XCTAssert(game?.game_status == "IN_PROGRESS")
        XCTAssert(game?.home_team_score == 78)
        XCTAssert(game?.away_team_score == 77)
        XCTAssert(game?.quarter == 4)
        XCTAssert(game?.time_left_in_quarter == "10:20")
        XCTAssertNil(game?.game_start)
        XCTAssert(game?.home_team_record == "40-20")
        XCTAssert(game?.away_team_record == "5-45")
    }
    
    func test_statQuery() {
        ds.loadData()

        let stat = ds.loadStatsForPlayer(id: 1)
        
        XCTAssert(stat?.assists == 10)
        XCTAssert(stat?.game_id == 1)
        XCTAssert(stat?.nerd == 10)
        XCTAssert(stat?.player == "Nick Young")
        XCTAssert(stat?.player_team == "LAL")
        XCTAssert(stat?.player_id == 1)
        XCTAssert(stat?.points == 20)
        XCTAssert(stat?.rebounds == 2)
        XCTAssert(stat?.team_id == 1)
    }
    
    func test_emptyGames() {
        ds.loadJson(filename: "emptyGames")
        XCTAssert(ds.games.count == 0)
    }
    
    func test_emptyStats() {
        ds.loadJson(filename: "emptyStats")
        XCTAssert(ds.stats.count == 0)
    }
    
    func test_emptyPlayers() {
        ds.loadJson(filename: "emptyPlayers")
        XCTAssert(ds.players.count == 0)
    }
    
    func test_emptyTeams() {
        ds.loadJson(filename: "emptyTeams")
        XCTAssert(ds.teams.count == 0)
    }
    
    func test_emptyGameStates() {
        ds.loadJson(filename: "emptyGameStates")
        XCTAssert(ds.game_states.count == 0)
    }
    
    func test_incompleteGameState() {
        ds.loadJson(filename: "incompleteGameStates")
        
        let game_state = ds.loadDetailsForGame(game_id: 1)
        XCTAssertNil(game_state)
    }
    
    func test_incompleteStat() {
        ds.loadJson(filename: "incompleteStat")
        
        let stat = ds.loadStatsForPlayer(id: 1)
        XCTAssertNil(stat)
    }
    
    
    /*func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
    
}
