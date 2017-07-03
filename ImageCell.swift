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

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
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
