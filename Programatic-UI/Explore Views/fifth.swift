import UIKit
import SwiftUI

class fifth: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the SwiftUI view
        let exploreView = ExploreView()
        
        // Embed the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: exploreView)
        
        // Add the hosting controller as a child view controller
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // Set up constraints
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Notify the hosting controller
        hostingController.didMove(toParent: self)
        
        // Optional: Set the navigation title
        self.title = "Explore"
    }
}
