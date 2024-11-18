import UIKit

class LoginScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Welcome back!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let emailTextField = createTextField(placeholder: "Email", labelColor: UIColor(hex: "#005C78"), keyboardType: .emailAddress)
        let passwordTextField = createSecureTextField(placeholder: "Password", labelColor: UIColor(hex: "#005C78"))
        
        [emailTextField, passwordTextField].forEach {
            stackView.addArrangedSubview($0)
        }
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(hex: "#005C78")
        loginButton.layer.cornerRadius = 12
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.addSubview(loginButton)

        let alreadyHaveAccountLabel = UILabel()
        alreadyHaveAccountLabel.text = "Don't have an account?"
        alreadyHaveAccountLabel.font = UIFont.systemFont(ofSize: 14)
        alreadyHaveAccountLabel.textColor = .gray
        alreadyHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alreadyHaveAccountLabel)
        
        let createAccountButton = UIButton(type: .system)
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(UIColor(hex: "#005C78"), for: .normal)
        createAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        view.addSubview(createAccountButton)
        
        

        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            alreadyHaveAccountLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            alreadyHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            createAccountButton.topAnchor.constraint(equalTo: alreadyHaveAccountLabel.bottomAnchor, constant: 4),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            
        ])
    }

 
    
    @objc private func loginTapped() {
        let fourthScreen = Pref()
        navigationController?.pushViewController(fourthScreen, animated: true)
    }
    
    @objc private func createAccountTapped() {
        let createAccountScreen = ThirdScreen()
        navigationController?.pushViewController(createAccountScreen, animated: true)
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
