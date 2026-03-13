//
//  SetWishPriceUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol SetWishPriceUseCase {
    func execute(wishId: Int, coinPrice: Int, parentId: Int) async throws
}

struct DefaultSetWishPriceUseCase: SetWishPriceUseCase {
    private let taskRepository: TaskRepositoryProtocol
    init(taskRepository: TaskRepositoryProtocol) { self.taskRepository = taskRepository }
    func execute(wishId: Int, coinPrice: Int, parentId: Int) async throws {
        _ = try await taskRepository.setWishPrice(wishId: wishId, coinPrice: coinPrice, parentId: parentId)
    }
}
