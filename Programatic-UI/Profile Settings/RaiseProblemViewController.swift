import UIKit

class RaiseProblemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var image: UIImage?
    private var openCases: [[String: String]] = [
        ["title": "Harry Potter", "image": "harry_potter"],
        ["title": "Mockingbird", "image": "mockingbird"]
    ]
    
    private let bookTitleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let borrowerNameTextField = UITextField()
    private let uploadImageButton = UIButton(type: .system)
    private let submitButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        let titleLabel = UILabel()
        titleLabel.text = "Report a Problem"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let formCardView = UIView()
        formCardView.backgroundColor = .white
        formCardView.layer.cornerRadius = 15
        formCardView.layer.shadowColor = UIColor.black.cgColor
        formCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        formCardView.layer.shadowOpacity = 0.1
        formCardView.layer.shadowRadius = 10
        formCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formCardView)
        
        bookTitleTextField.placeholder = "Book Title"
        bookTitleTextField.borderStyle = .roundedRect
        bookTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        formCardView.addSubview(bookTitleTextField)
        
        descriptionTextField.placeholder = "Description"
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        formCardView.addSubview(descriptionTextField)
        
        borrowerNameTextField.placeholder = "Borrower's Name"
        borrowerNameTextField.borderStyle = .roundedRect
        borrowerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        formCardView.addSubview(borrowerNameTextField)
        
        uploadImageButton.setTitle("Upload Image", for: .normal)
        uploadImageButton.setTitleColor(.white, for: .normal)
        uploadImageButton.backgroundColor = UIColor(hex: "#005C78")
        uploadImageButton.layer.cornerRadius = 10
        uploadImageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        uploadImageButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        uploadImageButton.translatesAutoresizingMaskIntoConstraints = false
        formCardView.addSubview(uploadImageButton)
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor(hex: "#005C78")
        submitButton.layer.cornerRadius = 10
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            formCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            formCardView.heightAnchor.constraint(equalToConstant: 350),
            bookTitleTextField.topAnchor.constraint(equalTo: formCardView.topAnchor, constant: 20),
            bookTitleTextField.leadingAnchor.constraint(equalTo: formCardView.leadingAnchor, constant: 16),
            bookTitleTextField.trailingAnchor.constraint(equalTo: formCardView.trailingAnchor, constant: -16),
            bookTitleTextField.heightAnchor.constraint(equalToConstant: 40),
            descriptionTextField.topAnchor.constraint(equalTo: bookTitleTextField.bottomAnchor, constant: 16),
            descriptionTextField.leadingAnchor.constraint(equalTo: formCardView.leadingAnchor, constant: 16),
            descriptionTextField.trailingAnchor.constraint(equalTo: formCardView.trailingAnchor, constant: -16),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 40),
            borrowerNameTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 16),
            borrowerNameTextField.leadingAnchor.constraint(equalTo: formCardView.leadingAnchor, constant: 16),
            borrowerNameTextField.trailingAnchor.constraint(equalTo: formCardView.trailingAnchor, constant: -16),
            borrowerNameTextField.heightAnchor.constraint(equalToConstant: 40),
            uploadImageButton.topAnchor.constraint(equalTo: borrowerNameTextField.bottomAnchor, constant: 20),
            uploadImageButton.centerXAnchor.constraint(equalTo: formCardView.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: formCardView.bottomAnchor, constant: 20),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func uploadImageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func submitTapped() {
        guard let bookTitle = bookTitleTextField.text, !bookTitle.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty,
              let borrowerName = borrowerNameTextField.text, !borrowerName.isEmpty else {
            print("All fields are required")
            return
        }
        
        let imageName = "\(bookTitle.lowercased().replacingOccurrences(of: " ", with: "_"))_image"
        
        let newIssue = ["title": bookTitle, "description": description, "borrower": borrowerName, "image": imageName]
        openCases.append(newIssue)
        
        print("New issue added: \(newIssue)")
        
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
