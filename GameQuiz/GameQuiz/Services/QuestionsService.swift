//
//  QuestionsService.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 17.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation

protocol QuestionsService {
    func add(question: Question)
    func getAll() -> [Question]
    func remove(question: Question)
    func saveAll(_ questions: [Question])
}

final class QuestionsServiceImp: QuestionsService {
    
    private let key = "game.questions"
    
    func add(question: Question) {
        var questions = getAll()
        questions.append(question)
        questions.sort(by: {$0.text.hashValue > $1.text.hashValue })
        let gameQuestions = GameQuestions(list: questions)
        save(gameQuestions)
    }
    
    func getAll() -> [Question] {
        if
            let data = UserDefaults.standard.value(forKey: key) as? Data,
            let questions = try? JSONDecoder().decode(GameQuestions.self, from: data) {
            return questions.list
        }
        
        return []
    }
    
    func remove(question: Question) {
        var questions = getAll()
        questions.removeAll(where: { $0.text.hashValue == question.text.hashValue })
        let gameQuestions = GameQuestions(list: questions)
        save(gameQuestions)
    }
    
    func saveAll(_ questions: [Question]) {
        var all = getAll()
        all.append(contentsOf: questions)
        save(GameQuestions(list: Set(all).map { $0 }))
    }
    
    private func save(_ questions: GameQuestions) {
        if let resultsData = try? JSONEncoder().encode(questions) {
            UserDefaults.standard.setValue(resultsData, forKey: key)
        }
    }
    
}
