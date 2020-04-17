//
//  AddQuestion.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 17.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import UIKit


final class AddQuestionViewController: UIViewController {
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView =  UIScrollView()
        scrollView.addSubview(questionField)
        scrollView.backgroundColor = UIColor.magenta.withAlphaComponent(0.3)
        return scrollView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        button.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        
        
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        var prev: UIView = scrollView
        [questionField, answerField1, answerField2, answerField3, answerField4, addButton].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 16),
                $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                $0.widthAnchor.constraint(equalToConstant: 300),
                $0.heightAnchor.constraint(equalToConstant: 30),
            ])
            prev = $0
        }
    }
    
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        questionField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func didTapAdd() {
        print("add ")
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
        
        QuestionsServiceImp().add(question: newQuestion)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
