//
//  BaseView.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

class BaseView: UIView {
    init() {
        super.init(frame: .zero)
        setupBaseView()
        setupSubviews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBaseView() {
        backgroundColor = .white
        
        addSubview(appBar)
        appBar.addSubview(logo)
        appBar.addSubview(primaryButton)
        
        addSubview(contentView)
    }
    
    func setupSubviews() {
        
    }
    
    let appBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .appGreen
        return bar
    }()
    
    let logo: UIImageView = {
        let image = UIImage(named: "logo")?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        view.tintColor = .white
        return view
    }()
        
    let primaryButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let contentView = UIView()

    override func layoutSubviews() {
        layoutAppBar()
        
        contentView.pin.below(of: appBar).horizontally().bottom()
    }
    
    func layoutAppBar() {
        appBar.pin.top().horizontally().height(pin.safeArea.top + 77)
        
        logo.pin.start(.margin).top(pin.safeArea.top + .marginMedium).bottom(.margin).aspectRatio()
        
        primaryButton.pin.end(.margin).top(pin.safeArea.top + .marginMedium).bottom(.margin).sizeToFit(.height)
    }
}
