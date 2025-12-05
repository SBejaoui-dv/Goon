//
//  QuoteData.swift
//  classProject
//

import Foundation

// Model for ZenQuotes: https://zenquotes.io/
struct Quote: Decodable, Identifiable {
    let id = UUID()
    let q: String   // quote text
    let a: String   // author
    
    enum CodingKeys: String, CodingKey {
        case q, a
    }
}
