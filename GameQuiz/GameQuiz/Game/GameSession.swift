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
    var score: Int = 0
    var money: Int {
        return score * 10_000
    }
    
    var percent: Float = 0
    
    init() {}
}
