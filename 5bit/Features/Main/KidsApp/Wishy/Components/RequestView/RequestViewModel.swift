//
//  RequestViewModel.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Combine
import Foundation

final class RequestViewModel: ObservableObject {
    @Published var selectedType: RequestType = .task
    @Published var selectedCategory: RequestCategory? = nil
    @Published var description: String = "" {
        didSet {
            if description.count > 100 {
                description = String(description.prefix(100))
            }
        }
    }

    var categories: [RequestCategory] {
        switch selectedType {
        case .task: return RequestCategory.taskCategories
        case .wish: return RequestCategory.wishCategories
        }
    }

    var isValid: Bool {
        selectedCategory != nil && !description.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func send() {
        print("Type: \(selectedType) | Category: \(selectedCategory?.label ?? "") | Desc: \(description)")
    }
}
