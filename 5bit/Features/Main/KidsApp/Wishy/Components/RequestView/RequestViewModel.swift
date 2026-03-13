//
//  RequestViewModel.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Combine
import Foundation

@MainActor
final class RequestViewModel: ObservableObject {
    
    @Published var selectedType: RequestType = .wish
    @Published var selectedCategory: RequestCategory? = nil
    @Published var description: String = "" {
        didSet { if description.count > 100 { description = String(description.prefix(100)) } }
    }
    @Published var isLoading: Bool = false
    @Published var didSendSuccessfully: Bool = false
    @Published var errorMessage: String? = nil
    
    var categories: [RequestCategory] {
        switch selectedType {
        case .task: return RequestCategory.taskCategories
        case .wish: return RequestCategory.wishCategories
        }
    }
    
    var isValid: Bool {
        selectedCategory != nil && !description.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private let childId: Int
    private let createWishUseCase: CreateWishUseCase
    
    init(childId: Int, createWishUseCase: CreateWishUseCase) {
        self.childId = childId
        self.createWishUseCase = createWishUseCase
    }
    
    func send() {
        Task { await performSend() }
    }
}

fileprivate extension RequestViewModel {
    
    func performSend() async {
        guard let category = selectedCategory else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            // Both wish and task request go to /wishes — parent sets coin price
            let title = "\(category.emoji) \(category.label)"
            try await createWishUseCase.execute(
                childId: childId,
                title: title,
                description: description.isEmpty ? nil : description
            )
            didSendSuccessfully = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
