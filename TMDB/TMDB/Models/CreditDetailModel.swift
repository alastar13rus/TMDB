//
//  CreditDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation

struct CreditDetailModel: Decodable {

    let person: Person
    
    struct Person: Decodable {
        let id: Int
        let name: String
    }
}

