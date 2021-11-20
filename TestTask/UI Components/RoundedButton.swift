//
//  RoundedButton.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

final class RoundedButton: UIButton {
    
    private var primaryColor: UIColor
    private var titleFont: UIFont
        
    init(color: UIColor, font: UIFont = .textStyle2) {
        titleFont = font
        primaryColor = color
        super.init(frame: .zero)
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2.0
    }
    
    private func setStyle() {
        backgroundColor = .clear

        setTitleColor(primaryColor, for: .normal)
        titleLabel?.font = titleFont
        
        layer.borderWidth = 3
        layer.borderColor = primaryColor.cgColor
        clipsToBounds = true
    }
}
