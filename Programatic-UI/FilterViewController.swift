import UIKit

class FilterViewController: UIViewController {
    
    var books: [BookItem] = [] // List of books to be filtered
    var selectedType: String?
    var selectedPlot: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Example data
        books = [
            BookItem(title: "Book 1", type: "Fiction", plot: "Romance"),
            BookItem(title: "Book 2", type: "Non-Fiction", plot: "Mystery"),
            BookItem(title: "Book 3", type: "Fiction", plot: "Fantasy"),
            // Add more books as needed
        ]
        
        // Add the filter button
        let filterButton = createIconButton(named: "slider.horizontal.3")
        filterButton.addTarget(self, action: #selector(showFilterOptions), for: .touchUpInside)
        self.view.addSubview(filterButton)
        
        // Layout for the filter button
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            filterButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
    }

    private func createIconButton(named iconName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: iconName), for: .normal)
        button.tintColor = .gray // Default color for the icons
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }
    
    @objc func showFilterOptions() {
        let alert = UIAlertController(title: "Filter Options", message: "Select filters", preferredStyle: .actionSheet)
        
        // Type filter options
        let types = ["Fiction", "Non-Fiction", "Science", "Fantasy"]
        for type in types {
            alert.addAction(UIAlertAction(title: type, style: .default, handler: { [weak self] _ in
                self?.selectedType = type
                self?.applyFilters()
            }))
        }
        
        // Plot filter options
        let plots = ["Romance", "Mystery", "Adventure", "Horror"]
        for plot in plots {
            alert.addAction(UIAlertAction(title: plot, style: .default, handler: { [weak self] _ in
                self?.selectedPlot = plot
                self?.applyFilters()
            }))
        }
        
        // Cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // Present the filter options
        present(alert, animated: true)
    }
    
    func applyFilters() {
        var filteredBooks = books
        
        if let selectedType = selectedType {
            filteredBooks = filteredBooks.filter { $0.type == selectedType }
        }
        
        if let selectedPlot = selectedPlot {
            filteredBooks = filteredBooks.filter { $0.plot == selectedPlot }
        }
        
        // Update the UI with the filtered results (you can reload a table view or update a collection view)
        print(filteredBooks.map { $0.title })
    }
}

