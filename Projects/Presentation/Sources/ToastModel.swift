//
//  ToastModel.swift
//  Presentation
//
//  Created by 유현진 on 11/17/24.
//

import Foundation

struct ToastModel: Equatable{
    let url: URL
    
    static var sampleModel: ToastModel{
        ToastModel(url: URL(string: "https://growingsaja.tistory.com/811")!)
    }
}
