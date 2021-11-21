//
//  JogListTableCell.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

struct JogCellViewModel {
    var image: UIImage? = UIImage(named: "jog")
    var date: Date = Date()
    var speed: Float = 0
    var distance: Float = 0
    var time: Int = 0
}

final class JogListTableCell: UITableViewCell {

    static let cellId = "jogCell"
    private let speedLabelText = ""
    private let distanceLabelText = ""
    private let timeLabelText = ""

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/yyyy"
        return formatter
    }()

    var model: JogCellViewModel = JogCellViewModel() {
        didSet {
            image.image = model.image
            dateLabel.text = Self.dateFormatter.string(from: model.date)
            distanceValueLabel.text = "\(model.distance) km"
            timeValueLabel.text = "\(model.time) min"
            speedValueLabel.text = String(format: "%.2f", model.speed) + " km/h"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubview(container)
        container.addSubview(image)
        container.addSubview(dateLabel)

        container.addSubview(speedLabel)
        container.addSubview(distanceLabel)
        container.addSubview(timeLabel)

        container.addSubview(speedValueLabel)
        container.addSubview(distanceValueLabel)
        container.addSubview(timeValueLabel)
    }

    private let container = UIView()

    private let image = UIImageView()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appGrey
        return label
    }()
    
    private let speedLabel = makeLabel(text: "Speed:")
    private let speedValueLabel = makeValueLabel()

    private let distanceLabel = makeLabel(text: "Distance:")
    private let distanceValueLabel = makeValueLabel()

    private let timeLabel = makeLabel(text: "Time:")
    private let timeValueLabel = makeValueLabel()

    private static func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = .textStyle4
        label.text = text
        return label
    }

    private static func makeValueLabel() -> UILabel {
        let label = UILabel()
        label.font = .textStyle4
        label.textColor = .appDarkGrey
        return label
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        container.pin.top(.marginLarge).horizontally().sizeToFit(.width)

        image.pin.start(.sideMargin).top(.marginLarge).width(87).aspectRatio()

        dateLabel.pin
            .after(of: image).marginStart(.marginLarge)
            .top(.marginLarge)
            .end(.sideMargin)
            .sizeToFit(.width)

        speedLabel.pin
            .after(of: image).marginStart(.marginLarge)
            .below(of: dateLabel).marginTop(.marginSmall)
            .sizeToFit()

        speedValueLabel.pin.after(of: speedLabel, aligned: .center).marginStart(.marginSmall).end(.sideMargin).sizeToFit(.width)

        distanceLabel.pin
            .after(of: image).marginStart(.marginLarge)
            .below(of: speedLabel).marginTop(.marginSmall)
            .sizeToFit()

        distanceValueLabel.pin.after(of: distanceLabel, aligned: .center).marginStart(.marginSmall).end(.sideMargin).sizeToFit(.width)

        timeLabel.pin
            .after(of: image).marginStart(.marginLarge)
            .below(of: distanceLabel).marginTop(.marginSmall)
            .sizeToFit()

        timeValueLabel.pin.after(of: timeLabel, aligned: .center).marginStart(.marginSmall).end(.sideMargin).sizeToFit(.width)

        container.pin.wrapContent(.vertically)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width).height(CGFloat.greatestFiniteMagnitude)
        layoutSubviews()
        return CGSize(width: size.width, height: container.frame.maxY + .marginLarge)
    }
}

private extension CGFloat {
    static let sideMargin: CGFloat = 48
}
