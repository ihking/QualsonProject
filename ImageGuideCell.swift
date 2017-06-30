//
//  ImageDetailCell.swift
//  QualsonProject
//
//  Created by admin on 29/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Kingfisher

class ImageGuideCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var content: Image? {
        didSet {
            guard let content = content else { return }
            self.titleLabel.text = content.title
            self.imageView.kf.setImage(with: content.imageUrl)
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.clipsToBounds = true

        }
    }
}
