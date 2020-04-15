//
//  Question.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


struct Question {
    let text: String
    let answersVariants: [Answer]
    let correctAnswerId: String
}

