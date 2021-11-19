//
//  InfoViewController.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

class InfoViewController: UIViewController {
    let _view = InfoView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
//        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }
}
