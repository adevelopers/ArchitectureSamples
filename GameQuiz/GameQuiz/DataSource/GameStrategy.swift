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
class EasyStrategy: GameStrategy {
    func prepareQuestions() -> [Question] {
        return DataSource.items
    }
}

/// перемешиваем только вопросы
class MediumStrategy: GameStrategy {
    func prepareQuestions() -> [Question] {
        return DataSource.items.shuffled()
    }
}

/// перемешиваем вопросы и ответы
class HardStrategy: GameStrategy {
    func prepareQuestions() -> [Question] {
        return DataSource.items
            .shuffled()
            .map {
                Question(text: $0.text,
                         answersVariants: $0.answersVariants.shuffled(),
                         correctAnswerId: $0.correctAnswerId)
            }
    }
}
