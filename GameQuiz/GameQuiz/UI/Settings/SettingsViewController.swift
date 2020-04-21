//
//  SettingsViewController.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 16.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import UIKit


enum SectionModel {
    case game(cells: [CellModel])
}

enum CellModel {
    case switcher(title: String, isOn: Observable<Bool>)
}

final class SettingsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SwitcherCell.self, forCellReuseIdentifier: SwitcherCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.rowHeight = 50
        tableView.dataSource = self
        return tableView
    }()
    
    private var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
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
        
        viewModel.sections.subscribe { newItems in
            self.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .magenta
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections.value[section] {
        case let .game(cells):
            return cells.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch viewModel.sections.value[indexPath.section] {
        case let .game(cells):
            if case let CellModel.switcher(title, isOn) = cells[indexPath.row] {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitcherCell.reuseIdentifier) as? SwitcherCell else {
                    return UITableViewCell()
                }
                cell.textLabel?.text = title
                cell.isOn = isOn
                cell.bindSelf()
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}

