//
//  AutoCompleteViewModel.swift
//  AutoSuggestCombine
//
//  Created by 仲優樹 on 2025/06/26.
//

import Foundation
import Combine

class AutoCompleteViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var suggestions: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $query
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // タイピングのたびに待機
            .removeDuplicates()
            .flatMap { query in
                Self.fetchSuggestions(for: query)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.suggestions, on: self)
            .store(in: &cancellables)
    }
    
    // ダミーの補完候補API
    private static func fetchSuggestions(for query: String) -> AnyPublisher<[String], Never> {
        let allWords = ["apple", "banana", "grape", "orange", "peach", "pineapple", "pear", "plum", "melon", "mango"]
        
        let filtered = allWords.filter { $0.hasPrefix(query.lowercased()) && !query.isEmpty }
        
        return Just(filtered)
            .delay(for: .milliseconds(200), scheduler: RunLoop.main) // API風遅延
            .eraseToAnyPublisher()
    }
}
