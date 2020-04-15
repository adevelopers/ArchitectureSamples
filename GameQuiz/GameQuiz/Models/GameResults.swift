//
//  GameResults.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


struct GameResults: Codable {
    let results: [GameResult]
}

struct GameResult: Codable {
    let name: String
    let score: Int
}
