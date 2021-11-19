//
//  JogListViewController.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

class JogListViewController: UIViewController {
    let _view = JogListView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }
}
