//
//  DescriptionViewController.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 21.04.2023.
//

import UIKit

final class DescriptionViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var movieBannerView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: Vars
    var viewModel = DescriptionViewModel()
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: SetupUI Methods
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
        movieBannerView.layer.cornerRadius = Constants.bannerCornerRadius
        
        playButton.setTitle("", for: .normal)
    }
    
    private func setupNavController() {
        //Setting the BackButton Appearance
        let leftItem = UIImage(named: ImagesNames.backButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(UINavigationController.popViewController(animated:)))
        self.navigationItem.leftBarButtonItem?.image = leftItem
        
        //Setting the Title Appearance
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.init(named: MyColors.accentColor) ?? .orange
        ]
        let logo = UIImage(named: ImagesNames.logo)
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    // MARK: IBActions
    @IBAction func playButtonPressed(_ sender: Any) {
        if let movieTitle = viewModel.movieData?.title {
            showAlert(title: Constants.alertTitleText, message: movieTitle)
        }
    }
    
}

// MARK: Constants
fileprivate enum Constants {
    static let bannerCornerRadius: CGFloat = 8
    static let alertTitleText = "Here you will find"
}
