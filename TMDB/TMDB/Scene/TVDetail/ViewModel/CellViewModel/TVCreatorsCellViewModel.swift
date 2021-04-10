//
//  TVCreatorsCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 10.04.2021.
//

import Foundation

struct TVCreatorsCellViewModel {

let id: String
let creators: String

init(_ model: TVDetailModel) {
    self.id = String(model.id)
    self.creators = model.createdBy.map { $0.name }.joined(separator: ", ")
}

}

