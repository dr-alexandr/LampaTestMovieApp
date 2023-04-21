//
//  ViewController.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 18.04.2023.
//

import UIKit

enum HomeScreenType {
    case popular
    case topRated
}

final class HomeScreenViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var viewModel = HomeScreenViewModel()
    
    var useCase: HomeScreenType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(MoviesTableViewCell.nib(), forCellReuseIdentifier: MoviesTableViewCell.identifier)
        refreshControl.addTarget(self, action: #selector(getMovies), for: .valueChanged)
        getMovies()
    }
    
    private func setupUI() {
        setupNavBarAppearance()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        homeTableView.backgroundColor = .clear
        homeTableView.tintColor = .clear
        homeTableView.addSubview(self.refreshControl)
    }
    
    private func setupNavBarAppearance() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: "AccentColor") ?? .orange]
        
        let logo = UIImage(named: "Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func reloadData() {
        refreshControl.endRefreshing()
        homeTableView.reloadData()
    }
    
    @objc func getMovies() {
        switch useCase {
        case .popular:
            viewModel.getMovies(usecase: TheMovieDbAPI.getPopularMovies)
        case .topRated:
            viewModel.getMovies(usecase: TheMovieDbAPI.getTopRatedMovies)
        default:
            viewModel.getMovies(usecase: TheMovieDbAPI.getPopularMovies)
        }
    }
}

extension HomeScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier,
                                                     for: indexPath) as! MoviesTableViewCell
        
        guard indexPath.row < viewModel.movies.count else { return cell }
        
        cell.movieTitleLabel.text = viewModel.movies[indexPath.row].title
        cell.movieDescriptionLabel.text = viewModel.movies[indexPath.row].overview
        cell.releaseDateLabel.text = viewModel.movies[indexPath.row].releaseDate
        
        guard let poster = viewModel.movies[indexPath.row].image else { return cell }
        
        cell.bannerImageView.image = poster
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let descriptionStoryboard = UIStoryboard(name: "DescriptionViewController", bundle: nil)
        guard let descriptionController = descriptionStoryboard.instantiateViewController(withIdentifier: "DescriptionViewController") as? DescriptionViewController
        else {return}
        
        descriptionController.viewModel.movieData = viewModel.movies[indexPath.row]
        descriptionController.viewModel.view = descriptionController
        
        navigationController?.pushViewController(descriptionController, animated: true)
    }
}
