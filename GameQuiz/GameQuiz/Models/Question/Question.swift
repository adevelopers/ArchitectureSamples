//
//  Question.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


struct Question: Codable {
    let text: String
    var answersVariants: [Answer]
    let correctAnswerId: String
}


extension Question: Hashable {
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.text.hashValue == rhs.text.hashValue
    }
    
    
    var hashValue: Int {
        return text.hashValue
    }

}
