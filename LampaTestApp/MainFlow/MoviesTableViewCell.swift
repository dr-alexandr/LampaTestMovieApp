//
//  MoviesTableViewCell.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 19.04.2023.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieCell: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
        
    static func nib() -> UINib {
        return UINib(nibName: "MoviesTableViewCell", bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        let margins = UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = .clear
        
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.clipsToBounds = true
        bannerImageView.layer.cornerRadius = 8
                
        movieCell.clipsToBounds = true
        movieCell.layer.cornerRadius = 12
        movieCell.backgroundColor = .white
        
        movieDescriptionLabel.numberOfLines = 0
        
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bannerImageView.image = UIImage(named: "MoviePlaceholder")
        movieTitleLabel.text = nil
        movieDescriptionLabel.text = nil
        releaseDateLabel.text = nil
    }

}
