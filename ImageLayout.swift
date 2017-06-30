//
//  ImageLayout.swift
//  QualsonProject
//
//  Created by admin on 29/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
protocol ImageLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForImageAtIndexPath indexPath:IndexPath , withWidth:CGFloat) -> CGFloat
}

class ImageLayoutAttributes:UICollectionViewLayoutAttributes {
    var imageHeight: CGFloat = 0.0
    
    override func copy(with zone: NSZone?) -> Any {
        let copy = super.copy(with: zone) as! ImageLayoutAttributes
        copy.imageHeight = imageHeight
        return copy
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let attributtes = object as? ImageLayoutAttributes {
            if( attributtes.imageHeight == imageHeight  ) {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class ImageLayout: UICollectionViewFlowLayout {
    var delegate:ImageLayoutDelegate!
    
    var numberOfColumns: Int = 2
    var cellPadding: CGFloat = 6.0

    fileprivate var cache = [ImageLayoutAttributes]()
    
    fileprivate var contentHeight:CGFloat  = 0.0
    fileprivate var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }

    override class var layoutAttributesClass : AnyClass {
        return ImageLayoutAttributes.self
    }

    override func prepare() {
        cache = [ImageLayoutAttributes]()
        if cache.isEmpty {
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            var column:Int = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                
                let width = columnWidth - cellPadding*2

                let imageHeight = delegate.collectionView(collectionView!, heightForImageAtIndexPath: indexPath , withWidth:width)

                let height = cellPadding +  imageHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

                let attributes = ImageLayoutAttributes(forCellWith: indexPath)
                attributes.imageHeight = imageHeight
                attributes.frame = insetFrame
                cache.append(attributes)

                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height

                column = column >= (numberOfColumns - 1) ? 0 : column+1
            }
        }
    }
    
    override var collectionViewContentSize : CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in cache {
            if attributes.frame.intersects(rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
