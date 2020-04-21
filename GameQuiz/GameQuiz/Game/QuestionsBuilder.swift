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
    
    private let questionsService: QuestionsService
    
    init(questionsService: QuestionsService) {
        self.questionsService = questionsService
    }
    
    func build(withDifficulty level: Difficulty) -> [Question] {
        switch level {
        case .easy:
            return EasyStrategy(service: questionsService).prepareQuestions()
        case .medium:
            return MediumStrategy(service: questionsService).prepareQuestions()
        case .nightmore:
            return HardStrategy(service: questionsService).prepareQuestions()
        }
    }
}
