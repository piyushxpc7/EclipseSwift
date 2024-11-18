import UIKit

class ThirdScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let headingLabel = UILabel()
        headingLabel.text = "Hey there!"
        headingLabel.font = UIFont.boldSystemFont(ofSize: 32)
        headingLabel.textColor = .black
        headingLabel.textAlignment = .left
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headingLabel)
        
        let subheadingLabel = UILabel()
        subheadingLabel.text = "Enter your information to get started with your reading journey"
        subheadingLabel.font = UIFont.systemFont(ofSize: 16)
        subheadingLabel.textColor = .gray
        subheadingLabel.numberOfLines = 0
        subheadingLabel.textAlignment = .left
        subheadingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subheadingLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let nameTextField = createTextField(placeholder: "Name", labelColor: UIColor(hex: "#005C78"))
        let emailTextField = createTextField(placeholder: "Email", labelColor: UIColor(hex: "#005C78"), keyboardType: .emailAddress)
        let birthdateTextField = createTextField(placeholder: "Birthdate", labelColor: UIColor(hex: "#005C78"))
        let passwordTextField = createSecureTextField(placeholder: "Password", labelColor: UIColor(hex: "#005C78"))
        
        [nameTextField, emailTextField, birthdateTextField, passwordTextField].forEach {
            stackView.addArrangedSubview($0)
        }
        
        let createAccountButton = UIButton(type: .system)
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.backgroundColor = UIColor(hex: "#005C78")
        createAccountButton.layer.cornerRadius = 12
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        view.addSubview(createAccountButton)
        
        let alreadyHaveAccountLabel = UILabel()
        alreadyHaveAccountLabel.text = "Already have an account?"
        alreadyHaveAccountLabel.font = UIFont.systemFont(ofSize: 14)
        alreadyHaveAccountLabel.textColor = .gray
        alreadyHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(UIColor(hex: "#005C78"), for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        let footerStack = UIStackView(arrangedSubviews: [alreadyHaveAccountLabel, loginButton])
        footerStack.axis = .horizontal
        footerStack.spacing = 4
        footerStack.alignment = .center
        footerStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(footerStack)
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            subheadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 16),
            subheadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            subheadingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            stackView.topAnchor.constraint(equalTo: subheadingLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            createAccountButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),
            
            footerStack.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 20),
            footerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func createAccountTapped() {
    }
    
    @objc private func loginTapped() {
        let loginScreen = LoginScreen()
        navigationController?.pushViewController(loginScreen, animated: true)
    }

    private func createTextField(placeholder: String, labelColor: UIColor, keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = labelColor
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 12
        textField.keyboardType = keyboardType
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func createSecureTextField(placeholder: String, labelColor: UIColor) -> UITextField {
        let textField = createTextField(placeholder: placeholder, labelColor: labelColor)
        textField.isSecureTextEntry = true
        return textField
    }
}
