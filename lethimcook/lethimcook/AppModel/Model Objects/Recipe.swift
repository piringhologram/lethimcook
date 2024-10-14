//
//  Recipe.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//
import Foundation
import SwiftUI

public struct ImageResponse: Codable {
    let results: [ImageResult]
}

public struct ImageResult: Codable {
    let title: String
    let image: String
}

// Identifiable : Used so that object can be identifiable and retrivied by specific ID
// Hashable : Used because navigationLink needs their components to be Hashable
public struct Recipe: Identifiable, Hashable, Codable {
    public var id: UUID?
    public var title: String
    public var ingredients: String
    public var instructions: String
    public var isFavorite: Bool
    public var timeAndDate: Date
    public var image: String?
    public var imageURL: URL?
    public var customImageData: Data?
    
    public var customImage: UIImage? {
        get {
            if let data = customImageData {
                return UIImage(data: data)
            }
            return nil
        }
        set {
            customImageData = newValue?.jpegData(compressionQuality: 1)
        }
    }
    
    public init(id: UUID? = nil,
                title: String,
                ingredients: String,
                instructons: String,
                image: String? = nil,
                imageURL: URL? = nil,
                customImageData: Data? = nil) {
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructons
        self.isFavorite = false
        self.timeAndDate = Date()
        self.image = image
        self.imageURL = imageURL
        self.customImageData = customImageData
    }
}

extension Recipe: Comparable {
    public static func < ( a: Recipe, b: Recipe ) -> Bool {
        a.timeAndDate < b.timeAndDate
    }
}
