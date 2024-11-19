//
//  ToastModel.swift
//  Presentation
//
//  Created by 유현진 on 11/17/24.
//

import Foundation

struct ToastModel: Equatable{
    let url: URL
    let duration: Double
    
    init(url: URL, duration: Double = 3.0) {
        self.url = url
        self.duration = duration
    }
    
    static var sampleModel: ToastModel{
        ToastModel(url: URL(string: "https://growingsaja.tistory.com/811")!)
    }
}
