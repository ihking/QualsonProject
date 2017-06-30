//
//  UIImage+Ex.swift
//  QualsonProject
//
//  Created by admin on 29/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(at: CGPoint.zero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage!
    }
}
