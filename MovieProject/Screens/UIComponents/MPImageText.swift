//
//  MPImageText.swift
//  MovieProject
//
//  Created by Ali Ashraf on 07/07/2025.
//

import SwiftUI

struct MPImageText: View {
    var imageName: String = "person.circle"
    var text: String = "Ali Ashraf"
    var font: Font? = .caption
    var imageWidth: CGFloat? = 32
    var imageHeight: CGFloat? = 32
    var foreGroundColor: Color? = .primary
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: imageName)
                .frame(width: imageWidth, height: imageHeight)
            Text(text)
                .font(.caption)
        }
        .foregroundStyle(foreGroundColor ?? .black)
    }
}

#Preview {
    MPImageText()
}
