//
//  FlowSelectionView.swift
//  MovieProject
//
//  Created by Ali Ashraf on 07/07/2025.
//

import SwiftUI

struct FlowSelectionScreen: View {
    var onSelect: (RootFlowView.FlowType) -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text("Select Flow")
                .font(.largeTitle)
                .bold()
            HStack {
                Button("Basic Flow") {
                    onSelect(.basic)
                }
                .frame(width: 150, height: 150)
                .buttonStyle(.borderedProminent)
                
                Spacer()
                    .frame(width: 30)
                Button("Advance Flow") {
                    onSelect(.advance)
                }
                .frame(width: 150, height: 150)
                .buttonStyle(.bordered)
                
            }
        }
    }
}

#Preview {
//    FlowSelectionScreen()
}
