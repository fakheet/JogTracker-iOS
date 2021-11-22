//
// Created by mage on 21.11.2021.
//

import RxSwift

class JogEditorViewModel: BaseViewModel {
    let disposeBag = DisposeBag()

    struct Input {
        var saveJog: Observable<(jog: JogDTO, newJog: Bool)>
    }

    struct Output {
        var saveJogResult: Observable<Void>
    }

    func buildOutput(from input: Input) -> Output {
        Output(
            saveJogResult: input.saveJog.flatMap { pair in
                pair.newJog ? JogTrackerAPI.shared.addNewJog(pair.jog).map { _ in () }
                            : JogTrackerAPI.shared.editJog(pair.jog).map { _ in () }
            }
        )
    }
}
