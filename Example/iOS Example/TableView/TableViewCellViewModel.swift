//
//  TableViewCellViewModel.swift
//  iOS Example
//

import Foundation

enum CellErrorState {
    case hide
    case show(String?)
}

struct TableViewCellViewModel {
    var identifier: Int
    var title: String
    var errorState: CellErrorState
    var textProvider: (Int) -> String?
    var fieldChangeHandler: (Any?, Int, Bool) -> Void
}
