import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    
  
    private let accountOptions = [
        "Edit Profile",
        "Notifications",
        "Book Support",
        "Security"
    ]
    
    private let actionOptions = [
        "Report a Problem",
        "Log Out",
        "Delete Account"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "a")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
    
        let nameLabel = UILabel()
        nameLabel.text = "Narendra Singh Rathore"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableHeaderView = UIView()
        view.addSubview(tableView)
        
       
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accountOptions.count
        case 1:
            return actionOptions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = accountOptions[indexPath.row]
        case 1:
            cell.textLabel?.text = actionOptions[indexPath.row]
        default:
            break
        }
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = UIColor(hex: "#005C78")
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Handle actions when a cell is tapped
        switch indexPath.section {
        case 0:
            // Account options
            handleAccountOptionSelection(indexPath.row)
        case 1:
            // Actions options
            handleActionOptionSelection(indexPath.row)
        default:
            break
        }
    }
    
    private func handleAccountOptionSelection(_ row: Int) {
        switch row {
        case 0: // "Edit Profile"
            let editProfileVC = EditProfileViewController()
            navigationController?.pushViewController(editProfileVC, animated: true)
        case 1: // "Notifications"
            print("Navigating to Notifications screen")
        case 2: // "Book Support"
            let bookSupportVC = BookSupportViewController()
            navigationController?.pushViewController(bookSupportVC, animated: true)
        case 3: // "Security"
            print("Navigating to Security screen")
        default:
            break
        }
    }
    
    private func handleActionOptionSelection(_ row: Int) {
        switch row {
        case 0: // "Report a Problem"
            let raiseProblemVC = RaiseProblemViewController()
            navigationController?.pushViewController(raiseProblemVC, animated: true)
        case 1: // "Log Out"
            print("Logging out")
        case 2: // "Delete Account"
            print("Deleting account")
        default:
            break
        }
    }
    
    // MARK: - UITableViewDelegate (Headers)
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Account"
        case 1:
            return "Actions"
        default:
            return nil
        }
    }
    
    // MARK: - Custom Header View
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        
        switch section {
        case 0:
            titleLabel.text = "Account"
        case 1:
            titleLabel.text = "Actions"
        default:
            break
        }
        
        headerView.addSubview(titleLabel)
        
        // Constraints for the title label
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    // MARK: - Custom Header Height
    
    // This method sets the height of the header to increase space between the header and the list
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60 // Adjust height to increase space
    }
}
