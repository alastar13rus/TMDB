//
//  TVDetailUseCaseMock.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 07.06.2021.
//

import Foundation
@testable import Domain

final class TVDetailUseCaseMock: Domain.TVDetailUseCase {
    
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage], completion: @escaping (Result<TVDetailModel, Error>) -> Void) {
        repository("tvDetail_details_71712") { completion($0) }
    }
    
    func videos(mediaID: String, completion: @escaping (Result<VideoList, Error>) -> Void) {
        repository("tvDetail_videos_71712") { completion($0) }
    }
    
    func credits(mediaID: String, completion: @escaping (Result<CreditListResponse, Error>) -> Void) {
        
    }
    
    func aggregateCredits(mediaID: String, completion: @escaping (Result<TVAggregateCreditListResponse, Error>) -> Void) {
    
    }
    
    func repository<T: Decodable>(_ filename: String, _ completion: @escaping (Result<T, Error>) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: filename, ofType: "json")
        let json = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let decodedModel = try! JSONDecoder().decode(T.self, from: json)
        let result: Result<T, Error> = .success(decodedModel)
        completion(result)
    }
}
