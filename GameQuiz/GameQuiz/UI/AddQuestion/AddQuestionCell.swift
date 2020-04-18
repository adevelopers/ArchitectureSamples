//
//  AddQuestionCell.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 18.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import UIKit


final class AddQuestionCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private lazy var questionField: UITextField = {
          let textField = UITextField()
          textField.layer.cornerRadius = 16
          textField.placeholder = "question"
          textField.textColor = .white
          textField.backgroundColor = UIColor.orange.withAlphaComponent(0.6)
          return textField
      }()
      
      private lazy var answerField1: UITextField = {
          let textField = UITextField()
          textField.layer.cornerRadius = 16
          textField.placeholder = "answer"
          textField.textColor = .white
          textField.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
          return textField
      }()
      
      private lazy var answerField2: UITextField = {
          let textField = UITextField()
          textField.layer.cornerRadius = 16
          textField.placeholder = "answer"
          textField.textColor = .white
          textField.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
          return textField
      }()
      
      private lazy var answerField3: UITextField = {
          let textField = UITextField()
          textField.layer.cornerRadius = 16
          textField.placeholder = "answer"
          textField.textColor = .white
          textField.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
          return textField
      }()
      
      private lazy var answerField4: UITextField = {
          let textField = UITextField()
          textField.layer.cornerRadius = 16
          textField.placeholder = "answer"
          textField.textColor = .white
          textField.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
          return textField
      }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI() {
        var prev: UIView = questionField
        addSubview(questionField)
        questionField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            questionField.centerXAnchor.constraint(equalTo: centerXAnchor),
            questionField.widthAnchor.constraint(equalToConstant: 300),
            questionField.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        [answerField1, answerField2, answerField3, answerField4].forEach {
           addSubview($0)
           $0.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               $0.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 16),
               $0.centerXAnchor.constraint(equalTo: centerXAnchor),
               $0.widthAnchor.constraint(equalToConstant: 300),
               $0.heightAnchor.constraint(equalToConstant: 30),
           ])
           prev = $0
       }
    }
    
    func getNewQuesion() -> Question {
          let answersVariants = [
                  answerField1,
                  answerField2,
                  answerField3,
                  answerField4
              ]
              .enumerated()
              .map { Answer(id: "\($0.offset + 1)", text: $0.element.text!) }
          
          let newQuestion = Question(text: questionField.text!,
                   answersVariants: answersVariants,
                   correctAnswerId: "1")
        return newQuestion
      }
}

