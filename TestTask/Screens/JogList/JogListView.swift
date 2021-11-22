//
//  JogListView.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit
import PinLayout

class JogListView: BaseView {
    override func setupSubviews() {
        backgroundColor = .white

        contentView.addSubview(filterView)
        contentView.addSubview(tableView)
        contentView.addSubview(fabButton)

        contentView.addSubview(noJogsImage)
        contentView.addSubview(noJogsLabel)
        contentView.addSubview(addFirstJogButton)
    }

    override func setupBaseView() {
        super.setupBaseView()
        secondaryButton.isHidden = false
    }

    let tableView = UITableView()
    let filterView = JogFilterView()
    var filterViewOpened = true

    let fabButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .appGreen
        button.setImage(UIImage(named: "add"), for: .normal)
        button.backgroundColor = .white
        button.isHidden = true
        return button
    }()

    let noJogsImage = UIImageView(image: UIImage(named: "sadRoundedSquareEmoticon"))

    let noJogsLabel: UILabel = {
        let label = UILabel()
        label.text = "Nothing is here"
        label.font = .textStyle
        label.textColor = .appGreyish
        return label
    }()

    let addFirstJogButton = RoundedButton(text: "Add your first jog", color: .appGreyish)
    override func layoutSubviews() {
        super.layoutSubviews()

        if filterViewOpened {
            filterView.pin.top().horizontally().sizeToFit(.width)
        } else {
            filterView.pin.top().horizontally().height(0)
        }

        tableView.pin.below(of: filterView).horizontally().bottom()

        fabButton.pin.bottom(32).end(32).size(47)
        fabButton.layer.cornerRadius = fabButton.bounds.height / 2

        noJogsImage.pin.top(140).hCenter().sizeToFit()

        noJogsLabel.pin.below(of: noJogsImage).hCenter().marginTop(30).sizeToFit()

        addFirstJogButton.pin.below(of: noJogsLabel).hCenter().marginTop(140).sizeToFit()
    }
}