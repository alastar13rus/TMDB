//
//  Department.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 29.04.2021.
//

import Foundation

struct Department {
    static func order(by department: String) -> Int {
        switch department {
        case "Writing": return 0
        case "Directing": return 1
        case "Production": return 2
        case "Actors": return 3
        case "Editing": return 4
        case "Art": return 5
        case "Crew": return 6
        case "Visual Effects": return 7
        case "Camera": return 8
        case "Sound": return 9
        case "Lighting": return 10
        case "Costume & Make-Up": return 11
        default: return 99
        }
    }
}
