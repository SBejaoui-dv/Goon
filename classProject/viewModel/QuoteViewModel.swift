import Foundation

@MainActor
class QuoteViewModel: ObservableObject {
    @Published var quoteText: String = "“Excessive screen time can quietly steal your day.”"
    @Published var quoteAuthor: String = "Unknown"
    @Published var isLoading: Bool = false
    
    func loadQuote() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let quote = try await QuoteService.shared.fetchRandomQuote()
            
            // Simple heuristic: if the quote mentions time / life / work / focus,
            // treat it as a consequence of phone use quote. Otherwise still show it.
            if quote.q.lowercased().contains("time")
                || quote.q.lowercased().contains("life")
                || quote.q.lowercased().contains("focus")
                || quote.q.lowercased().contains("productivity") {
                quoteText = "“\(quote.q)”"
            } else {
                // Wrap 
                quoteText = "“\(quote.q)”"
            }
            quoteAuthor = quote.a
        } catch {
            print("Failed to fetch quote:", error)
            // Keep fallback text
        }
    }
}

