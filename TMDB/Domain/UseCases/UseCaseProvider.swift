//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Докин Андрей (IOS) on 16.05.2021.
//

import Foundation

protocol UseCaseProvider {
    func makeMediaListUseCase() -> MediaListUseCase
    func makeMovieDetailUseCase() -> MovieDetailUseCase
    
}
