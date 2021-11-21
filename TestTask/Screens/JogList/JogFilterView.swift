//
// Created by mage on 20.11.2021.
//

import UIKit

class JogFilterView: UIView {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/yyyy"
        return formatter
    }()

    init() {
        super.init(frame: .zero)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        backgroundColor = .appWhite2
        clipsToBounds = true

        fromTextField.inputView = fromDatePicker
        fromTextField.inputAccessoryView = fromToolbar
        fromDatePicker.sizeToFit()
        fromToolbar.sizeToFit()

        toTextField.inputView = toDatePicker
        toTextField.inputAccessoryView = toToolbar
        toDatePicker.sizeToFit()
        toToolbar.sizeToFit()

        addSubview(fromLabel)
        addSubview(fromTextField)
        addSubview(toLabel)
        addSubview(toTextField)
    }

    override func layoutSubviews() {
        fromLabel.pin.start(.marginMedium).top(.margin).sizeToFit()

        fromTextField.pin.after(of: fromLabel).top(.margin).marginStart(.margin).height(32).width(72)

        fromLabel.pin.before(of: fromTextField, aligned: .center).marginEnd(.margin)

        toTextField.pin.end(.marginMedium).top(.margin).height(32).width(72)

        toLabel.pin.before(of: toTextField, aligned: .center).marginEnd(.margin).sizeToFit()
    }

    private let fromLabel = makeLabel(text: "Date from:")
    let fromTextField = makeTextField()
    let fromDatePicker = makeDatePicker()
    let fromToolbar = UIToolbar()

    private let toLabel = makeLabel(text: "Date to:")
    let toTextField = makeTextField()
    let toDatePicker = makeDatePicker()
    let toToolbar = UIToolbar()

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

    private static func makeDatePicker() -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }

    private static func makeToolbar() -> (toolbar: UIToolbar, doneButton: UIButton) {
        let toolbar = UIToolbar()
        let pickerDoneButton =
        pickerToolbar.setItems([pickerDoneButton], animated: false)
        return toolbar
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return CGSize(width: size.width, height: toTextField.frame.maxY + .margin)
    }
}