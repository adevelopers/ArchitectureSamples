//
//  MenuViewController.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import UIKit


final class MenuViewController: UIViewController {
    
    private let buttonWidth = 280
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(origin: .zero, size: CGSize(width: buttonWidth, height: 50))
        button.setTitle("Играть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        button.addTarget(self, action: #selector(didTapStart), for: .touchDown)
        return button
    }()
    
    private lazy var resultsButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(origin: .zero, size: CGSize(width: buttonWidth, height: 50))
        button.setTitle("Результаты", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        button.addTarget(self, action: #selector(didTapResults), for: .touchDown)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Настройки", for: .normal)
        button.frame = CGRect(origin: .zero, size: CGSize(width: buttonWidth, height: 50))
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        button.addTarget(self, action: #selector(didTapSettings), for: .touchDown)
        return button
    }()
    
    private lazy var questionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Вопросы", for: .normal)
        button.frame = CGRect(origin: .zero, size: CGSize(width: buttonWidth, height: 50))
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        button.addTarget(self, action: #selector(didTapQuestions), for: .touchDown)
        return button
    }()
    
    
    
    private lazy var menu: [UIButton] = {
        return [startButton, resultsButton, settingsButton, questionButton]
    }()
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .blue
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupConstraints()
    }
    
    private func setupUI() {
        menu.forEach {
            view.addSubview($0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        /// x = (screenSize - buttonWidth)  / 2
        let screenSize = view.bounds.width
        let x: CGFloat = (screenSize - CGFloat(buttonWidth)) / 2
        var y: CGFloat = 100
        menu.forEach {
            y += 70
            $0.frame.origin = CGPoint(x: x , y: y )
        }
        
    }
    
    private func setupConstraints() {
        
        
    }
    
    @objc
    private func didTapStart() {
        Game.shared.session = GameSession()
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    @objc
    private func didTapResults() {
        navigationController?.pushViewController(ResultsViewController(resultsService: ResultsServiceImp()), animated: true)
    }
    
    @objc
    private func didTapSettings() {
        let viewModel = SettingsViewModelImp()
        
        viewModel.isQuestionShuffle.value = Game.shared.isQuestionsShuffle
        viewModel.isAnswersShuffle.value = Game.shared.isAnswersShuffle
        
        viewModel.sections.value = [
            .game(cells: [
                .switcher(title: "Перемешивать вопросы ?", isOn: viewModel.isQuestionShuffle),
                .switcher(title: "Перемешивать ответы ?", isOn: viewModel.isAnswersShuffle),
            ])
        ]
        
        viewModel.isQuestionShuffle.subscribe { OK in
            Game.shared.isQuestionsShuffle = OK
        }
        
        viewModel.isAnswersShuffle.subscribe { isOK in
            Game.shared.isAnswersShuffle = isOK
        }
        
        navigationController?.pushViewController(SettingsViewController(viewModel: viewModel), animated: true)
    }
    
    @objc
    private func didTapQuestions() {
        let controller = AddQuestionViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}


