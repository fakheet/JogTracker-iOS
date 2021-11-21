//
//  InfoViewController.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit
import RxSwift

class InfoViewController: UIViewController {
    let _view: InfoView
    let disposeBag = DisposeBag()

    init(view: InfoView = .init()) {
        _view = view
        super.init(nibName: nil, bundle: nil)
        bindActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = _view
    }

    func bindActions() {
        _view.primaryButton.rx.tap.bind { [weak self] in
            let vc = MenuViewControllerNew()
            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}
