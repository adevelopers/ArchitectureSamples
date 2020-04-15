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
        Game.shared.start()
        Game.shared.controllerDelegate = self
        setupConstraints()
        nextTurn()
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
    
}


extension GameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.getAnswersCount(with: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "answer")
        cell.textLabel?.text = Game.shared.answerText(with: indexPath.row)
        cell.textLabel?.textColor = .black
        return cell
    }
    
}


extension GameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Game.shared.didSelectAnswer(with: indexPath.row)
    }
}


extension GameViewController: GameControllerDelegate {
    func didStart() {
        answersView.reloadData()
    }
    
    func nextTurn() {
        questionLabel.text = Game.shared.questionText()
        answersView.reloadData()
    }
    
    func didEnd() {
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(ResultsViewController(resultsService: ResultsServiceImp()), animated: true)
    }

}

protocol GameControllerDelegate {
    func didStart()
    func nextTurn()
    func didEnd()
}
