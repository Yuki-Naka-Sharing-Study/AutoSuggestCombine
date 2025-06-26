//
//  ContentView.swift
//  AutoSuggestCombine
//
//  Created by 仲優樹 on 2025/06/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AutoCompleteViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("検索語を入力...", text: $viewModel.query)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            List {
                ForEach(viewModel.suggestions, id: \.self) { suggestion in
                    Button(action: {
                        viewModel.query = suggestion // ← ✅ タップされた候補を入力欄に反映
                    }) {
                        Text(suggestion)
                    }
                }
            }
        }
        .padding(.top)
    }
}

#Preview {
    ContentView()
}
