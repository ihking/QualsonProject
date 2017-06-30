//
//  String+Ex.swift
//  QualsonProject
//
//  Created by admin on 29/06/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

extension String {

    func setEncoding() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
}
