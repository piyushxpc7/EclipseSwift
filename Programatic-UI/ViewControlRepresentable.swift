
import SwiftUI
import UIKit
struct AuthorProfileViewControllerRepresentable: UIViewControllerRepresentable {
    let author: Author

    func makeUIViewController(context: Context) -> AuthorProfileViewController {
        let viewController = AuthorProfileViewController(author: author)
        return viewController
    }

    func updateUIViewController(_ viewController: AuthorProfileViewController, context: Context) {
        // No need to update, as the view controller is created and configured in makeUIViewController
    }
}
struct BookPageViewControllerRepresentable: UIViewControllerRepresentable {
    let book: Book

    func makeUIViewController(context: Context) -> BookPageViewController {
        BookPageViewController(book: book)
    }

    func updateUIViewController(_ viewController: BookPageViewController, context: Context) {
        // No need to update, as the view controller is created and configured in makeUIViewController
    }
}
struct FamousPersonProfileViewControllerRepresentable: UIViewControllerRepresentable {
    let famousPersonImage: String
    let description: String
    let name: String
    let title: String


    func makeUIViewController(context: Context) -> FamousPersonProfileViewController {
        let viewController = FamousPersonProfileViewController(
            famousPersonImage: famousPersonImage,
            description: description,
            name: name,
            title: title
        )
        return viewController
    }

    func updateUIViewController(_ viewController: FamousPersonProfileViewController, context: Context) {
        // No need to update, as the view controller is created and configured in makeUIViewController
    }
}
struct BookPageRepresentable: View {
    let book: Book
    @State private var isBookmarked = false
    @State private var showReviewSheet = false
    @State private var rating: Int = 0
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header Section
                headerSection
                
                // Book Details Section
                bookDetailsSection
                
                // Action Buttons
                actionButtonsSection
                
                // Description Section
                descriptionSection
                
                // Additional Information
                additionalInfoSection
                
                // Reviews Section
                reviewsSection
            }
            .padding(.bottom, 30)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    shareButton
                    bookmarkButton
                }
            }
        }
        .sheet(isPresented: $showReviewSheet) {
            WriteReviewSheet(book: book)
        }
    }
    
    // MARK: - View Components
    
    private var headerSection: some View {
        VStack(spacing: 15) {
            Image(book.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .cornerRadius(12)
                .shadow(radius: 8)
            
            Text(book.title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            authorInfoView
        }
        .padding(.top)
    }
    
    private var authorInfoView: some View {
        VStack(spacing: 5) {
            Text("By Author Name") // Replace with actual author data
                .font(.headline)
                .foregroundColor(.secondary)
            
            HStack {
                ForEach(0..<5) { index in
                    Image(systemName: index < 4 ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
            
            Text("4.2 · 2.3K ratings")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var bookDetailsSection: some View {
        HStack(spacing: 30) {
            VStack {
                Text("Pages")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("384")
                    .font(.headline)
            }
            
            VStack {
                Text("Language")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("English")
                    .font(.headline)
            }
            
            VStack {
                Text("Released")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("2023")
                    .font(.headline)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private var actionButtonsSection: some View {
        HStack(spacing: 20) {
            Button(action: { /* Add read now action */ }) {
                Text("Read Now")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("005C78"))
                    .cornerRadius(10)
            }
            
            Button(action: { /* Add sample action */ }) {
                Text("Sample")
                    .fontWeight(.bold)
                    .foregroundColor(Color("005C78"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("005C78"), lineWidth: 2)
                    )
            }
        }
        .padding(.horizontal)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About This Book")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(book.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(4)
        }
        .padding(.horizontal)
    }
    
    private var additionalInfoSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Additional Information")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 10) {
                infoRow(title: "Publisher", value: "Publishing House Name")
                infoRow(title: "Genre", value: "Fiction, Literature")
                infoRow(title: "ISBN", value: "978-3-16-148410-0")
                infoRow(title: "Format", value: "eBook, Hardcover, Paperback")
            }
        }
        .padding(.horizontal)
    }
    
    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Reviews")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: { showReviewSheet = true }) {
                    Text("Write a Review")
                        .font(.subheadline)
                        .foregroundColor(Color("005C78"))
                }
            }
            
            ForEach(0..<3) { _ in
                ReviewCard()
            }
        }
        .padding(.horizontal)
    }
    
    private var shareButton: some View {
        Button(action: { /* Add share action */ }) {
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(Color("005C78"))
        }
    }
    
    private var bookmarkButton: some View {
        Button(action: { isBookmarked.toggle() }) {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                .foregroundColor(Color("005C78"))
        }
    }
    
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            Text(value)
                .foregroundColor(.primary)
        }
    }
}
struct SwipeScreenWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SwipeScreen {
        let swipeScreen = SwipeScreen() // Initialize the SwipeScreen view controller
            swipeScreen.modalPresentationStyle = .fullScreen
        return swipeScreen // Make sure to configure SwipeScreen as needed
    }

    func updateUIViewController(_ uiViewController: SwipeScreen, context: Context) {
        // Update any properties if needed
    }
}
