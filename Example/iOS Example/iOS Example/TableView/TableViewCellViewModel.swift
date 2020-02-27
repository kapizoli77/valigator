//
//  TableViewCellViewModel.swift
//  iOS Example
//
//  Created by Kapi Zoltán on 2020. 02. 27..
//  Copyright © 2020. kapizoli77. All rights reserved.
//

import Foundation

struct TableViewCellViewModel {
    var identifier: Int
    var title: String
    var textProvider: (Int) -> String?
    var fieldChangeHandler: (Any?, Int, Bool) -> Void
}
