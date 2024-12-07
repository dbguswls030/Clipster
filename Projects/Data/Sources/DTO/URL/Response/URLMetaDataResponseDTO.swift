//
//  URLMetaDataResponseDTO.swift
//  Data
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Domain
import SwiftSoup

struct URLMetaDataResponseDTO: Decodable{
    
    static func parseHTML(_ html: String) throws -> URLMetaData? {
        let document = try SwiftSoup.parse(html)
        
        // Open Graph 메타데이터 추출
        let title = try document.select("meta[property=og:title]").attr("content")
        let description = try document.select("meta[property=og:description]").attr("content")
        let imageURLString = try document.select("meta[property=og:image]").attr("content")
        
        // URL로 변환
        let imageURL = URL(string: imageURLString)
        
        return URLMetaData(title: title, description: description, thumbnailImage: imageURL)
    }
}
