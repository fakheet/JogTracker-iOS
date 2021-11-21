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
        
    init(text: String, color: UIColor, font: UIFont = .textStyle2) {
        titleFont = font
        primaryColor = color
        super.init(frame: .zero)
        setTitle(text, for: .normal)
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
        contentEdgeInsets = UIEdgeInsets(top: 19, left: 34, bottom: 19, right: 34)
        setTitleColor(primaryColor, for: .normal)
        titleLabel?.font = titleFont
        
        layer.borderWidth = 3
        layer.borderColor = primaryColor.cgColor
        clipsToBounds = true
    }
}
