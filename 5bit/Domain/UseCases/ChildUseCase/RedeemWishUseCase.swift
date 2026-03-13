//
//  RedeemWishUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol RedeemWishUseCase {
    func execute(wishId: Int, childId: Int) async throws
}

struct DefaultRedeemWishUseCase: RedeemWishUseCase {
    private let kidRepository: KidRepositoryProtocol
    init(kidRepository: KidRepositoryProtocol) { self.kidRepository = kidRepository }
    func execute(wishId: Int, childId: Int) async throws {
        _ = try await kidRepository.redeemWish(wishId: wishId, childId: childId)
    }
}
