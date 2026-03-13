//
//  GetKidWishesUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol GetKidWishesUseCase {
    func execute(childId: Int) async throws -> [Wish]
}

struct DefaultGetKidWishesUseCase: GetKidWishesUseCase {
    private let kidRepository: KidRepositoryProtocol
    init(kidRepository: KidRepositoryProtocol) { self.kidRepository = kidRepository }
    func execute(childId: Int) async throws -> [Wish] {
        try await kidRepository.getWishes(childId: childId)
    }
}
