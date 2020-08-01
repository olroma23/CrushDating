//
//  GradientView.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 31.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

enum Point {
    case topLeading, leading, bottomLeading, top, center, bottom, topTrailing, trailing, bottomTrailing
    
    var point: CGPoint {
        switch self {
        case .topLeading:
            return CGPoint(x: 0, y: 0)
        case .leading:
            return CGPoint(x: 0, y: 0.5)
        case .bottomLeading:
            return CGPoint(x: 0, y: 1.0)
        case .top:
            return CGPoint(x: 0.5, y: 0)
        case .center:
            return CGPoint(x: 0.5, y: 0.5)
        case .bottom:
            return CGPoint(x: 0.5, y: 1.0)
        case .topTrailing:
            return CGPoint(x: 1.0, y: 0)
        case .trailing:
            return CGPoint(x: 1.0, y: 0.5)
        case .bottomTrailing:
            return CGPoint(x: 1.0, y: 1.0)
        }
    }
}

class GradientView: UIView {
    
    @IBInspectable private var startColor: UIColor? {
        didSet {
            setupGradientColors(startColor: startColor, endColor: endColor)
        }
    }
    
   @IBInspectable private var endColor: UIColor? {
           didSet {
               setupGradientColors(startColor: startColor, endColor: endColor)
           }
       }
    
private let gradientLayer = CAGradientLayer()
    
    init(from: Point, to: Point, startColor: UIColor?, endColor: UIColor?) {
        self.init()
        setupGradient(from: from, to: to, startColor: startColor, endColor: endColor)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient(from: Point, to: Point, startColor: UIColor?, endColor: UIColor?) {
        self.layer.addSublayer(gradientLayer)
        setupGradientColors(startColor: startColor, endColor: endColor)
        gradientLayer.startPoint = from.point
        gradientLayer.endPoint = to.point
    }
    
    private func setupGradientColors(startColor: UIColor?, endColor: UIColor?) {
        guard let startColor = startColor, let endColor = endColor else { return }
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient(from: .leading, to: .bottomTrailing, startColor: startColor, endColor: endColor)

    }
    
    
    
}
