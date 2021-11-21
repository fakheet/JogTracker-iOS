//
// Created by mage on 21.11.2021.
//

import UIKit

class LoginView: BaseView {
    override func setupSubviews() {
        contentView.addSubview(bearImage)
        contentView.addSubview(loginButton)
    }

    let bearImage = UIImageView(image: UIImage(named: "bearFace"))
    let loginButton = RoundedButton(text: "Let me in", color: .appPurple)

    override func layoutSubviews() {
        super.layoutSubviews()
        bearImage.pin.top(140).hCenter().sizeToFit()
        loginButton.pin.below(of: bearImage, aligned: .center).marginTop(80).sizeToFit()
    }
}
