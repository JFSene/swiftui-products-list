import Foundation
import SwiftData

struct ProductsResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

@Model
class Product: Identifiable, Codable {
    @Attribute(.unique) var id: Int
    var title: String
    var productDescription: String
    var category: String
    var price: Double
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var thumbnail: String?
    var images: [String]?

    enum CodingKeys: String, CodingKey {
        case id, title, productDescription = "description", category, price, discountPercentage, rating, stock, thumbnail, images
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        productDescription = try container.decode(String.self, forKey: .productDescription)
        category = try container.decode(String.self, forKey: .category)
        price = try container.decode(Double.self, forKey: .price)
        discountPercentage = try container.decode(Double.self, forKey: .discountPercentage)
        rating = try container.decode(Double.self, forKey: .rating)
        stock = try container.decode(Int.self, forKey: .stock)
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        images = try container.decodeIfPresent([String].self, forKey: .images)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(productDescription, forKey: .productDescription)
        try container.encode(category, forKey: .category)
        try container.encode(price, forKey: .price)
        try container.encode(discountPercentage, forKey: .discountPercentage)
        try container.encode(rating, forKey: .rating)
        try container.encode(stock, forKey: .stock)
        try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
        try container.encodeIfPresent(images, forKey: .images)
    }
}

@Model
class Dimensions: Codable {
    var width: Double
    var height: Double
    var depth: Double
    
    enum CodingKeys: String, CodingKey {
        case width, height, depth
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        width = try container.decode(Double.self, forKey: .width)
        height = try container.decode(Double.self, forKey: .height)
        depth = try container.decode(Double.self, forKey: .depth)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
        try container.encode(depth, forKey: .depth)
    }
}

@Model
class Review: Codable {
    var rating: Int
    var comment: String
    var date: String
    var reviewerName: String
    var reviewerEmail: String
    
    enum CodingKeys: String, CodingKey {
        case rating, comment, date, reviewerName, reviewerEmail
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rating = try container.decode(Int.self, forKey: .rating)
        comment = try container.decode(String.self, forKey: .comment)
        date = try container.decode(String.self, forKey: .date)
        reviewerName = try container.decode(String.self, forKey: .reviewerName)
        reviewerEmail = try container.decode(String.self, forKey: .reviewerEmail)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rating, forKey: .rating)
        try container.encode(comment, forKey: .comment)
        try container.encode(date, forKey: .date)
        try container.encode(reviewerName, forKey: .reviewerName)
        try container.encode(reviewerEmail, forKey: .reviewerEmail)
    }
}

@Model
class Meta: Codable {
    var createdAt: String
    var updatedAt: String
    var barcode: String
    var qrCode: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, barcode, qrCode
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        barcode = try container.decode(String.self, forKey: .barcode)
        qrCode = try container.decode(String.self, forKey: .qrCode)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(barcode, forKey: .barcode)
        try container.encode(qrCode, forKey: .qrCode)
    }
}
