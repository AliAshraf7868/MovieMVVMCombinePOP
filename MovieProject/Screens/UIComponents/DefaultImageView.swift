//
//  DefaultImageView.swift
//  MovieProject
//
//  Created by Ali Ashraf on 04/07/2025.
//

import SwiftUI

struct DefaultImageView: View {
    var body: some View {
        
        Image(MPImageName.defaultImageName)
            .resizable()
            .scaledToFit()
//            .frame(height: 250)
            .clipped()
            .cornerRadius(10)
    }
}

#Preview {
    DefaultImageView()
}
