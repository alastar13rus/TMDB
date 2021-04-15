//
//  CastListViewModelTest.swift
//  Pods
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import XCTest
import RxSwift
import RxBlocking
@testable import TMDB

class CastListViewModelTest: XCTestCase {
    
    func test_initWithTitleAndItems() {
    
        let title = "Актеры"
        let viewModel = CastListViewModel(title: title, items: items)
        
        viewModel.items.enumerated().forEach { XCTAssertEqual($0.element.creditID, items[$0.offset].creditID) }
        
        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.items, items)
        XCTAssertEqual(viewModel.identity, title)
        XCTAssertEqual(
            try! viewModel.sectionedItems.toBlocking().first(),
            try! Observable.just(
                [CastCellViewModelSection(
                    title: title,
                    items: items)]).toBlocking().first())
    }
    
    func test_initWithOriginalAndItems() {
            let title = "Актеры 2"
        let viewModel = CastListViewModel(title: title, items: items)
        let viewModel2 = CastListViewModel(original: viewModel, items: items)
        
        viewModel2.items.enumerated().forEach { XCTAssertEqual($0.element.creditID, items[$0.offset].creditID) }
        
        XCTAssertEqual(viewModel2.title, title)
        XCTAssertEqual(viewModel.items, items)
        XCTAssertEqual(viewModel2.identity, title)
        XCTAssertEqual(
            try! viewModel.sectionedItems.toBlocking().first(),
            try! Observable.just(
                [CastCellViewModelSection(
                    title: title,
                    items: items)]).toBlocking().first())
    }
    
    
//    MARK: - Helpers
    var items: [CastCellViewModel] {
        [
            .init(CastModel(
                    adult: false,
                    gender: 1,
                    id: 1,
                    knownForDepartment: "Department 1",
                    name: "John",
                    originalName: "John",
                    popularity: 1,
                    profilePath: nil,
                    character: "Character 1",
                    creditID: "1",
                    order: 1)),
            
            .init(CastModel(
                    adult: false,
                    gender: 1,
                    id: 1,
                    knownForDepartment: "Department 2",
                    name: "Emily",
                    originalName: "Emily",
                    popularity: 1,
                    profilePath: nil,
                    character: "Character 2",
                    creditID: "1",
                    order: 1))
        ]
    }
    
}
