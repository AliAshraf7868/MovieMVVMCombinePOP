//
//  SplashScreenView.swift
//  MovieProject
//
//  Created by Ali Ashraf on 07/07/2025.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var logoScale: CGFloat = 0.6
        @State private var logoOpacity: Double = 0.2
    var body: some View {
        ZStack {
            MPGradientView()
            VStack {
                Image("AppLogo")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .onAppear {
                    withAnimation(.easeInOut(duration: 1.0)) {
                            self.logoScale = 1.0
                            self.logoOpacity = 1.0
                        }
                    }
                Text("My Movie App")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}




#Preview {
    SplashScreen()
}
