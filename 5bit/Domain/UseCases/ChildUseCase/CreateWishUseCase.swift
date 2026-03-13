//
//  CreateWishUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


protocol CreateWishUseCase {
    func execute(childId: Int, title: String, description: String?) async throws
}

struct DefaultCreateWishUseCase: CreateWishUseCase {
    private let kidRepository: KidRepositoryProtocol

    init(kidRepository: KidRepositoryProtocol) {
        self.kidRepository = kidRepository
    }

    func execute(childId: Int, title: String, description: String?) async throws {
        _ = try await kidRepository.createWish(childId: childId, title: title, description: description)
    }
}