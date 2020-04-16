//
//  SettingsViewModel.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 16.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


protocol SettingsViewModel {
    // input
    var sections: Observable<[SectionModel]> { get set }
    
    // output
    var isQuestionShuffle: Observable<Bool> { get }
    var isAnswersShuffle: Observable<Bool> { get }
}


class SettingsViewModelImp: SettingsViewModel {
    var sections = Observable<[SectionModel]>([])
    var isQuestionShuffle = Observable<Bool>(false)
    var isAnswersShuffle = Observable<Bool>(false)
    
}
