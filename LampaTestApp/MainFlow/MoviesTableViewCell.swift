//
//  MoviesTableViewCell.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 19.04.2023.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var movieCell: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
        
    // MARK: View LifeCycle
    static func nib() -> UINib {
        return UINib(nibName: ControllersNames.moviesTableViewCell, bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        let margins = Constants.cellMargins
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = .clear
        
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.clipsToBounds = true
        bannerImageView.layer.cornerRadius = Constants.bannerCornerRadius
                
        movieCell.clipsToBounds = true
        movieCell.layer.cornerRadius = Constants.cellCornerRadius
        movieCell.backgroundColor = .white
        
        movieDescriptionLabel.numberOfLines = Constants.descriptionLabelNumberofLines
        
        selectionStyle = .none
    }
    
    // Clear data in reusable cells
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerImageView.image = UIImage(named: ImagesNames.moviePlaceholder)
        movieTitleLabel.text = nil
        movieDescriptionLabel.text = nil
        releaseDateLabel.text = nil
    }
}

// MARK: Constants
fileprivate enum Constants {
    static let cellMargins = UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
    static let cellCornerRadius: CGFloat = 12
    static let bannerCornerRadius: CGFloat = 8
    static let descriptionLabelNumberofLines = 0
}
