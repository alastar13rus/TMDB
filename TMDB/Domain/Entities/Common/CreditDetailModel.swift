//
//  CreditDetailModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation

public struct CreditDetailModel: Decodable {

    public let person: Person
    
    public struct Person: Decodable {
        public let id: Int
        public let name: String
    }
}

