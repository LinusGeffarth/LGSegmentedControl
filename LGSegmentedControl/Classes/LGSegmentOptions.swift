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
    ///
    var animateStateChange: Bool = true
    
    var selectedColor: (background: UIColor, text: UIColor) = (#colorLiteral(red: 0.2196078431, green: 0.6235294118, blue: 0.9764705882, alpha: 1), .white)
    
    var deselectedColor: (background: UIColor, text: UIColor) = (.clear, .black)
    
    var font: UIFont = UIFont.systemFont(ofSize: 15)
    
    init() {  }
}
