//
//  PreViewURLView.swift
//  Presentation
//
//  Created by 유현진 on 11/25/24.
//

import SwiftUI
import Domain

struct PreViewURLView: View {
    @Binding var metaData: URLMetaData?
    var body: some View {
        if let metaData = metaData{
            HStack(spacing: 12){
                if let imageURL = metaData.thumbnailImageURL{
                    // TODO: 이미지 사이즈 리팩토링
                    AsyncImage(url: imageURL){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 8))
                }
                if let title = metaData.title, let description = metaData.description{
                    VStack(alignment: .leading, spacing: 10){
                        Text(title)
                            .font(.headline)
                            .bold()
                            .lineLimit(2)
                            .truncationMode(.tail)
                        
                        Text(description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(3)
                            .truncationMode(.tail)
                    }
                }
            }
            .transition(.opacity.combined(with: .scale))
        }
    }
}

#Preview {
    PreViewURLView(metaData: .constant(URLMetaData.sampleData))
}
