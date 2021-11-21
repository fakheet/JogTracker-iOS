//
// Created by mage on 20.11.2021.
//

import RxSwift
import RxRelay

struct JogDateFilterParameters {
    var fromDate: String
    var toDate: String
}

class JogListViewModel: BaseViewModel {
    let disposeBag = DisposeBag()
    let isFilterOpenedRelay = BehaviorRelay<Bool>(value: false)

    struct Input {
        var loadJogs: Observable<Void>
        var createNewJog: Observable<Void>
        var filterButtonTap: Observable<Void>
        var dateFilterValues: Observable<JogDateFilterParameters>
    }

    struct Output {
        var jogs: Observable<[JogCellViewModel]>
        var isFilterOpened: Observable<Bool>
    }

    func buildOutput(from input: Input) -> Output {

        input.filterButtonTap.bind { [weak self] in
            guard let self = self else { return }
            self.isFilterOpenedRelay.accept(!self.isFilterOpenedRelay.value)
        }.disposed(by: disposeBag)

//        input.dateFilterValues.bind(onNext: { print($0) }).disposed(by: disposeBag)

        return Output(
            jogs: input.loadJogs.flatMap { _ in
                JogTrackerAPI.shared.fetchJogs()
            }.map { jogsDTO in
                jogsDTO.map {
                    JogCellViewModel(
                        date: Date(timeIntervalSince1970: Double($0.date)),
                        speed: $0.distance / (Float($0.time) / 60.0),
                        distance: $0.distance,
                        time: $0.time
                    )
                }
            },
            isFilterOpened: isFilterOpenedRelay.asObservable()
        )
    }
}
