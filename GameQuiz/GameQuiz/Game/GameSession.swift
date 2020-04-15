//
//  GameSession.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


protocol GameSessionDelegate {
    func didEndGame(questionsCount: Int, and score: Int)
}

class GameSession {
    
    var answeredQuestions: Int = 0
    var questionNumber: Observable<Int> = Observable<Int>(0)
    var score: Int = 0
    var totalQuestions: Int = 0
    
    var money: Int {
        return score * 10_000
    }
    
    var percent: Float {
        return Float(answeredQuestions) / Float(totalQuestions) * 100
    }
    
    var formattedPercent: String {
        return String(format: "%.2f %%", percent)
    }
    
    init() {}
}
