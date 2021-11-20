//
//  BaseViewController.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<ViewType: UIView>: UIViewController {
    let _view: BaseView<ViewType>
    
    init(view: ViewType) {
        _view = BaseView<ViewType>(content: view)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
    }
}
