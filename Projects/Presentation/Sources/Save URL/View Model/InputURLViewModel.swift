//
//  InputURLViewModel.swift
//  Presentation
//
//  Created by 유현진 on 11/26/24.
//

import SwiftUI
import Combine
import SwiftSoup

final class InputURLViewModel: ObservableObject{
    @Binding internal var isLoading: Bool
    @Binding internal var url: String
    @Binding internal var isInvalidURL: Bool
    
    init(isLoading: Binding<Bool>, url: Binding<String>, isInvalidURL: Binding<Bool>) {
        self._isLoading = isLoading
        self._url = url
        self._isInvalidURL = isInvalidURL
    }
    
    internal var URLStateSystemImage: String{
        isInvalidURL ? "exclamationmark.triangle.fill" : "checkmark.circle.fill"
    }
    internal var URLStateImageForegroundColor: Color{
        isInvalidURL ? .red : .green
    }
    
    internal func clearURL(){
        self.url = ""
    }
}
