//
//  Observable.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import Foundation


class Observable<Type> {
    
    typealias Callback = (Type)->Void
     
    private var subscriptions: [Callback] = []
    
    var value: Type {
        didSet {
            notify(value: value)
        }
    }
    
    
    init(_ value: Type) {
        self.value = value
    }
    
    private func notify(value: Type) {
        subscriptions.forEach {
            $0(value)
        }
    }
    
    func subscribe(_ callback: @escaping Callback) {
        subscriptions.append(callback)
    }
    
}
