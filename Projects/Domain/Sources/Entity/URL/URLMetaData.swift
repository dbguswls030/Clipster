//
//  URLMetaData.swift
//  Domain
//
//  Created by 유현진 on 12/3/24.
//

import Foundation

public struct URLMetaData{
    public var title: String?
    public var description: String?
    public var thumbnailImage: URL?
    
    public init(title: String? = nil, description: String? = nil, thumbnailImage: URL? = nil) {
        self.title = title
        self.description = description
        self.thumbnailImage = thumbnailImage
    }
    
    static public var sampleData: URLMetaData{
        return URLMetaData(
            title: "[SwiftUI] NavigationStack 화면전환 방법 고민정리 (feat. Router 구현)",
            description: "안녕하세요~iOS16+부터 사용할 수 있는 NavigationStack을 이용한 라우터 로직을 만들었는데요그 과정에서 생각한 방법과 겪은 고민을 정리해보려합니다! 네비게이션 스택이뭐야? 하시는분들은https://nsios.tistory.com/199 [SwiftUI] NavigationStack안녕하세요! SwiftUI에서 항상 느꼇던 불편한점중 하나가 네비게이션이였는데요 이를 해결해주는게 나온지 좀 됐지만 이제 해보려합니다! (진작에 나왔을 녀석이여야 했는데...) iOS16 타겟을 쓸일nsios.tistory.com쓰윽 훑고오셔도 좋을것같습니다!우선 제일 간단한 방법부터 시작해보겠습니다~! 아! 그전에이 모든 라우팅 로직들은 모듈화를 했다는 가정하에 이뤄졌습니다.예제에서는 아주 간단한 구조로 사용했어..",
            thumbnailImage: URL(string: "https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fypn5C%2FbtsGY8CFdMb%2FSBVknuOs4TmrocmmyGyms1%2Ftfile.svg")!
        )
    }
}
