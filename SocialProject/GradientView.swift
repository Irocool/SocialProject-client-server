//
//  GradientView.swift
//  SocialProject
//
//  Created by Irina Kuligina on 07.11.2021.
//

import UIKit

/// View слой сценария авторизации
@IBDesignable class GradientView: UIView {

    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }

    // Начальный цвет градиента
    @IBInspectable var startColor: UIColor = .white {
        didSet {
            self.updateColors()
        }
    }
    // Конечный цвет градиента
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }

    @IBInspectable var startLocation: CGFloat = 0 {
        didSet {
            self.updateLocations()
        }
    }

    @IBInspectable var endLocation: CGFloat = 1 {
        didSet {
            self.updateLocations()
        }
    }

    @IBInspectable var startPoint: CGPoint = .init(x: 1, y: 0) {
        didSet {
            self.updateStartPoint()
        }
    }

    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 0) {
        didSet {
            self.updateEndPoint()
        }
    }

    func updateLocations() {
        self.gradientLayer.locations = [self.startLocation as NSNumber, self.endLocation as NSNumber]
    }

    func updateColors() {
        self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
    }

    func updateStartPoint() {
        self.gradientLayer.startPoint = startPoint
    }

    func updateEndPoint() {
        self.gradientLayer.endPoint = endPoint
    }
}
