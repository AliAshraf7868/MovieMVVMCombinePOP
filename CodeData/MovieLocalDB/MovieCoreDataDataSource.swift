//
//  MovieCoreDataDataSource.swift
//  MovieProject
//
//  Created by Softmatic IOS Dev on 30/06/2025.
//

import Foundation
import CoreData

class MovieCoreDataDataSource: MovieLocalDataSource {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func save(movie: MovieModel) {
        let entity = MovieEntity(context: context)
        entity.id = Int64(movie.id)
        entity.title = movie.title
        entity.posterPath = movie.posterPath
        entity.overview = movie.overview
        entity.releaseDate = movie.releaseDate
        entity.voteAverage = movie.voteAverage ?? 0
        entity.adult = movie.adult ?? false
        entity.backdropPath = movie.backdropPath
        entity.originalLanguage = movie.originalLanguage
        entity.originalTitle = movie.originalTitle
        entity.popularity = movie.popularity ?? 0.0
        entity.video = movie.video ?? false
        entity.voteCount = Int64(movie.voteCount ?? 0)
        entity.voteAverage = movie.voteAverage ?? 4.0
        try? context.save()
    }

    func delete(movie: MovieModel) {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
        if let objects = try? context.fetch(fetchRequest) {
            for obj in objects {
                context.delete(obj)
            }
            try? context.save()
        }
    }

    func fetchSavedMovies() -> [MovieModel] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        guard let results = try? context.fetch(request) else { return [] }
        return results.map { $0.toMovieModel() }
    }

    func isMovieSaved(id: Int) -> Bool {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        let count = (try? context.count(for: request)) ?? 0
        return count > 0
    }
}

extension MovieEntity {
    func toMovieModel() -> MovieModel {
        return MovieModel(
            id: Int(self.id),
            title: self.title ?? "",
            originalTitle: self.originalTitle ?? "",
            overview: self.overview ?? "",
            releaseDate: self.releaseDate ?? "",
            posterPath: self.posterPath ?? "",
            backdropPath: self.backdropPath ?? "",
            genreIDs: [Int(self.genreIDs)],
            popularity: self.popularity,
            voteAverage: self.voteAverage,
            voteCount: Int(self.voteCount),
            adult: self.adult,
            originalLanguage: self.originalLanguage ?? "",
            video: self.video
        )
    }
}


