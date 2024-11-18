//
//  tabbar.swift
//  Programatic-UI
//
//  Created by Piyush on 09/11/24.
//
import UIKit

// MARK: - Tab Bar Controller
class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        customizeTabBar()
    }
    
    private func setupTabs() {
        // Create view controllers for each tab
        
        let home = HomeViewController() // changed later
        let Explore = fifth()
        let libraryVC = LibraryViewController()
        let rent = rentvc() //to change
        
        // Set titles and images for each tab
        Explore.tabBarItem = UITabBarItem(
            title: "Explore",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        home.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house")
        )
     
        rent.tabBarItem = UITabBarItem(
            title: "Rent",
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart")
        )
        libraryVC.tabBarItem = UITabBarItem(
            title: "Library",
            image: UIImage(systemName: "books.vertical"),
            selectedImage: UIImage(systemName: "books.vertical.fill")
        )
        
        
        // Wrap each VC in a navigation controller
        let homeNav = UINavigationController(rootViewController: home)
        let searchNav = UINavigationController(rootViewController: Explore)
        let libraryNav = UINavigationController(rootViewController: libraryVC)
        let profileNav = UINavigationController(rootViewController: rent)
        
        // Set the view controllers for the tab bar
        setViewControllers([homeNav, searchNav, libraryNav, profileNav], animated: true)
    }
    
    private func customizeTabBar() {
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray2
    }
}

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Home"
        
        // Add a profile button at the top-right corner
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(profileButtonTapped)
        )
        navigationItem.rightBarButtonItem = profileButton
        
        // Add a welcome label
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to Home"
        welcomeLabel.font = .systemFont(ofSize: 24, weight: .bold)
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
  
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           
        ])
    }

    
    @objc private func profileButtonTapped() {
        // Redirect to the Profile page
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}


// MARK: - Search View Controller
class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Search"
        
        // Add search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search books..."
        navigationItem.searchController = searchController
        
        // Add a label
        let searchLabel = UILabel()
        searchLabel.text = "Search your favorite books"
        searchLabel.font = .systemFont(ofSize: 20, weight: .medium)
        searchLabel.textAlignment = .center
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchLabel)
        
        NSLayoutConstraint.activate([
            searchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Library View Controller
class LibraryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Library"
        
        // Add a collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Profile View Controller
class rentvc: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Hide the back button
        navigationItem.hidesBackButton = true
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Profile"
        
        // Create profile UI elements
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Profile image
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .systemGray
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Name label
        let nameLabel = UILabel()
        nameLabel.text = "John Doe"
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        // Email label
        let emailLabel = UILabel()
        emailLabel.text = "john.doe@example.com"
        emailLabel.font = .systemFont(ofSize: 16, weight: .regular)
        emailLabel.textColor = .secondaryLabel
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
