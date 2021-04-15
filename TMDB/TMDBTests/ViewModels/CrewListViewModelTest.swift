//
//  CrewListViewModelTest.swift
//  TMDBTests
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import XCTest
import RxSwift
import RxBlocking
@testable import TMDB

class CrewListViewModelTest: XCTestCase {
    
    func test_initWithTitleAndItems() {
    
        let title = "Создатели"
        let viewModel = CrewListViewModel(title: title, items: items)
        
        viewModel.items.enumerated().forEach { XCTAssertEqual($0.element.creditID, items[$0.offset].creditID) }
        
        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.items, items)
        XCTAssertEqual(viewModel.identity, title)
        XCTAssertEqual(viewModel.items[0].name, "John")
        XCTAssertEqual(viewModel.items[1].name, "Emily")
        XCTAssertEqual(
            try! viewModel.sectionedItems.toBlocking().first(),
            try! Observable.just(
                [CrewCellViewModelSection(
                    title: title,
                    items: items)]).toBlocking().first())
    }
    
    func test_initWithOriginalAndItems() {
            let title = "Создатели 2"
        let viewModel = CrewListViewModel(title: title, items: items)
        let viewModel2 = CrewListViewModel(original: viewModel, items: items)
        
        viewModel2.items.enumerated().forEach { XCTAssertEqual($0.element.creditID, items[$0.offset].creditID) }
        
        XCTAssertEqual(viewModel2.title, title)
        XCTAssertEqual(viewModel.items, items)
        XCTAssertEqual(viewModel2.identity, title)
        XCTAssertEqual(viewModel.items[0].name, "John")
        XCTAssertEqual(viewModel.items[1].name, "Emily")
        XCTAssertEqual(
            try! viewModel.sectionedItems.toBlocking().first(),
            try! Observable.just(
                [CrewCellViewModelSection(
                    title: title,
                    items: items)]).toBlocking().first())
    }
    
    
//    MARK: - Helpers
    var items: [CrewCellViewModel] {
        [
            .init(CrewModel(
                    adult: false,
                    gender: 1,
                    id: 1,
                    knownForDepartment: "",
                    name: "John",
                    originalName: "John",
                    popularity: 1,
                    profilePath: nil,
                    creditID: "1",
                    department: "Department",
                    job: "Director")),
            
            .init(CrewModel(
                    adult: false,
                    gender: 2, id: 2,
                    knownForDepartment: "",
                    name: "Emily",
                    originalName: "Emily",
                    popularity: 1,
                    profilePath: nil,
                    creditID: "1",
                    department: "Department",
                    job: "Producer"))
        ]
    }
    
}
