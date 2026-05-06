//
//  UpcomingMoviePosterView.swift
//  MovieProject
//
//  Created by Ali Ashraf on 07/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct UpcomingMoviePosterView: View {
    let movie: MovieModel
    let isSaved: Bool
    let onSaveTapped: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                ZStack(alignment: .bottomLeading) {
                    
                    WebImage(url: URL(string: "\(API.imageBaseURL)\(movie.backdropPath ?? "")"))
                        .resizable()
                        .indicator(.activity)
                        .scaledToFill()
                        .frame(width: 220, height: 140)
                        .clipped()
                        .cornerRadius(10)
                        .shadow(radius: 4)
                    
                    if let title = movie.title {
                        Text(title)
                            .font(.system(size: 16))
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.8)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(5)
                            .padding([.leading, .bottom], 8)
                    }
                }
                
                Spacer()
            }
            
            // Leading badge for remaining days or date
            VStack {
                Text(remainingDaysText(for: movie.releaseDate))
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(6)
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .offset(y: -5)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: onSaveTapped) {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.black.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(8)
                }
                Spacer()
            }
        }
    }
    
    private func remainingDaysText(for dateString: String?) -> String {
        guard let dateString = dateString,
              let date = DateFormatter.releaseDate.date(from: dateString)
        else { return "" }
        
        let daysLeft = Calendar.current.dateComponents([.day], from: Date(), to: date).day ?? 0
        
        if daysLeft < 7 && daysLeft >= 0 {
            return "\(daysLeft) days left"
        } else {
            return DateFormatter.shortDate.string(from: date)
        }
    }
}

#Preview {
    UpcomingMoviePosterView(
        movie: MovieModel(
            id: 1,
            title: "This is the name of sample movie which is look like this Sample Movie",
            originalTitle: "Sample Movie Original",
            overview: "This is a sample movie overview.",
            releaseDate: "2025-01-01",
            posterPath: "/skSoZMossoIYvzOf2UnaWqLscJl.jpg",
            backdropPath: nil,
            genreIDs: [12, 28],
            popularity: 100.0,
            voteAverage: 7.5,
            voteCount: 500,
            adult: false,
            originalLanguage: "en",
            video: false
        ),
        isSaved: true,
        onSaveTapped: {}
    )
}
