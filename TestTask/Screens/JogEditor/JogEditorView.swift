//
// Created by mage on 21.11.2021.
//

import UIKit

class JogEditorView: UIView {

    init() {
        super.init(frame: .zero)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {
        backgroundColor = .black.withAlphaComponent(0.5)

        saveButton.setTitleColor(.appDarkGreen, for: .highlighted)
        
        addSubview(containerView)
        containerView.addSubview(distanceLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(distanceTextField)
        containerView.addSubview(timeTextField)
        containerView.addSubview(dateTextField)
        containerView.addSubview(saveButton)
        addSubview(closeButton)
    }

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGreen
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()

    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        return button
    }()

    private let distanceLabel = makeLabel(text: "Distance")
    private let timeLabel = makeLabel(text: "Time")
    private let dateLabel = makeLabel(text: "Date")

    let distanceTextField = makeTextField()
    let timeTextField = makeTextField()
    let dateTextField = makeTextField()

    let saveButton = RoundedButton(text: "Save", color: .white)

    private static func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .textStyle6
        label.textColor = .appDarkGrey
        return label
    }

    private static func makeTextField() -> UITextField {
        let field = UITextField()
        field.backgroundColor = .white
        field.layer.cornerRadius = 11
        field.layer.borderWidth = .onePixel
        field.layer.borderColor = UIColor.appDarkGrey.cgColor
        return field
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.pin.top(pin.safeArea.top + 160).horizontally(32)

        distanceLabel.pin.top(64).horizontally(.sideMargin).sizeToFit(.width)
        distanceTextField.pin.below(of: distanceLabel).marginTop(8).horizontally(.sideMargin).height(32)

        timeLabel.pin.below(of: distanceTextField).marginTop(20).horizontally(.sideMargin).sizeToFit(.width)
        timeTextField.pin.below(of: timeLabel).marginTop(8).horizontally(.sideMargin).height(32)

        dateLabel.pin.below(of: timeTextField).marginTop(20).horizontally(.sideMargin).sizeToFit(.width)
        dateTextField.pin.below(of: dateLabel).marginTop(8).horizontally(.sideMargin).height(32)

        saveButton.pin.below(of: dateTextField).marginTop(39).horizontally(.sideMargin).height(44)

        containerView.pin.height(saveButton.frame.maxY + 35).center()

        closeButton.pin
            .top(to: containerView.edge.top).marginTop(24)
            .end(to: containerView.edge.end).marginEnd(24)
            .height(24).sizeToFit()
    }
}

private extension CGFloat {
    static let sideMargin: CGFloat = 35
}