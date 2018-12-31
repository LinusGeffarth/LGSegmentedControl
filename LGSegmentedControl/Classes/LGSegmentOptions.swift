//
//  LGOptions.swift
//  LGSegmentedControl
//
//  Created by Linus Geffarth on 05.12.18.
//

import UIKit

class LGSegmentOptions {
    
    /// Segments' corner radius, default: 6
    var cornerRadius: CGFloat = 6
    
    /// Determines whether there should be a short fade animation when selecting a segment
    var animateStateChange: Bool = true
    
    /// Background and text color of the selected segment
    var selectedColor: (background: UIColor, text: UIColor) = (#colorLiteral(red: 0.2196078431, green: 0.6235294118, blue: 0.9764705882, alpha: 1), .white)
    
    /// Background and text color of a deselected segment
    var deselectedColor: (background: UIColor, text: UIColor) = (.clear, .black)
    
    /// Font of the segments' title labels
    var font: UIFont = UIFont.systemFont(ofSize: 15)
    
    /// Background and text color of the segments' badges
    var badgeColor: (background: UIColor, text: UIColor) = (.red, .white)
    
    init() {  }
}
