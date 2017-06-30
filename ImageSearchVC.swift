//
//  ImageSearchVC.swift
//  QualsonProject
//
//  Created by admin on 29/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Hero
import Alamofire
import AVFoundation

class ImageSearchVC: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet var imageSearchBar: UISearchBar!

    lazy var images = [[String:Any]]()
    lazy var searchImages = [Image]()
    var isDuringScroll: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex: 0x5BC4E8)
        self.navigationItem.titleView = self.imageSearchBar
        self.imageSearchBar.placeholder = "검색할 이미지를 입력해 주세요."

        self.mainCollectionView.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        if let layout = self.mainCollectionView.collectionViewLayout as? ImageLayout {
            layout.delegate = self
        }
    }

    //image search response
    func response(dic: Dictionary<String, Any>, statusCode: Int) {
        if let images = dic["items"] {
            self.images = images as! [[String : Any]]
            self.searchImages += self.images.map(Image.init) as! [Image]
            self.setCollectionView()
            self.isDuringScroll = false
        }
    }

    //collectionview paging
    func setCollectionView() {
        if let layout = self.mainCollectionView.collectionViewLayout as? ImageLayout {
            DispatchQueue.main.async(execute: {
                self.mainCollectionView.reloadData()
            })
            
            layout.prepare()
        }
    }

    //image search request
    func searchImage(word: String) {
        let searchWord: String = word.setEncoding()
        var startIndex: String {
            return String(describing:self.searchImages.count+1)
        }
        let api = ApiManager(path: "?query=\(searchWord)&start=\(startIndex)")
        api?.request(success: { (data: Dictionary, statusCode: Int) in self.response(dic: data as Dictionary, statusCode: statusCode) }, fail: { (error: Error?) in print(error as Any) })
    }
}

// MARK: - UISearchBar
extension ImageSearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let word = searchBar.text {
            self.clearData()
            self.searchImage(word: word)
        }
    }
    func clearData() {
        self.images = [[String:Any]]()
        self.searchImages = [Image]()
        self.setCollectionView()
    }
}

// MARK: - UICollectionView
extension ImageSearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.isHeroEnabled = true
        if let vc = self.viewController(forStoryboardName: "ImageDetail", forViewControllerName: "ImageGuideVC") as? ImageGuideVC {
            guard let word = self.imageSearchBar.text else { return }
            
            vc.setImages(images: self.searchImages, index:indexPath, word: word)
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "imageCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ImageCell
        cell?.content = self.searchImages[indexPath.row]

        //TODO: 수정필
        if indexPath.row == 0 && self.searchImages.count == 10 {
            self.mainCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                              at: .centeredVertically,
                                              animated: true)
        }

        return cell!
    }
    func viewController(forStoryboardName: String, forViewControllerName: String) -> UIViewController {
        return UIStoryboard(name: forStoryboardName, bundle: nil).instantiateViewController(withIdentifier:forViewControllerName)
    }
}

// MARK: - UIScrollView
extension ImageSearchVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height && !isDuringScroll {
            self.isDuringScroll = true
            DispatchQueue.main.async(execute: {
                if let word = self.imageSearchBar.text {
                    self.searchImage(word: word)
                }
            })
        }
    }
}

// MARK: - ImageLayoutDelegate(UICollectionViewLayout)
extension ImageSearchVC : ImageLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForImageAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        //TODO: 수정필
        if searchImages.count == 0 {
            return 0
        }

        let image = searchImages[indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: CGSize(width:image.width, height:image.height), insideRect: boundingRect)
        return rect.size.height
    }
}

