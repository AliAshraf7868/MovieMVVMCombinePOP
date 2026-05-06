//
//  MPGradientView.swift
//  MovieProject
//
//  Created by Ali Ashraf on 07/07/2025.
//

import SwiftUI

struct MPGradientView: View {
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .topLeading, startRadius: 5, endRadius: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    MPGradientView()
}
