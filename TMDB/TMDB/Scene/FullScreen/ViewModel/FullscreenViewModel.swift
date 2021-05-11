//
//  FullscreenViewModel.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.04.2021.
//

import Foundation
import RxSwift
import RxRelay

class FullScreenViewModel {
    
//    MARK: - Properties
    let imageCellViewModel = ReplaySubject<ImageCellViewModel>.create(bufferSize: 1)
    let contentForm = ReplaySubject<ContentForm>.create(bufferSize: 1)
    weak var coordinator: (ToImageFullScreenRoutable & NavigationCoordinator)?
    
    
//    MARK: - Init
    init(withImageCellViewModel imageCellViewModel: ImageCellViewModel, contentForm: ContentForm) {
        
        var imageCellViewModel = imageCellViewModel
        imageCellViewModel.changeImageType(to: .backdrop(size: .big))
        self.imageCellViewModel.onNext(imageCellViewModel)
        
        self.contentForm.onNext(contentForm)
    }
    
    
//    MARK: - Methods
    
}
