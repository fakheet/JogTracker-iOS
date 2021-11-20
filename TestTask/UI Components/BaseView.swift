//
//  BaseView.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

class BaseView<ContentViewType: UIView>: UIView {
    init(content: ContentViewType) {
        contentView = content
        super.init(frame: .zero)
        setupBaseView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBaseView() {
        backgroundColor = .white
        
        addSubview(appBar)
        appBar.addSubview(logo)
        appBar.addSubview(menuButton)
        
        addSubview(contentView)
    }
    
    private let appBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .appGreen
        return bar
    }()
    
    let contentView: ContentViewType
    
    private let logo: UIImageView = {
        let image = UIImage(named: "logo")?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        view.tintColor = .white
        return view
    }()
    
    let menuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func layoutSubviews() {
        appBar.pin.top().horizontally().height(pin.safeArea.top + 77)
        
        logo.pin.start(.margin).top(pin.safeArea.top + .margin).bottom(.margin).aspectRatio()
        
        menuButton.pin.end(.margin).top(pin.safeArea.top + .margin).bottom(.margin).sizeToFit(.height)
        
        contentView.pin.below(of: appBar).horizontally().bottom()
    }
}
