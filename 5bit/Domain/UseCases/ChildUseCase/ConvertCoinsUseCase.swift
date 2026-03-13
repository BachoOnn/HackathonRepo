//
//  ConvertCoinsUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol ConvertCoinsUseCase {
    func execute(childId: Int, amount: Int) async throws -> KidBalance
}

struct DefaultConvertCoinsUseCase: ConvertCoinsUseCase {
    private let kidRepository: KidRepositoryProtocol

    init(kidRepository: KidRepositoryProtocol) {
        self.kidRepository = kidRepository
    }

    func execute(childId: Int, amount: Int) async throws -> KidBalance {
        try await kidRepository.convertCoins(childId: childId, amount: amount)
    }
}
