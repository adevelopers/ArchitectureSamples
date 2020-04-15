//
//  ResultsViewController.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 15.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import UIKit


final class ResultsViewController: UIViewController {
    
    private var resultsService: ResultsService
    private var results: [GameResult] = []
    
    private lazy var resultsView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.accessibilityLabel = "resultsView"
        tableView.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        
        return tableView
    }()
    
    init(resultsService: ResultsService) {
        self.resultsService = resultsService
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
        
        loadResults()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loadResults()
        }
        
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        view.addSubview(resultsView)
        
    }
    private func setupConstraints() {
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            resultsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            resultsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadResults() {
        self.results = resultsService.getAll()
        resultsView.reloadData()
    }
}


extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = results[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "score")
        cell.textLabel?.text = "\(result.name)  Набрано: \(result.score) балов"
        cell.textLabel?.textColor = .black
        return cell
    }
    
}
