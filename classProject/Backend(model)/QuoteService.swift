
import Foundation


class QuoteService {
    static let shared = QuoteService()
    private init() {}
    
    // Simple async fetch: gets one random quote
    func fetchRandomQuote() async throws -> Quote {
        let url = URL(string: "https://zenquotes.io/api/random")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode([Quote].self, from: data)
        
        // API returns an array with one element
        guard let quote = decoded.first else {
            throw URLError(.badServerResponse)
        }
        return quote
    }
}
