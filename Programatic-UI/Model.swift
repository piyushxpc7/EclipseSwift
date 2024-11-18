//
//  Model.swift
//  Programatic-UI
//
//  Created by Piyush on 10/11/24.
//

import Foundation
struct Author: Identifiable {
    var id = UUID()
    var name: String
    var bio: String
    var image: String // The name of the image file in your assets
}
// Book Model
struct Book: Identifiable {
    var id = UUID()
    var title: String
    var imageName: String
    var description: String
    let amazonRating: String // Add Amazon rating
    let goodreadsRating: String
}

struct FamousPerson {
    let famousPersonImage: String
    let description: String
    let name: String
    let title: String
}

// Book model for demonstration
class BookItem {
    var title: String
    var type: String
    var plot: String
    
    init(title: String, type: String, plot: String) {
        self.title = title
        self.type = type
        self.plot = plot
    }
}
