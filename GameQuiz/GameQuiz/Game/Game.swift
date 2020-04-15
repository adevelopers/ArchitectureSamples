//
//  Game.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation

protocol GameLogic {
    
    func start()
    func nextQuestion()
    func end()
    
}

final class Game {
    static let shared = Game()
    
    var session: GameSession?
    var controllerDelegate: GameControllerDelegate?
    
    private var resultsService: ResultsService = ResultsServiceImp()
    
    private var questions: [Question] = []
    private var currentQuestion: Question?
    

}

extension Game: GameLogic {
    func start() {
        questions = DataSource.items.shuffled()
        
        nextQuestion()
    }
    
    func getAnswersCount(with index: Int) -> Int {
        return currentQuestion?.answersVariants.count ?? 0
    }
    
    func questionText() -> String? {
        return currentQuestion?.text
    }
    
    func answerText(with index: Int) -> String? {
        return currentQuestion?.answersVariants[index].text
    }
    
    func nextQuestion() {
        currentQuestion = questions.popLast()
        
        if currentQuestion == nil {
            end()
            return
        }
        
        self.currentQuestion?.answersVariants.shuffle()
        controllerDelegate?.nextTurn()
    }
    
    func didSelectAnswer(with index: Int) {
        
        guard
            let currentQuestion = currentQuestion,
            let session = session
        else {
            return
        }
        
        let answer = currentQuestion.answersVariants[index]
        
        
        if answer.id == currentQuestion.correctAnswerId {
            print("Ответ правильный")
            session.answeredQuestions += 1
            session.score += 100
            nextQuestion()
            
        } else {
            end()
        }
    }
    
    func end() {
        guard let session = session else {
            return
        }
        
        session.percent = Float(session.answeredQuestions) / Float(DataSource.items.count) * 100
        
        print("Игра окончена\nВопросов: \(questions.count)\nдано ответов: \(session.answeredQuestions)\nПолучено денег: \(session.money) ₽\nПроцент правильных ответов: \(session.percent)%")
        resultsService.add(result: GameResult(name: "игрок", score: session.score))
        controllerDelegate?.didEnd()
        self.session = nil
    }
    
    
}

