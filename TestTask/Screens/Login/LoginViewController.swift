//
// Created by mage on 21.11.2021.
//

import RxSwift

class LoginViewController: UIViewController {
    let _view: LoginView
    let disposeBag = DisposeBag()
    let viewModel: LoginViewModel

    init(view: LoginView = .init(), viewModel: LoginViewModel = .init()) {
        _view = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        _view.primaryButton.isHidden = true
        _view.secondaryButton.isHidden = true
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = _view
    }

    func bindViewModel() {
        let input = LoginViewModel.Input(loginTap: _view.loginButton.rx.tap.asObservable())

        let output = viewModel.buildOutput(from: input)

        output.openMain.subscribe { [weak self] in
            let vc = JogListViewController()
            self?.navigationController?.setViewControllers([vc], animated: true)
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
    }
}
