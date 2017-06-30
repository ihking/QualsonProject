//
//  ImageDetailVC.swift
//  QualsonProject
//
//  Created by admin on 29/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ImageGuideVC: UIViewController {
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    var searchImages = [Image]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func setImages(images: [Image], index: IndexPath, word: String) {
        view.layoutIfNeeded()
        self.searchImages = images
        self.detailTitleLabel.text = word
        self.detailCollectionView.reloadData()
        //self.detailCollectionView.cellForItem(at: index)?.heroModifiers = [.fade, .translate(x:0, y:-250), .rotate(x:-1.6), .scale(1.5)]
        self.detailCollectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension ImageGuideVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.isHeroEnabled = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "detailCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ImageGuideCell
        cell?.content = self.searchImages[indexPath.row]
        return cell!
    }
}

