//
//  DataService.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation
import RxSwift
import Unbox

public enum T {
    case game
    case stat
    case team
}

class DataService: NSObject {
    
    /* json variables from data source */
    public var games: [Game] = []
    public var stats: [Stat] = []
    public var teams: [Team] = []
    public var game_states: [GameState] = []
    
    public var data_source: String!
    
    func loadDetailsForGame(game_id: Int) -> GameState {
        
        var game_state = game_states.filter { $0.game_id == game_id }.first
        let game = games.filter { $0.id == game_state?.game_id }.first
        
        /* foreign */
        let home_team = teams.filter { $0.id == game?.home_team_id }.first?.name
        let away_team = teams.filter { $0.id == game?.away_team_id }.first?.name
        game_state?.home_team = home_team
        game_state?.away_team = away_team

        return game_state!
    }
    
    func loadStatsForPlayer(player_id: Int) {
        
    }
    
    func parseData() {
        loadJson(filename: "basketballData")
    }
    
    func loadJson(filename fileName: String) {
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                games = try decoder.decode(GameResponseData.self, from: data).games
                stats = try decoder.decode(StatResponseData.self, from: data).player_stats
                teams = try decoder.decode(TeamResponseData.self, from: data).teams
                game_states = try decoder.decode(GameStateResponseData.self, from: data).game_states
            
            } catch {
                print("error:\(error)")
            }
        }

    }
}

/*open func fetchGameData() -> Observable<[Game]> {
 let observable = Observable<[Game]>.create { [weak self] observer in
 if let _self = self {
 let time = 0.5 + TimeInterval(arc4random_uniform(10)) / 10.0
 
 DispatchQueue.main.asyncAfter(deadline: .now() + time) {
 let shouldFail = arc4random_uniform(2) == 0
 if shouldFail {
 observer.onError(NSError(domain: "Example network failure.", code: 0, userInfo: nil))
 } else {
 observer.onNext(_self.parseData())
 observer.onCompleted()
 }
 }
 }
 
 return Disposables.create()
 }
 
 return observable.share(replay: 1)
 }*/

/*func fetchAppList(completion: @escaping ([NSDictionary]?) -> Void) {
 //3 - unwrap our API endpoint
 guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/100/explicit/json") else {
 print("Error unwrapping URL"); return }
 
 //4 - create a session and dataTask on that session to get data/response/error
 let session = URLSession.shared
 let dataTask = session.dataTask(with: url) { (data, response, error) in
 
 //5 - unwrap our returned data
 guard let unwrappedData = data else { print("Error getting data"); return }
 
 do {
 //6 - create an object for our JSON data and cast it as a NSDictionary
 // .allowFragments specifies that the json parser should allow top-level objects that aren't NSArrays or NSDictionaries.
 if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
 
 //7 - create an array of dictionaries from
 if let apps = responseJSON.value(forKeyPath: "feed.results") as? [NSDictionary] {
 
 //8 - set the completion handler with our apps array of dictionaries
 completion(apps)
 }
 }
 } catch {
 //9 - if we have an error, set our completion with nil
 completion(nil)
 print("Error getting API data: \(error.localizedDescription)")
 }
 }
 //10 -
 dataTask.resume()
 }*/
