import UIKit

class BookPageViewController: UIViewController {

    var book: Book?

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOffset = CGSize(width: 0, height: 4)
        iv.layer.shadowOpacity = 0.3
        iv.layer.shadowRadius = 5
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()

    private let ratingView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 4
        sv.alignment = .center
        return sv
    }()

    private let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buy for $19.99", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor(hex: "#005C78")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
//        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20) // Button title padding
           button.contentVerticalAlignment = .center  // Align title vertically
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true  // Set a constant width
           return button
    }()

    private let rentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Rent for $4.99", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(hex: "#005C78"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(hex: "#005C78").cgColor
        button.layer.cornerRadius = 12
        button.contentVerticalAlignment = .center
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true  // Set a constant width
        return button
    }()

    private let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 16 // Space between buttons
        sv.alignment = .center
        return sv
    }()

    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }

    func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [bookImageView, titleLabel, ratingView, descriptionLabel, buttonStackView].forEach { contentView.addSubview($0) }
        buttonStackView.addArrangedSubview(buyButton)
        buttonStackView.addArrangedSubview(rentButton)

        // Setup rating stars
        for _ in 0..<5 {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.tintColor = .systemYellow
            ratingView.addArrangedSubview(starImageView)
        }

        let ratingLabel = UILabel()
        ratingLabel.text = "4.5 (2.3k reviews)"
        ratingLabel.font = .systemFont(ofSize: 14)
        ratingLabel.textColor = .darkGray
        ratingView.addArrangedSubview(ratingLabel)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            bookImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookImageView.widthAnchor.constraint(equalToConstant: 200),
            bookImageView.heightAnchor.constraint(equalToConstant: 300),

            titleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            ratingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            buttonStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            buttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        rentButton.addTarget(self, action: #selector(rentButtonTapped), for: .touchUpInside)
    }

    func configureUI() {
        if let book = book {
            bookImageView.image = UIImage(named: book.imageName)
            titleLabel.text = book.title
            descriptionLabel.text = book.description
        } else {
            print("Error: Book data is nil")
        }
    }

    @objc private func buyButtonTapped() {
        // Handle buy action here.
        print("Buy button tapped")
    }

    @objc private func rentButtonTapped() {
        // Handle rent action here.
        print("Rent button tapped")
    }
}
