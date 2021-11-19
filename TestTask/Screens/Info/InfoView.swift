//
//  InfoView.swift
//  TestTask
//
//  Created by mage on 19.11.2021.
//

import UIKit
import PinLayout

class InfoView: UIView {
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        scrollView.pin.all(pin.safeArea)
        
        title.pin.top(.margin).horizontally(.margin).sizeToFit(.width)
        
        text.pin.below(of: title).marginTop(.marginSmall).horizontally(.margin).sizeToFit(.width)
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: text.frame.maxY)
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(title)
        scrollView.addSubview(text)
    }

    let scrollView = UIScrollView()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "INFO"
        label.textColor = .appGreen
        label.font = .systemFont(ofSize: 25, weight: .bold)

        return label
    }()
    
    let text: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text =
            """
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the \
            industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and \
            scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into \
            electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release \
            of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software \
            like Aldus PageMaker including versions of Lorem Ipsum.

            It is a long established fact that a reader will be distracted by the readable content of a page when \
            looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of \
            letters, as opposed to using 'Content here, content here', making it look like readable English.
            """
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
}
