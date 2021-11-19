//
//  InfoView.swift
//  TestTask
//
//  Created by mage on 19.11.2021.
//

import UIKit
import PinLayout

class InfoView: UIView {
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView = UITableView()
    
    override func layoutSubviews() {
        tableView.pin.all(pin.safeArea)
    }
}

extension InfoView {
    
}
