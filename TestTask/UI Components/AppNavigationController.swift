//
//  AppNavigationController.swift
//  TestTask
//
//  Created by mage on 20.11.2021.
//

import UIKit

final class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }
    
    private func setupStyle() {
        setNavigationBarHidden(true, animated: false)
    }
}

extension UINavigationController {
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.2
        transition.type = .fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}