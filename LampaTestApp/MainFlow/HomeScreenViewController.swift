//
//  ViewController.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 18.04.2023.
//

import UIKit

// MARK: Type to choose Usecase of HomeScreenViewController
enum HomeScreenType {
    case popular
    case topRated
}

final class HomeScreenViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var homeTableView: UITableView!
    
    // MARK: Vars
    var refreshControl = UIRefreshControl()
    var viewModel = HomeScreenViewModel()
    
    // MARK: UsecaseType
    var useCase: HomeScreenType?
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        getMovies()
    }
    
    // MARK: SetupUI Methods
    private func setupUI() {
        setupNavBarAppearance()
        view.backgroundColor = UIColor(named: MyColors.backgroundColor)
        homeTableView.backgroundColor = .clear
        homeTableView.tintColor = .clear
        homeTableView.register(MoviesTableViewCell.nib(), forCellReuseIdentifier: MoviesTableViewCell.identifier)
        homeTableView.addSubview(self.refreshControl)
        refreshControl.addTarget(self, action: #selector(getMovies), for: .valueChanged)
    }
    
    private func setupNavBarAppearance() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: MyColors.accentColor) ?? .orange]
        let logo = UIImage(named: ImagesNames.logo)
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func reloadData() {
        refreshControl.endRefreshing()
        homeTableView.reloadData()
    }
    
    // MARK: GetData Method
    @objc func getMovies() {
        
        // Getting Data due to our Controller UsecaseType
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

// MARK: TableView DataSource/Delegate
extension HomeScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create custom Cell
        let cell = homeTableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier,
                                                     for: indexPath) as! MoviesTableViewCell
        
        // Checking actual data
        guard indexPath.row < viewModel.movies.count else { return cell }
        
        // Taking needed piece of data
        let cellData = viewModel.movies[indexPath.row]
        
        // Setting values
        cell.movieTitleLabel.text = cellData.title
        cell.movieDescriptionLabel.text = cellData.overview
        cell.releaseDateLabel.text = cellData.releaseDate
        
        // If Image exists -> Set that image
        guard let poster = cellData.image else { return cell }
        cell.bannerImageView.image = poster
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Init the description Controller
        let descriptionStoryboard = UIStoryboard(name: ControllersNames.descriptionViewController, bundle: nil)
        guard let descriptionController = descriptionStoryboard.instantiateViewController(withIdentifier: ControllersNames.descriptionViewController)
                as? DescriptionViewController
        else {return}
        
        // Giving data to description controller
        descriptionController.viewModel.movieData = viewModel.movies[indexPath.row]
        descriptionController.viewModel.view = descriptionController
        
        //Pushing description controller with data
        navigationController?.pushViewController(descriptionController, animated: true)
    }
}
