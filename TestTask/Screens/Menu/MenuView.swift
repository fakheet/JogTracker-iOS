//
//  MenuView.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

class MenuView: BaseView {
    override func setupSubviews() {
        backgroundColor = .white

        contentView.addSubview(jogsButton)
        contentView.addSubview(infoButton)
        contentView.addSubview(contactUsButton)

        logo.tintColor = .appGreen
        appBar.backgroundColor = .white
        primaryButton.setImage(UIImage(named: "cancel"), for: .normal)
        primaryButton.tintColor = .appGreyish
    }
    
    let jogsButton = makeMenuButton(title: "JOGS")
    let infoButton = makeMenuButton(title: "INFO")
    let contactUsButton = makeMenuButton(title: "CONTACT US")
    
    override func layoutSubviews() {
        super.layoutSubviews()

        jogsButton.pin.top(110).hCenter().sizeToFit()
        infoButton.pin.below(of: jogsButton, aligned: .center).marginTop(36).sizeToFit()
        contactUsButton.pin.below(of: infoButton, aligned: .center).marginTop(36).sizeToFit()
    }
    
    private static func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .textStyle
        button.setTitle(title, for: .normal)
        button.setTitleColor(.appDarkGrey, for: .normal)
        button.setTitleColor(.appGreen, for: .highlighted)
        button.setTitleColor(.appGreen, for: .selected)
        return button
    }
}
