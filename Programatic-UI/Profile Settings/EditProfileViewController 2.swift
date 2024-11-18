import UIKit

class EditProfileViewController: UIViewController {
    
    
    private var infoData: [(label: String, value: String)] = [
        ("First Name", "John"),
        ("Last Name", "Doe"),
        ("Date of Birth", "5 Aug 2000"),
        ("Email", "johndoe@gmail.com"),
        ("Phone Number", "9872664287"),
        ("Password", "*********")
    ]
    
    
    private let tableView = UITableView()
    
   
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(named: "#005C78")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
  
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
    
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -20),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    

    @objc private func saveButtonTapped() {
    
        print("Save button tapped")
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let info = infoData[indexPath.row]
        
       
        let textField = UITextField()
        textField.text = info.value
        textField.placeholder = "Enter \(info.label)"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = UIColor.gray.withAlphaComponent(0.6)
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(textField)
       
        let editButton = UIButton(type: .system)
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.tintColor = .white
        editButton.backgroundColor = UIColor(hex: "#005C78")
        editButton.layer.cornerRadius = 15
        editButton.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -8),
            textField.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            
            editButton.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            editButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            editButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .black
        titleLabel.text = "Profile Information"
        
        headerView.addSubview(titleLabel)
        
     
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
 
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
