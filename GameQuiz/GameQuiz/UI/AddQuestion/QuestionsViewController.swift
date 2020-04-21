//
//  QuestionsViewController.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 18.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import UIKit


enum QuestionCellModel {
    case question(model: Question)
    case addQuestion
}

enum QuestionViewState {
    case listOnly
    case addQuestionForm
}

final class QuestionViewController: UIViewController {
    
    // ViewModel
    private var questionService = QuestionsServiceImp()
    private var items: [QuestionCellModel] = []
    private var state =  Observable<QuestionViewState>(.listOnly)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(AddQuestionCell.self, forCellReuseIdentifier: AddQuestionCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        return tableView
    }()
    
      private lazy var addButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(imageLiteralResourceName: "addIcon"), for: .normal)
            button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
            button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            button.layer.cornerRadius = 50

            return button
    }()
    
    private var restoreScrollSize: CGSize = .zero
    
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
        
        setupActionHideKeyboard()
        
        state.subscribe { stateValue in
            self.reloadQuestions()
        }
        
        self.reloadQuestions()
    }
    
    private func reloadQuestions() {
        switch state.value {
        case .listOnly:
            items = questionService.getAll().map { QuestionCellModel.question(model: $0) }
            tableView.reloadData()
        case .addQuestionForm:
            items = questionService.getAll().map { QuestionCellModel.question(model: $0) }
            items.insert(.addQuestion, at: 0)
            tableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(addButton)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc
    func didTapAdd() {
        print(state.value)
        switch state.value {
        case .listOnly:
            state.value = .addQuestionForm
        case .addQuestionForm:
            addQuestion()
            state.value = .listOnly
        }
    }
    
    private func addQuestion() {
        guard let addQindex = items.firstIndex(where: {
                   if case QuestionCellModel.addQuestion = $0 {
                       return true
                   } else {
                       return false
                   }
               }) else {
                   return
               }
                   
               if
                   let addQCell = tableView.cellForRow(at: IndexPath(row: addQindex, section: 0)) as? AddQuestionCell
               {
                   let newQuestion = addQCell.getNewQuesion()
                   QuestionsServiceImp().add(question: newQuestion)
                   reloadQuestions()
               }
    }
    
    private func setupActionHideKeyboard() {
        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapOnView)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    private func keyboardWasShown(notification: Notification) {
        guard
            let info = notification.userInfo as NSDictionary?,
            let keyboardRectangle = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? CGRect
            else {
                return
        }
        
        restoreScrollSize = tableView.contentSize
        tableView.contentSize = CGSize(width: tableView.contentSize.width,
                                        height: view.bounds.height )
    }
    
    @objc
    private func keyboardWillBeHidden(notification: Notification) {
        tableView.contentSize = restoreScrollSize
        tableView.setContentOffset(.zero, animated: false)
    }
    
    @objc
    private func hideKeyboard() {
        tableView.endEditing(true)
    }
    
}

extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case let .question(model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
            cell.textLabel?.text = model.text
            return cell
        case .addQuestion:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddQuestionCell.reuseIdentifier) as? AddQuestionCell else { return UITableViewCell() }
            
            return cell
        }
        
    }
}

extension QuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch items[indexPath.row] {
        case .question:
            return 50
        case .addQuestion:
            return 300
        }
    }
}
