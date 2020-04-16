//
//  ResultsService.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


protocol ResultsService {
    func add(result: GameResult)
    func getAll() -> [GameResult]
}

final class ResultsServiceImp: ResultsService {
    let key = "results"
    
    func add(result: GameResult) {
        var results = getAll()
        results.append(result)
        results.sort(by: {$0.score > $1.score})
        let gameResults = GameResults(results: results)
        
        if let resultsData = try? JSONEncoder().encode(gameResults) {
            UserDefaults.standard.setValue(resultsData, forKey: key)
        }
    }
    
    func getAll() -> [GameResult] {
        if
            let data = UserDefaults.standard.value(forKey: key) as? Data,
            let results = try? JSONDecoder().decode(GameResults.self, from: data) {
            return results.results
        }
        
        return []
    }
}
