//
//  JogListViewController.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

class JogListViewController: UIViewController, UITableViewDelegate {
    let _view: JogListView
    let viewModel: JogListViewModel
    let disposeBag = DisposeBag()
    let loadJogsRelay = PublishRelay<Void>()

    init(view: JogListView = .init(), viewModel: JogListViewModel = .init()) {
        _view = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadJogsRelay.accept(())
    }

    private func setupTableView() {
        _view.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        _view.tableView.register(JogListTableCell.self, forCellReuseIdentifier: JogListTableCell.cellId)
        _view.tableView.separatorInset = .zero
        _view.tableView.tableFooterView = UIView()

        _view.tableView.rx.itemSelected.bind { [weak self] indexPath in
            self?._view.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
    }

    override func loadView() {
        view = _view
    }

    func bindViewModel() {
        _view.primaryButton.rx.tap.bind { [weak self] in
            let vc = MenuViewControllerNew()
            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)

        let input = JogListViewModel.Input(
            loadJogs: loadJogsRelay.asObservable(),
            createNewJog: Observable.never(),
            filterButtonTap: _view.secondaryButton.rx.tap.asObservable(),
            dateFilterValues: Observable.combineLatest(
                _view.filterView.fromTextField.rx.text.orEmpty,
                _view.filterView.toTextField.rx.text.orEmpty
            ).map {
                JogDateFilterParameters(fromDate: $0.0, toDate: $0.1)
            }
        )

        let output = viewModel.buildOutput(from: input)

        output.isFilterOpened.bind(to: _view.secondaryButton.rx.isSelected).disposed(by: disposeBag)
        output.isFilterOpened.bind { [weak self] in
            guard let self = self else { return }
            self._view.filterViewOpened = $0

            UIView.animate(withDuration: 0.3) { [weak self] in
                self?._view.setNeedsLayout()
                self?._view.layoutIfNeeded()
            }
        }.disposed(by: disposeBag)

        output.jogs.map { $0.isEmpty }.bind(to: _view.fabButton.rx.isHidden).disposed(by: disposeBag)

        output.jogs.bind(
            to: _view.tableView.rx.items(cellIdentifier: JogListTableCell.cellId, cellType: JogListTableCell.self)
        ) { index, model, cell in
            cell.model = model
        }.disposed(by: disposeBag)
    }
}
