//
// Created by mage on 21.11.2021.
//

import RxSwift
import RxCocoa

class JogEditorViewController: UIViewController {
    let _view: JogEditorView
    let disposeBag = DisposeBag()
    let viewModel: JogEditorViewModel
    var jogModel: JogCellViewModel?
    let onComplete: (() -> ())?

    init(jogModel: JogCellViewModel?, view: JogEditorView = .init(),
         viewModel: JogEditorViewModel = .init(), onComplete: (() -> ())?)
    {
        _view = view
        self.viewModel = viewModel
        self.jogModel = jogModel
        self.onComplete = onComplete
        super.init(nibName: nil, bundle: nil)
        setModalPresentationStyle()
        setTextFieldIfEditing()
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = _view
    }

    private func setModalPresentationStyle() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    private func setTextFieldIfEditing() {
        if let jog = jogModel {
            _view.distanceTextField.text = String(jog.distance)
            _view.timeTextField.text = String(jog.time)
            _view.dateTextField.text = DateFormatter.defaultJogDateFormatter.string(from: jog.date)

            _view.distanceTextField.sendActions(for: .valueChanged)
            _view.timeTextField.sendActions(for: .valueChanged)
            _view.dateTextField.sendActions(for: .valueChanged)
        }
    }

    private func bindViewModel() {
        _view.closeButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true)
        }.disposed(by: disposeBag)
        
        let jog = Observable.combineLatest(
            _view.distanceTextField.rx.text.orEmpty,
            _view.timeTextField.rx.text.orEmpty,
            _view.dateTextField.rx.text.orEmpty
        ) { [weak self] distance, time, date -> JogDTO? in
            guard let self = self else { return nil }
            if let distance = Float(distance),
               let time = Int(time),
               let date = DateFormatter.defaultJogDateFormatter.date(from: date)
            {
                return JogDTO(id: self.jogModel?.jogId ?? 0, userId: "0", distance: distance, time: time,
                              date: Int(date.timeIntervalSince1970))
            } else {
                return nil
            }
        }

        let input = JogEditorViewModel.Input(
            saveJog: _view.saveButton.rx.tap.withLatestFrom(jog)
                .compactMap { [weak self] jog in
                    if let self = self, let jog = jog {
                        return (jog: jog, newJog: self.jogModel == nil)
                    } else {
                        return nil
                    }
                }
        )

        let output = viewModel.buildOutput(from: input)

        output.saveJogResult.subscribe {
            let alert = UIAlertController(title: "Success!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
                self?.onComplete?()
                self?.dismiss(animated: true)
            })
            self.present(alert, animated: true)
        } onError: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }.disposed(by: disposeBag)
    }
}
