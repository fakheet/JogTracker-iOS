//
//  JogListTableCell.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

final class JogListTableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        image.pin.start(.sideMargin).top(.marginLarge).width(87).aspectRatio()
        
        dateLabel.pin
            .after(of: image).marginStart(.marginLarge)
            .top(.marginLarge)
            .end(.sideMargin)
            .sizeToFit(.width)
        
        speedLabel.pin
            .after(of: image).marginStart(.marginLarge)
            .below(of: dateLabel).marginTop(.marginSmall)
            .end(.sideMargin)
            .sizeToFit(.width)

        distanceLabel.pin
            .after(of: image).marginStart(.marginLarge)
            .below(of: speedLabel).marginTop(.marginSmall)
            .end(.sideMargin)
            .sizeToFit(.width)

        timeLabel.pin
            .after(of: image).marginStart(.marginLarge)
            .below(of: timeLabel).marginTop(.marginSmall)
            .end(.sideMargin)
            .sizeToFit(.width)
    }
        
    func configure() {
        
    }
    
    func addSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(dateLabel)
        contentView.addSubview(speedLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(timeLabel)
    }
    
    private let image = UIImageView()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appGrey
        return label
    }()
    
    private let speedLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let speedLabelText = ""
    private let distanceLabelText = ""
    private let timeLabelText = ""
}

private extension CGFloat {
    static let sideMargin: CGFloat = 66
}
