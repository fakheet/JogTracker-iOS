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

        let loadedJogs = input.loadJogs
            .flatMap { _ in
                JogTrackerAPI.shared.fetchJogs()
            }.map { result in
                result.jogs.map {
                    JogCellViewModel(
                        jogId: $0.id,
                        userId: $0.userId,
                        date: Date(timeIntervalSince1970: Double($0.date)),
                        speed: $0.distance / (Float($0.time) / 60.0),
                        distance: $0.distance,
                        time: $0.time
                    )
                }
            }

        let jogOutput = Observable.combineLatest(loadedJogs, input.dateFilterValues) { jogs, filterValues -> [JogCellViewModel] in
            let dateFrom = DateFormatter.defaultJogDateFormatter.date(from: filterValues.fromDate) ?? Date(timeIntervalSince1970: 0)
            let dateTo = DateFormatter.defaultJogDateFormatter.date(from: filterValues.toDate) ?? Date()
//            print("from: \(Self.dateFormatter.string(from: dateFrom)) to: \(Self.dateFormatter.string(from: dateTo))")
            return jogs.filter { jog in
                jog.date > dateFrom && jog.date < dateTo
            }
        }

        return Output(
            jogs: jogOutput,
            isFilterOpened: isFilterOpenedRelay.asObservable()
        )
    }
}
