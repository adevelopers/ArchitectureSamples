//
//  GameViewController.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import UIKit


final class GameViewController: UIViewController {
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Вопрос"
        label.accessibilityLabel = "questionLabel"
        return label
    }()
    
    private lazy var answersView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.accessibilityLabel = "answersView"
        tableView.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        
        return tableView
    }()
    
    private var questions: [Question] = []
    
    private var currentQuestion: Question?
    
    private var resultsService: ResultsService = ResultsServiceImp()
    
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
        questions = DataSource.items.shuffled()
        nextQuestion()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(questionLabel)
        view.addSubview(answersView)
    }
    
    private func setupConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        answersView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.widthAnchor.constraint(equalToConstant: 300),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            questionLabel.heightAnchor.constraint(equalToConstant: 200),
            answersView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor),
            answersView.leftAnchor.constraint(equalTo: view.leftAnchor),
            answersView.rightAnchor.constraint(equalTo: view.rightAnchor),
            answersView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    // MARK: Game
    private var score: Int = 0
    private func nextQuestion() {
        currentQuestion = questions.popLast()
        questionLabel.text = currentQuestion?.text
        answersView.reloadData()
        if currentQuestion == nil {
            endGame()
        }
    }
    
    private func endGame() {
        resultsService.add(result: GameResult(name: "Игрок", score: score))
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(ResultsViewController(resultsService: ResultsServiceImp()), animated: true)
    }
}


extension GameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let question = currentQuestion else {
            return 0
        }
        
        print(question.answersVariants.count)
        return question.answersVariants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let question = currentQuestion else {
            return UITableViewCell()
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "answer")
        cell.textLabel?.text = question.answersVariants[indexPath.row].text
        cell.textLabel?.textColor = .black
        return cell
    }
    
}


extension GameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        
        let answer = currentQuestion.answersVariants[indexPath.row]
        
        print("Вариант ответа \(answer.text) -> \(answer.id)")
        
        if answer.id == currentQuestion.correctAnswerId {
            print("Ответ правильный")
            score += 100
            nextQuestion()
        } else {
            print("Ответ НЕправильный\nИгра окончена")
            endGame()
        }
    }
}
