//
//  Reading.swift
//  Programatic-UI
//
//  Created by Piyush on 13/11/24.
//

import Foundation
import UIKit
import SwiftUI
struct ReadingChallengeView: View {
    @State private var booksRead: Int = 26
    @State private var targetBooks: Int = 40
    @State private var showingEditScreen: Bool = false
    
    // Computed property for dynamic progress
    private var progress: CGFloat {
        guard targetBooks > 0 else { return 0 }
        return CGFloat(booksRead) / CGFloat(targetBooks)
    }
    
    // Computed property for encouraging messages
    private var encouragementMessage: String {
        let remaining = targetBooks - booksRead
        if remaining <= 0 {
            return "Congratulations! You've reached your goal! 🎉"
        } else if remaining == 1 {
            return "Almost there! Just 1 book to go!"
        } else {
            return "Keep going! Only \(remaining) books to reach your goal!"
        }
    }
    
    // Computed property for achievement badges
    private var badges: [(String, Bool)] {
        [
            ("📚", progress >= 0.25),  // 25% milestone
            ("🌟", progress >= 0.5),   // 50% milestone
            ("🎯", progress >= 1.0)    // 100% milestone
        ]
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                showingEditScreen = true
            }) {
                HStack(spacing: 25) {
                    // Circular progress indicator
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                            .frame(width: 120, height: 120)
                        
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .frame(width: 120, height: 120)
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut, value: progress)
                        
                        VStack {
                            Text("\(booksRead)")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("of \(targetBooks)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // Achievement badges
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            ForEach(badges, id: \.0) { badge, isAchieved in
                                Circle()
                                    .fill(isAchieved ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Text(badge)
                                            .opacity(isAchieved ? 1 : 0.5)
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(isAchieved ? Color.blue : Color.clear, lineWidth: 2)
                                    )
                                    .animation(.easeInOut, value: isAchieved)
                            }
                        }
                        
                        Text(encouragementMessage)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .animation(.easeInOut, value: encouragementMessage)
                    }
                }
            }
            
            // Monthly progress
            HStack(spacing: 4) {
                ForEach(0..<12) { month in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(month < Int(progress * 12) ? Color.blue : Color.gray.opacity(0.2))
                        .frame(height: 30)
                }
            }
            .padding(.horizontal)
            .animation(.easeInOut, value: progress)
        }
        .padding()
        .fullScreenCover(isPresented: $showingEditScreen) {
            EditChallengeRepresentable(booksRead: $booksRead,
                                     targetBooks: $targetBooks,
                                     progress: .constant(progress), // We don't need this binding anymore
                                     isPresented: $showingEditScreen)
        }
    }
}
struct EditChallengeRepresentable: UIViewControllerRepresentable {
    @Binding var booksRead: Int
    @Binding var targetBooks: Int
    @Binding var progress: CGFloat
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> EditChallengeViewController {
        let controller = EditChallengeViewController()
        controller.delegate = context.coordinator
        controller.booksRead = booksRead
        controller.targetBooks = targetBooks
        return controller
    }
    
    func updateUIViewController(_ uiViewController: EditChallengeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, EditChallengeDelegate {
        var parent: EditChallengeRepresentable
        
        init(_ parent: EditChallengeRepresentable) {
            self.parent = parent
        }
        
        func didUpdateChallenge(booksRead: Int, targetBooks: Int) {
            parent.booksRead = booksRead
            parent.targetBooks = targetBooks
            parent.progress = CGFloat(booksRead) / CGFloat(targetBooks)
            parent.isPresented = false
        }
        
        func didCancel() {
            parent.isPresented = false
        }
    }
}

// MARK: - UIKit Edit Screen
protocol EditChallengeDelegate: AnyObject {
    func didUpdateChallenge(booksRead: Int, targetBooks: Int)
    func didCancel()
}

class EditChallengeViewController: UIViewController {
    weak var delegate: EditChallengeDelegate?
    var booksRead: Int = 0
    var targetBooks: Int = 0
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "books.vertical.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let booksReadTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.textAlignment = .center
        field.font = .systemFont(ofSize: 24, weight: .bold)
        field.keyboardType = .numberPad
        return field
    }()
    
