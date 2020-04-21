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

protocol GameControllerDelegate {
    func didStart()
    func nextTurn()
    func didEnd()
}

enum Difficulty {
    case easy
    case medium
    case nightmore
}

final class Game {
    static let shared = Game(ResultsServiceImp())
    
    var session: GameSession?
    var controllerDelegate: GameControllerDelegate?
    var isQuestionsShuffle: Bool = false
    var isAnswersShuffle: Bool = false
    var difficulty: Difficulty = .easy
    
    private let resultsService: ResultsService
    
    private var questions: [Question] = []
    private var currentQuestion: Question?
    
    init( _ rService: ResultsService) {
        self.resultsService = rService
    }
}

extension Game: GameLogic {
    func start() {
        print("start")
        print("isQuestionsShuffle", isQuestionsShuffle)
        print("isAnswersShuffle", isAnswersShuffle)
        
        switch [isQuestionsShuffle, isAnswersShuffle] {
        case [false, false]:
            difficulty = .easy
        case [true, false],
             [false, true]:
            difficulty = .medium
        case [true, true]:
            difficulty = .nightmore
        default:
            difficulty = .easy
        }
        
        questions = QuestionsBuilderImp(questionsService: QuestionsServiceImp())
            .build(withDifficulty: difficulty)
        session?.totalQuestions = questions.count
        
        nextQuestion()
        session?.questionNumber.value += 1
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
            print("✅ Ответ правильный")
            session.answeredQuestions += 1
            session.score += 100
            session.questionNumber.value += 1
            nextQuestion()
        } else {
            end()
        }
    }
    
    func end() {
        guard let session = session else {
            return
        }
        
        let dumpString = "Игра окончена\nВопросов: \(questions.count)\n"
                    + "Дано ответов: \(session.answeredQuestions)\n"
                    + "Получено денег: \(session.money) ₽\n"
                    + "Процент правильных ответов: \(session.percent)%"
        
        print(dumpString)
        resultsService.add(result: GameResult(name: "игрок", score: session.score))
        controllerDelegate?.didEnd()
        self.session = nil
    }
        
}

