//
//  CustomInteractiveTransition.swift
//  SocialProject
//
//  Created by Пользователь on 04.11.2021.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted: Bool = false
    var shouldFinish: Bool = false
    
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
            recognizer.edges = [.left]
            
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    @objc func handleGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            self.hasStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            break
        case .ended:
            self.hasStarted = false
            self.shouldFinish ? self.finish(): self.cancel()
        case .cancelled:
            self.hasStarted = false
            self.cancel()
        default:
            return
        }
        
    }}
