//
//  SearchImage.swift
//  QualsonProject
//
//  Created by admin on 28/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import Kingfisher

public struct Image {
    public let link: String
    public let title: String
    public let imageUrl: URL
    public let width:  Int
    public let height: Int
    public let heroID: String
}

extension Image {
      public init?(json: [String: Any]) {
        guard
        let link = json["link"] as? String,
        let title = json["title"] as? String,
        let height = json["sizeheight"] as? Int ?? Int(json["sizeheight"] as! String),
        let width = json["sizewidth"] as? Int ?? Int(json["sizewidth"] as! String)
        else { return nil }
        self.link = link
        self.title    = title
        self.imageUrl = URL(string: link)!
        self.width = width
        self.height = height
        self.heroID = "mainCell"
    }
}
