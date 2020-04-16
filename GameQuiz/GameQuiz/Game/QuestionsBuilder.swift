//
//  QuestionsBuilder.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 16.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


protocol QuestionsBuilder {
    func build(withDifficulty level: Difficulty) -> [Question]
}

class QuestionsBuilderImp {
    func build(withDifficulty level: Difficulty) -> [Question] {
        switch level {
        case .easy:
            return EasyStrategy().prepareQuestions()
        case .medium:
            return MediumStrategy().prepareQuestions()
        case .nightmore:
            return HardStrategy().prepareQuestions()
        }
    }
}
