//
//  HomeScreenViewModel.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 18.04.2023.
//

import UIKit

final class HomeScreenViewModel {
    
    private let networkManager = NetworkManager()
    
    weak var coordinator: HomeScreenCoordinator?
    weak var view: HomeScreenViewController?
    
    var movies: [MovieModel] = []
    
    func getMovies(usecase API: API) {
        let endpoint = API
        networkManager.request(endpoint: endpoint) { [weak self] (result: Result<CollectionMoviesModel, Error>) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                guard let results = response.results else {return}
                self.movies = self.movieMapper(popularMovieModels: results) { [weak self] in
                    self?.view?.reloadData()
                }
                self.view?.reloadData()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showAlert(title: "Sorry...", message: error.localizedDescription)
                }
            }
        }
    }
    
    func movieMapper(popularMovieModels: [MovieResult], reloadCompletion: (()->Void)?) -> [MovieModel] {
        var result: [MovieModel] = []
        for (index, movie) in popularMovieModels.enumerated() {
            let formattedDate = convertDate(date: movie.releaseDate)
            
            let newMovie = MovieModel(adult: movie.adult, backdropPath: movie.backdropPath, genreIDS: movie.genreIDS, id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: formattedDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, image: nil)
            DispatchQueue.global(qos: .userInteractive).async {
                guard let iconUrl = URL(string: Constants.urlForImages + (movie.posterPath ?? "")),
                      let data = try? Data(contentsOf: iconUrl),
                      let image = UIImage(data: data)
                else {return}
                DispatchQueue.main.async { [weak self] in
                    guard let self = self,
                          index < self.movies.count,
                          self.movies[index].id == newMovie.id
                    else {return}
                    self.movies[index].image = image
                    reloadCompletion?()
                }
            }
            result.append(newMovie)
        }
        return result
    }
    
    private func convertDate(date: String?) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterReturn = DateFormatter()
        dateFormatterReturn.dateFormat = "dd.MM.yyyy"
        
        guard let actualDate = date,
              let myDate = dateFormatterGet.date(from: actualDate) else { return "" }
        let formattedDate = dateFormatterReturn.string(from: myDate)
        
        return formattedDate
    }
}