    private let targetBooksTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.textAlignment = .center
        field.font = .systemFont(ofSize: 24, weight: .bold)
        field.keyboardType = .numberPad
        return field
    }()
    
    private let booksReadSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = .systemBlue
        return slider
    }()
    
    private let targetBooksSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 200
        slider.tintColor = .systemPurple
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSliders()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        
        // Setup Navigation Bar
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 44))
        let navItem = UINavigationItem(title: "📚 Reading Goals")
        
        let cancelButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle.fill"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(cancelTapped))
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"),
                                       style: .done,
                                       target: self,
                                       action: #selector(saveTapped))
        
        cancelButton.tintColor = .systemGray
        saveButton.tintColor = .systemGreen
        
        navItem.leftBarButtonItem = cancelButton
        navItem.rightBarButtonItem = saveButton
        navbar.items = [navItem]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        
        view.addSubview(navbar)
        view.addSubview(containerView)
        
        // Main Content Stack View
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 30
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Books Read Section
        let booksReadCard = createCard(title: "Books Read",
                                     textField: booksReadTextField,
                                     slider: booksReadSlider,
                                     icon: "book.fill",
                                     iconColor: .systemBlue)
        
        // Target Books Section
        let targetBooksCard = createCard(title: "Reading Target",
                                       textField: targetBooksTextField,
                                       slider: targetBooksSlider,
                                       icon: "star.fill",
                                       iconColor: .systemPurple)
        
        mainStack.addArrangedSubview(booksReadCard)
        mainStack.addArrangedSubview(targetBooksCard)
        
        containerView.addSubview(mainStack)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: navbar.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            
            mainStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    private func createCard(title: String, textField: UITextField, slider: UISlider, icon: String, iconColor: UIColor) -> UIView {
        let card = UIView()
        card.backgroundColor = .secondarySystemGroupedBackground
        card.layer.cornerRadius = 16
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 6
        card.layer.shadowOpacity = 0.1
        
        let iconImage = UIImageView(image: UIImage(systemName: icon))
        iconImage.tintColor = iconColor
        iconImage.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .secondaryLabel
        
        let stack = UIStackView(arrangedSubviews: [
            iconImage,
            titleLabel,
            textField,
            slider
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(stack)
        
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalToConstant: 160),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            slider.widthAnchor.constraint(equalTo: stack.widthAnchor),
        ])
        
        return card
    }
    
    private func setupSliders() {
        // Initial values
        booksReadSlider.value = Float(booksRead)
        targetBooksSlider.value = Float(targetBooks)
        booksReadTextField.text = "\(booksRead)"
        targetBooksTextField.text = "\(targetBooks)"
        
        // Add targets for slider value changes
        booksReadSlider.addTarget(self, action: #selector(booksReadSliderChanged), for: .valueChanged)
        targetBooksSlider.addTarget(self, action: #selector(targetBooksSliderChanged), for: .valueChanged)
    }
    
    @objc private func booksReadSliderChanged() {
        let value = Int(booksReadSlider.value)
        booksReadTextField.text = "\(value)"
        
        // Add haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    @objc private func targetBooksSliderChanged() {
        let value = Int(targetBooksSlider.value)
        targetBooksTextField.text = "\(value)"
        
        // Add haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    @objc private func cancelTapped() {
        // Add animation
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 0
        } completion: { _ in
            self.delegate?.didCancel()
        }
    }
    
    @objc private func saveTapped() {
        guard let booksReadText = booksReadTextField.text,
              let targetBooksText = targetBooksTextField.text,
              let booksRead = Int(booksReadText),
              let targetBooks = Int(targetBooksText) else {
            showError()
            return
        }
        
        // Add success animation
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 0
        } completion: { _ in
            self.delegate?.didUpdateChallenge(booksRead: booksRead, targetBooks: targetBooks)
        }
    }
    
    private func showError() {
        let alert = UIAlertController(title: "Oops! 📚",
                                    message: "Please enter valid numbers for your reading challenge",
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it!", style: .default))
        present(alert, animated: true)
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
