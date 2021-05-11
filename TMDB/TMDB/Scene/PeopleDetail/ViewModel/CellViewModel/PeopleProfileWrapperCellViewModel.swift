//
//  PeopleProfileWrapperCellViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 18.04.2021.
//

import Foundation

struct PeopleProfileWrapperCellViewModel {
    
//    MARK: - Properties
    let id: String
    let name: String
    let placeOfBirth: String?
    let birthday: String?
    let deathday: String?
    let gender: Int
    let castList: [CastInMediaModel]?
    let crewList: [CrewInMediaModel]?
    
    let profilePath: String?
    
    var placeAndBirthdayText: String {
        switch (birthday, placeOfBirth) {
        case (.some(let birthday), .some(let placeOfBirth)):
            return birthday.toRussianDate().string + ", " + placeOfBirth
        case (.some(let birthday), .none):
            return birthday.toRussianDate().string
        case (.none, .some(let placeOfBirth)):
            return placeOfBirth
        case (.none, .none):
            return ""
        }
    }
    
    var deathdayText: String? {
        if let deathday = deathday {
            return deathday.toRussianDate().string
        } else {
            return nil
        }
    }
    
    var job: String {
        var job = [String]()
        guard let castList = castList, let crewList = crewList else { return "" }
        if !castList.isEmpty { job.append("Actor") }
        job.append(contentsOf: Array(Set(crewList.map { $0.job })))
        return job.joined(separator: ", ")
    }
    
    
    func profileImageData(completion: @escaping (Data?) -> Void) {
        guard let profilePath = profilePath else { completion(nil); return }
        
        guard let profileAbsoluteURL = ImageURL.profile(.w185, profilePath).fullURL else { completion(nil); return }
        
        profileAbsoluteURL.downloadImageData { (imageData) in
            completion(imageData)
        }
        
    }
    
    
//    MARK: - Init
    init(_ model: PeopleDetailModel) {
        self.id = "\(model.id)"
        self.name = model.name
        self.placeOfBirth = model.placeOfBirth
        self.birthday = model.birthday
        self.deathday = model.deathday
        self.profilePath = model.profilePath
        self.castList = model.combinedCredits?.cast
        self.crewList = model.combinedCredits?.crew
        self.gender = model.gender
    }
}
