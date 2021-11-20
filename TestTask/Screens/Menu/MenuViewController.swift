//
//  MenuViewController.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit
import RxSwift

class MenuViewControllerNew: UIViewController {
    let _view: MenuView
    let disposeBag = DisposeBag()
    
    init(view: MenuView = .init()) {
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
            self?.navigationController?.popViewController(animated: true)
            print("self?.navigationController?.viewControllers = \(self?.navigationController?.viewControllers)")

        }.disposed(by: disposeBag)
	
        _view.jogsButton.rx.tap.bind { [weak self] in
            let vc = JogListViewController()
            self?.navigationController?.setViewControllers([vc], animated: true)
        }.disposed(by: disposeBag)

        _view.infoButton.rx.tap.bind { [weak self] in
            let vc = InfoViewController()
            self?.navigationController?.setViewControllers([vc], animated: true)
            print("self?.navigationController?.viewControllers = \(self?.navigationController?.viewControllers)")
        }.disposed(by: disposeBag)
    }
}
