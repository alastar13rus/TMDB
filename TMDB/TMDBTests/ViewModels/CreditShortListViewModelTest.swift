//
//  CreditShortListViewModelTest.swift
//  Pods
//
//  Created by Докин Андрей (IOS) on 13.04.2021.
//

import XCTest
import RxSwift
import RxBlocking
@testable import TMDB

class CreditShortListViewModelTest: XCTestCase {
    
    func test_initWithTitleAndItems() {
    
        let title = "Показать еще"
        
        
        let viewModel = CreditShortListViewModel(title: title, items: castItems, coordinator: nil, networkManager: nil, mediaID: "1399", creditType: .cast)
        
        let viewModel2 = CreditShortListViewModel(title: title, items: crewItems, coordinator: nil, networkManager: nil, mediaID: "1399", creditType: .crew)
        
        viewModel.items.enumerated().forEach {
            switch $0.element {
            case .cast(let vm):
                switch castItems[$0.offset] {
                case .cast(let castVM): XCTAssertEqual(vm.creditID, castVM.creditID)
                default: break
                }
                
            case .crew(let vm):
                switch crewItems[$0.offset] {
                case .crew(vm: let crewVM): XCTAssertEqual(vm.creditID, crewVM.creditID)
                default: break
                }
            default: break
            }
        }
        
        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.items, castItems)
        XCTAssertEqual(viewModel2.items, crewItems)
        XCTAssertEqual(viewModel.identity, title)
        
        switch viewModel.creditType {
        case .cast:
            XCTAssertEqual(
                try! viewModel.sectionedItems.toBlocking().first(),
                try! Observable<[CreditCellViewModelMultipleSection]>.just([
                    .castSection(title: title, items: castItems),
                    showMoreCastSection
                ]).toBlocking().first())
            
        case .crew:
            XCTAssertEqual(
                try! viewModel2.sectionedItems.toBlocking().first(),
                try! Observable<[CreditCellViewModelMultipleSection]>.just([
                    .crewSection(title: title, items: crewItems),
                    showMoreCrewSection
                ]).toBlocking().first())
            
            
        }
        
    }
    
    func test_initWithOriginalAndItems() {
        let title = "Показать еще"
        let viewModel = CreditShortListViewModel(title: title, items: castItems)
        let viewModel2 = CreditShortListViewModel(original: viewModel, items: crewItems)
        
        viewModel2.items.enumerated().forEach {
            switch $0.element {
            case .cast(let vm):
                switch castItems[$0.offset] {
                case .cast(let castVM): XCTAssertEqual(vm.creditID, castVM.creditID)
                default: break
                }
                
            case .crew(let vm):
                switch crewItems[$0.offset] {
                case .crew(vm: let crewVM): XCTAssertEqual(vm.creditID, crewVM.creditID)
                default: break
                }
            default: break
            }
        }
        
        XCTAssertEqual(viewModel2.title, title)
        XCTAssertEqual(viewModel.items, castItems)
        XCTAssertEqual(viewModel2.items, crewItems)
        XCTAssertEqual(viewModel2.identity, title)
        
        switch viewModel.creditType {
        case .cast:
            XCTAssertEqual(
                try! viewModel.sectionedItems.toBlocking().first(),
                try! Observable<[CreditCellViewModelMultipleSection]>.just([
                    .castSection(title: title, items: castItems),
                    showMoreCastSection
                ]).toBlocking().first())
            
        case .crew:
            XCTAssertEqual(
                try! viewModel2.sectionedItems.toBlocking().first(),
                try! Observable<[CreditCellViewModelMultipleSection]>.just([
                    .crewSection(title: title, items: crewItems),
                    showMoreCrewSection
                ]).toBlocking().first())
            
            
        }
    }
    
    
//    MARK: - Helpers
    
    var castModel: CastModel {
        .init(adult: false,
              gender: 1,
              id: 1,
              knownForDepartment: "Department 1",
              name: "John",
              originalName: "John",
              popularity: 1,
              profilePath: nil,
              character: "Character 1",
              creditID: "1",
              order: 1
        )
    }
    
    var castModel2: CastModel {
        .init(adult: false,
              gender: 1,
              id: 1,
              knownForDepartment: "Department 2",
              name: "Emily",
              originalName: "Emily",
              popularity: 1,
              profilePath: nil,
              character: "Character 2",
              creditID: "1",
              order: 1
        )
    }
    
    var crewModel: CrewModel {
        CrewModel(
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
            job: "Director")
    }
    
    var crewModel2: CrewModel {
        CrewModel(
            adult: false,
            gender: 2, id: 2,
            knownForDepartment: "",
            name: "Emily",
            originalName: "Emily",
            popularity: 1,
            profilePath: nil,
            creditID: "1",
            department: "Department",
            job: "Producer")
    }
    
    var showMoreCastSection: CreditCellViewModelMultipleSection {
        return .showMoreSection(title: "Показать еще", items: [])
    }
    
    var showMoreCrewSection: CreditCellViewModelMultipleSection {
        return .showMoreSection(title: "Показать еще", items: [])
    }
    
    
    var castItems: [CreditCellViewModelMultipleSection.SectionItem] {
        [
            .cast(vm: CastCellViewModel(castModel)),
            .cast(vm: CastCellViewModel(castModel2)),
        ]
    }
    
    var crewItems: [CreditCellViewModelMultipleSection.SectionItem] {
        [
            .crew(vm: CrewCellViewModel(crewModel)),
            .crew(vm: CrewCellViewModel(crewModel2)),
        ]
    }
}
