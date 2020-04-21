//
//  SwitcherCell.swift
//  GameQuiz
//
//  Created by Kirill Khudiakov on 16.04.2020.
//  Copyright © 2020 Kirill Khudiakov. All rights reserved.
//

import UIKit


final class SwitcherCell: UITableViewCell {
    
    var isOn: Observable<Bool> = Observable<Bool>(false)
    
    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(didSwitch), for: .valueChanged)
        return switcher
    }()
    
    static var reuseIdentifier: String {
        return "\(type(of: self))"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI() {
        addSubview(switcher)
        
    }
    private func setupConstraints() {
        switcher.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switcher.widthAnchor.constraint(equalToConstant: 60),
            switcher.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            switcher.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    @objc
    private func didSwitch() {
        print("Switch to:\(switcher.isOn)")
        isOn.value = switcher.isOn
    }
    
    func bindSelf() {
        isOn.subscribe { [unowned self] isOK in
            self.switcher.isOn = isOK
        }
        switcher.isOn = isOn.value
    }
}

