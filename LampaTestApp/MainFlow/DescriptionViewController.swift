//
//  DescriptionViewController.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 21.04.2023.
//

import UIKit

final class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var movieBannerView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var viewModel = DescriptionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavController()
        
        if let data = viewModel.movieData {
            movieTitleLabel.text = data.title
            descriptionTextLabel.text = data.overview
            rateLabel.text = "\(data.voteAverage ?? 0)"
            releaseDateLabel.text = data.releaseDate
            viewModel.loadBanner(movie: data)
        }
        
        movieBannerView.clipsToBounds = true
        movieBannerView.layer.cornerRadius = 8
        
        playButton.setTitle("", for: .normal)
    }
    
    private func setupNavController() {
        //Setting the BackButton Appearance
        let leftItem = UIImage(named: "BackButton")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(UINavigationController.popViewController(animated:)))
        self.navigationItem.leftBarButtonItem?.image = leftItem
        
        //Setting the Title Appearance
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: "AccentColor") ?? .orange]
        let logo = UIImage(named: "Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if let movieTitle = viewModel.movieData?.title {
            showAlert(title: "Here you will find", message: movieTitle)
        }
    }
    
    
}
