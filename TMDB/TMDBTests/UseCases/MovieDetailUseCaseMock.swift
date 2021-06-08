//
//  MovieDetailUseCaseMock.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 08.06.2021.
//

import Foundation
@testable import Domain

final class MovieDetailUseCaseMock: Domain.MovieDetailUseCase {
    
    func details(mediaID: String, appendToResponse: [AppendToResponse], includeImageLanguage: [IncludeImageLanguage], completion: @escaping (Result<MovieDetailModel, Error>) -> Void) {
        repository("movieDetail_details_278") { completion($0) }
    }
    
    func videos(mediaID: String, completion: @escaping (Result<VideoList, Error>) -> Void) {
        repository("movieDetail_videos_278") { completion($0) }
    }
    
    func credits(mediaID: String, completion: @escaping (Result<CreditListResponse, Error>) -> Void) {
        
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
