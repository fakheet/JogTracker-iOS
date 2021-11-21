//
// Created by mage on 21.11.2021.
//

import RxSwift

class LoginViewModel: BaseViewModel {
    let disposeBag = DisposeBag()

    struct Input {
        var loginTap: Observable<Void>
    }

    struct Output {
        var openMain: Observable<Void>
    }

    func buildOutput(from input: Input) -> Output {
        Output(
            openMain: input.loginTap.flatMap {
                JogTrackerAPI.shared.login()
            }
        )
    }
}
