//
//  GroupedCrewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 22.04.2021.
//

import Foundation
import RxDataSources

struct GroupedCrewModel: Decodable, Hashable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Float
    let profilePath: String?
    let creditID: String
    let jobs: String
}

extension GroupedCrewModel: IdentifiableType {
    var identity: Int { return id }
}

extension GroupedCrewModel: Comparable {
    static func < (lhs: GroupedCrewModel, rhs: GroupedCrewModel) -> Bool {
        return lhs.popularity < rhs.popularity
    }
}
