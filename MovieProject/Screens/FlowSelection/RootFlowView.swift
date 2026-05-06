//
//  FlowSelectionView.swift
//  MovieProject
//
//  Created by Ali Ashraf on 07/07/2025.
//

import SwiftUI


struct RootFlowView: View {
    @State private var isSplashActive = true
    @State private var selectedFlow: FlowType?

    private let api = MoviesAPI(client: APIClient())
    private let movieRepo = MovieRepository(local: MovieCoreDataDataSource(context: PersistenceController.shared.container.viewContext))

    enum FlowType {
        case basic, advance
    }

    var body: some View {
        Group {
            if isSplashActive {
                SplashScreen()
            } else if let flow = selectedFlow {
                switch flow {
                case .basic:
                    NavigationView {
                        MoviesHomeView(api: api, repository: movieRepo, onResetFlow: { selectedFlow = nil })
                    }
                    .navigationViewStyle(.stack)
                case .advance:
                    NavigationView {
                    MainAPPView(onResetFlow: { selectedFlow = nil })
                    }
                    .navigationViewStyle(.stack)
                }
            } else {
                FlowSelectionScreen { flow in
                    selectedFlow = flow
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isSplashActive = false
                }
            }
        }
    }
}




//struct FlowSelectionView: View {
//    @State private var selectedFlow: FlowType?
//
//    enum FlowType {
//        case basic
//        case advance
//    }
//
//    private let api = MoviesAPI(client: APIClient())
//    private let movieRepo = MovieRepository(local: MovieCoreDataDataSource(context: PersistenceController.shared.container.viewContext))
//
//    var body: some View {
//        if let flow = selectedFlow {
//            switch flow {
//            case .basic:
//                MoviesHomeView(api: api, repository: movieRepo)
//            case .advance:
//                MainAPPView()
//            }
//        } else {
//            VStack(spacing: 30) {
//                Text("Select Flow")
//                    .font(.largeTitle)
//                    .bold()
//
//                Button("Basic Flow") {
//                    selectedFlow = .basic
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                .padding(.horizontal, 40)
//
//                Button("Advance Flow") {
//                    selectedFlow = .advance
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                .padding(.horizontal, 40)
//            }
//        }
//    }
//}


#Preview {
//    FlowSelectionView()
}
