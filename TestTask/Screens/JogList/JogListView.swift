//
//  JogListView.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit
import PinLayout

class JogListView: UIView {
    init() {
        super.init(frame: .zero)
        setupView()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        tableView.pin.all(pin.safeArea)
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(tableView)
    }

    private func configureTableView() {
        
    }
    
    let tableView = UITableView()
}
