//
//  UIGradientImageView.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 21.04.2023.
//

import UIKit

// This class exists to create Shadow upon the ImageView programatically

class UIGradientImageView: UIImageView {
    
    let myGradientLayer: CAGradientLayer
    
    override init(frame: CGRect) {
        myGradientLayer = CAGradientLayer()
        super.init(frame: frame)
        self.setup()
        addGradientLayer()
    }
    
    func addGradientLayer() {
        if myGradientLayer.superlayer == nil {
            self.layer.addSublayer(myGradientLayer)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        myGradientLayer = CAGradientLayer()
        super.init(coder: aDecoder)
        self.setup()
        addGradientLayer()
    }
    
    func getColors() -> [CGColor] {
        return [Constants.firstColor, Constants.secondColor]
    }
    
    func getLocations() -> [NSNumber] {
        return Constants.location
    }
    
    func setup() {
        myGradientLayer.startPoint = Constants.gradientStartPoint
        myGradientLayer.endPoint = Constants.gradientEndPoint
        
        let colors = getColors()
        myGradientLayer.colors = colors
        myGradientLayer.isOpaque = false
        myGradientLayer.locations = getLocations()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myGradientLayer.frame = self.layer.bounds
    }
}

fileprivate enum Constants {
    static let firstColor = UIColor.clear.cgColor
    static let secondColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    static let location: [NSNumber] = [0.5,  0.9]
    static let gradientStartPoint = CGPoint(x: 0.5, y: 0)
    static let gradientEndPoint = CGPoint(x: 0.5, y: 1)
}
