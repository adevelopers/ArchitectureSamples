//
//  GameStrategy.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 16.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


protocol GameStrategy {
    func prepareQuestions() -> [Question]
}

/// ничего не перемешиваем
final class EasyStrategy: BaseStrategy,  GameStrategy {
    func prepareQuestions() -> [Question] {
        return service.getAll()
    }
}

/// перемешиваем только вопросы
final class MediumStrategy: BaseStrategy, GameStrategy {
    func prepareQuestions() -> [Question] {
        return service.getAll().shuffled()
    }
}

/// перемешиваем вопросы и ответы
final class HardStrategy: BaseStrategy, GameStrategy {
    func prepareQuestions() -> [Question] {
        return service.getAll()
            .shuffled()
            .map {
                Question(text: $0.text,
                         answersVariants: $0.answersVariants.shuffled(),
                         correctAnswerId: $0.correctAnswerId)
            }
    }
}

class BaseStrategy {
    var service: QuestionsService
    
    init(service: QuestionsService) {
        self.service = service
    }
}
