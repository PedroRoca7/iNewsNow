//
//  TabBarView.swift
//  INewsNow
//
//  Created by Pedro Henrique on 30/03/24.
//

import UIKit

final class TabBarView: UITabBar {
    
    private var shapeLayer: CAShapeLayer?
    private var centeredWidth: CGFloat = 45
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    private func setupTabBar() {
        self.backgroundColor = .red
        self.tintColor = .white
        self.unselectedItemTintColor = .lightGray
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = getPath()
        
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor.backgroundColor?.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.2
        
        if let olhShape = self.shapeLayer {
            self.layer.replaceSublayer(olhShape, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func getPath() -> CGPath {
        let height: CGFloat = 47
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: centeredWidth - height * 2, y: 0))
        
        path.addCurve(
            to: CGPoint(x: centeredWidth, y: height),
            controlPoint1: CGPoint(x: centeredWidth - 30, y: 0),
            controlPoint2: CGPoint(x: centeredWidth - 35, y: height))
        
        path.addCurve(
            to: CGPoint(x: centeredWidth + height * 2, y: 0),
            controlPoint1: CGPoint(x: centeredWidth + 35, y: height),
            controlPoint2: CGPoint(x: centeredWidth + 30, y: 0))
        
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        
        return path.cgPath
    }
    
    func updateCurveForTappedIndex() {
        guard let selectedTabView = self.selectedItem?.value(forKey: "view") as? UIView else { return }
        
        self.centeredWidth = selectedTabView.frame.origin.x + (selectedTabView.frame.width / 2)
        
        addShape()
    }
}
