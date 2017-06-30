//
//  ImageCVCell.swift
//  QualsonProject
//
//  Created by admin on 29/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Kingfisher

let isIOS7: Bool = !isIOS8
let isIOS8: Bool = floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1

//@IBOutlet fileprivate weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!

class ImageCVCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        if isIOS7 {
            // Need set autoresizingMask to let contentView always occupy this view's bounds, key for iOS7
            self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        self.layer.masksToBounds = true
    }
    
    
    
    var content: Content? {
        didSet {
            if let content = content {
                imageView.kf.setImage(with: content.imageUrl)
                print("KFKFKF")
                print(imageView)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                print("KFKFKF22")
                print(imageView)
            }
        }
    }

    /*var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                captionLabel.text = photo.caption
                commentLabel.text = photo.comment
            }
        }
    }*/
}
