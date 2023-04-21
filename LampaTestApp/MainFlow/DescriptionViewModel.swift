//
//  DescriptionViewModel.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 21.04.2023.
//

import UIKit

final class DescriptionViewModel {
    
    var movieData: MovieModel?
    weak var view: DescriptionViewController?
    
    func loadBanner(movie: MovieModel) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let bannerUrl = URL(string: Constants.urlForImages + (movie.backdropPath ?? "")),
                  let data = try? Data(contentsOf: bannerUrl),
                  let image = UIImage(data: data)
            else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self = self
                else {return}
                self.view?.movieBannerView.image = image
            }
        }
    }
    
}
