//
//  CircleProgressBar.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 20.03.2021.
//

import UIKit

class CircleProgressBar: UIView {
    
    public lazy var backgroundCircleColor: UIColor = UIColor.systemGray6
    public lazy var gradientColors: [UIColor] = [.systemRed, .systemYellow, .systemGreen]
    public lazy var textColor: UIColor = UIColor.darkGray
    private lazy var fillColor: UIColor = UIColor.clear
    private lazy var lineWidth = min(frame.size.width, frame.size.height) * 0.1
    
    public var progress: CGFloat = 0
    public var isAnimating: Bool = false
    public var counterDuration = 1.0
    
    private var counterStartDate = Date()
    private let counterStartValue = 0
    private lazy var counterEndValue = Int(progress)
    private lazy var counterDisplayLink = CADisplayLink(target: self, selector: #selector(handleTextUpdate))
    
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = circularLayerFactory(strokeColor: backgroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
        
        return layer
    }()
    
    private lazy var progressLayer: CAShapeLayer = {
        let layer = circularLayerFactory(strokeColor: backgroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
        layer.strokeEnd = progress / 100
        
        return layer
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.5, y: 0.5)
        layer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.colors = gradientColors.map { $0.cgColor }
        layer.frame = self.bounds
        layer.mask = progressLayer
        layer.type = .conic
        
        return layer
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = textColor
        label.text = "\(Int(round(progress)))"
        label.textAlignment = .center
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        
        guard layer.sublayers == nil else {
            return
        }
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(gradientLayer)
        self.addSubview(textLabel)
        
        progressAnimation()
        textAnimation()
        
    }
    
    private func progressAnimation() {
        guard isAnimating else { return }
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = progressLayer.strokeEnd
        animation.duration = counterDuration
        animation.timingFunction = .init(name: .easeOut)
        progressLayer.add(animation, forKey: "progressLayerStrokeEndAnimation")
        
    }
    
    private func textAnimation() {
        guard isAnimating else { return }
        counterDisplayLink.add(to: .main, forMode: .default)
    }
    
    @objc private func handleTextUpdate() {
        let elapsedTime = Date().timeIntervalSince(counterStartDate)

        guard elapsedTime < counterDuration else {
            counterDisplayLink.invalidate()

            textLabel.text = "\(Int(round(progress)))"
            return
        }

        let percentage = elapsedTime / counterDuration
        let value = Double(counterStartValue) + Double(percentage) * Double(counterEndValue - counterStartValue)
        textLabel.text = "\(Int(round(value)))"

    }
    
    private func circularLayerFactory(strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let width = frame.size.width
        let height = frame.size.height
        
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = fillColor
        shapeLayer.lineCap = .round
        
        return shapeLayer
    }
    
}
