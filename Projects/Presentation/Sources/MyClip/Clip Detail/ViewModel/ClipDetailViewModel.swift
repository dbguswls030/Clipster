//
//  ClipDetailViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/12/25.
//

import Foundation
import Domain

final public class ClipDetailViewModel: ObservableObject{
    
    let useCase: ClipUseCaseProtocol
    var URLClipModel: URLClipModel
    
    public init(useCase: ClipUseCaseProtocol, URLClipModel: URLClipModel) {
        self.useCase = useCase
        self.URLClipModel = URLClipModel
    }
    
    
}
