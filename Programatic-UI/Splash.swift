import UIKit



class FirstScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToSecondPage))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#005C78")
        
        let eclipseLabel = UILabel()
        eclipseLabel.text = "Eclipse"
        eclipseLabel.font = UIFont.boldSystemFont(ofSize: 65)
        eclipseLabel.textColor = .white
        eclipseLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eclipseLabel)
        
        NSLayoutConstraint.activate([
            eclipseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eclipseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func navigateToSecondPage() {
        let secondViewController = SecondScreen()
        
        
        // Ensure this class exists
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
