//
//  CustomActivityIndicator.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 11.06.2021.
//

import UIKit

class CustomActivityIndicator: UIView {
    
// MARK: - Properties
    private var fillColor = UIColor.red.cgColor
    private var strokeColor = UIColor.red.cgColor
    private lazy var shapeInstanceCount = Int(bounds.width / 2)

    enum AnimationType {
        case move
        case rotate
    }
    
    let shape = CAShapeLayer()
    let replicator = CAReplicatorLayer()
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shape.strokeColor = self.strokeColor
        shape.fillColor = self.fillColor

    }
    
// MARK: - Methods
    func configure() {
        isUserInteractionEnabled = false
        shape.frame.size = .init(width: bounds.width / 10, height: bounds.height / 2)
        shape.anchorPoint = .init(x: 0.5, y: 1)
        shape.path = .init(ellipseIn: shape.frame, transform: nil)
        
        replicator.instanceCount = shapeInstanceCount
        
        let fullCircle: CGFloat = 2 * .pi
        let angle = fullCircle / CGFloat(replicator.instanceCount)
        
        replicator.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        replicator.bounds.size = CGSize(width: shape.frame.height * .pi, height: shape.frame.height)
        
        replicator.addSublayer(shape)
        self.layer.addSublayer(replicator)

    }
    
    func startAnimate(_ type: [AnimationType]) {
        isHidden = false
        type.forEach {
            switch $0 {
            case .move: move()
            case .rotate: rotate()
            }
        }
    }
    
    func stopAnimate() {
        isHidden = true
        shape.removeAllAnimations()
    }
    
    func setFillColor(_ color: UIColor) {
        self.fillColor = color.cgColor
    }
    
    func setStrokeColor(_ color: UIColor) {
        self.strokeColor = color.cgColor
    }
    
    private func move() {
        let move = CABasicAnimation(keyPath: "position.x")
        move.fromValue = shape.position.x
        move.toValue = shape.position.x + 20.0
        move.duration = 1
        move.repeatCount = .greatestFiniteMagnitude
        move.autoreverses = true
        shape.add(move, forKey: nil)
    }
    
    private func rotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = .greatestFiniteMagnitude
        shape.add(rotation, forKey: nil)
    }
}
