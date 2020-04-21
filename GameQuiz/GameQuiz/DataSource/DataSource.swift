//
//  DataSource.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


final class DataSource {
    
    static let items: [Question] = [
            Question(text: "Какой город изображен на современной российской купюре 1000 рублей?",
                             answersVariants: [
                                .init(id: "1", text: "Москва" ),
                                .init(id: "2", text: "Хабаровск" ),
                                .init(id: "3", text: "Владивосток" ),
                                .init(id: "4", text: "Ярославль" ),
                             ],
                             correctAnswerId: "4"),
            Question(text: "Сможете точно назвать годы Первой мировой войны?",
            answersVariants: [
               .init(id: "1", text: "1917-1918" ),
               .init(id: "2", text: "1914-1918" ),
               .init(id: "3", text: "1914-1920" ),
               .init(id: "4", text: "1914-1917" ),
            ],
            correctAnswerId: "2"),
            Question(text: "Оперу \"Борис Годунов\" написал..",
            answersVariants: [
               .init(id: "1", text: "Чайковский" ),
               .init(id: "2", text: "Глинка" ),
               .init(id: "3", text: "Модест-Мусоргский" ),
               .init(id: "4", text: "Прокофьев" ),
            ],
            correctAnswerId: "3"),
            Question(text: "Сколько человек живёт на планете Земля ?",
            answersVariants: [
               .init(id: "1", text: "около 12 млрд" ),
               .init(id: "2", text: "4 млрд" ),
               .init(id: "3", text: "около 7.5 млрд" ),
               .init(id: "4", text: "около 5.5 млрд" ),
            ],
            correctAnswerId: "3"),
            Question(text: "Кто является автором психоанализа ?",
            answersVariants: [
               .init(id: "1", text: "Фридрих Ницше" ),
               .init(id: "2", text: "Иммануил Кант" ),
               .init(id: "3", text: "Зигмунд Фрейд" ),
               .init(id: "4", text: "Карл Густав Юнг" ),
            ],
            correctAnswerId: "3"),
            Question(text: "O3 - в химии это",
            answersVariants: [
               .init(id: "1", text: "Кислород" ),
               .init(id: "2", text: "Озон" ),
               .init(id: "3", text: "Тризон" ),
               .init(id: "4", text: "Оксиген" ),
            ],
            correctAnswerId: "2"),
            Question(text: "Человек состоит из воды на...",
            answersVariants: [
               .init(id: "2", text: "95 %" ),
               .init(id: "1", text: "65-70 %" ),
               .init(id: "3", text: "80 %" ),
               .init(id: "4", text: "85-90 %" ),
            ],
            correctAnswerId: "1")            
    ]
    
}
