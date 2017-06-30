//
//  ImageCVCell.swift
//  QualsonProject
//
//  Created by admin on 29/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Kingfisher
//import SnapKit

//let isIOS7: Bool = !isIOS8
//let isIOS8: Bool = floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1
class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //if isIOS7 {
            // Need set autoresizingMask to let contentView always occupy this view's bounds, key for iOS7
            //self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //}
        //self.layer.masksToBounds = true
    }

    //TODO : Snapkit을 사용해서 dynamic view 구현..
    var content: Image? {
        didSet {
            if let content = content {
                imageView.kf.setImage(with: content.imageUrl)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
            }
        }
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? ImageLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.imageHeight
        }
    }
}
