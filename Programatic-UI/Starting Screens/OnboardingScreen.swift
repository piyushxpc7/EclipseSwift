
import UIKit

class SecondScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let cardStack = UIStackView(arrangedSubviews: [
            CardView(imageName: "books.vertical", title: "Personalized Recommendations", description: "Enjoy swiping on all the books you like and add them to your reading list to rent them all out!", isSystemImage: true),
            CardView(imageName: "cart", title: "Rent From Those Near You", description: "You can now rent all your favorite books from those who live less than 5km away from you!", isSystemImage: true)
        ])
        
        cardStack.axis = .vertical
        cardStack.spacing = 30
        cardStack.layoutMargins = UIEdgeInsets(top: 50, left: 16, bottom: 0, right: 16)
        cardStack.isLayoutMarginsRelativeArrangement = true
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardStack)
        
        let continueButton = UIButton(type: .system)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(hex: "#005C78")
        continueButton.layer.cornerRadius = 10
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.addTarget(self, action: #selector(navigateToThirdPage), for: .touchUpInside)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            cardStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            cardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func navigateToThirdPage() {
        let thirdViewController = ThirdScreen()
        navigationController?.pushViewController(thirdViewController, animated: true)
    }
}

class CardView: UIView {
    
    init(imageName: String, title: String, description: String, isSystemImage: Bool) {
        super.init(frame: .zero)
        setupView(imageName: imageName, title: title, description: description, isSystemImage: isSystemImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(imageName: String, title: String, description: String, isSystemImage: Bool) {
        backgroundColor = UIColor(hex: "#F2F2F2")
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        
        let imageView: UIImageView
        if isSystemImage {
            imageView = UIImageView(image: UIImage(systemName: imageName))
        } else {
            imageView = UIImageView(image: UIImage(named: imageName))
        }
        imageView.tintColor = UIColor(hex: "#005C78")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor(hex: "#005C78")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        textStack.axis = .vertical
        textStack.spacing = 8
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [imageView, textStack])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
