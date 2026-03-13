//
//  KidRepository.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation
import MyNetworkManager

final class KidRepository: KidRepositoryProtocol {
    private let network: NetworkManager
    private let baseURL: String

    init(network: NetworkManager = NetworkManager()) {
        self.network = network
        self.baseURL = Bundle.main.API_BASE_URL
    }

    func getAssignments(childId: Int) async throws -> [Assignment] {
        let dtos: [AssignmentResponseDTO] = try await network.get(
            urlString: baseURL + "/tasks/child/\(childId)"
        )
        return dtos.map { $0.toDomain() }
    }

    func acceptTask(assignmentId: Int, childId: Int) async throws -> Assignment {
        struct AcceptRequest: Codable { let assignmentId: Int; let childId: Int }
        let dto: AssignmentResponseDTO = try await network.post(
            urlString: baseURL + "/tasks/accept",
            body: AcceptRequest(assignmentId: assignmentId, childId: childId)
        )
        return dto.toDomain()
    }

    func completeTask(assignmentId: Int, childId: Int) async throws -> Assignment {
        struct CompleteRequest: Codable { let assignmentId: Int; let childId: Int }
        let dto: AssignmentResponseDTO = try await network.post(
            urlString: baseURL + "/tasks/complete",
            body: CompleteRequest(assignmentId: assignmentId, childId: childId)
        )
        return dto.toDomain()
    }

    func getBalance(childId: Int) async throws -> KidBalance {
        let dto: BalanceResponseDTO = try await network.get(
            urlString: baseURL + "/coins/balance/\(childId)"
        )
        return KidBalance(coins: dto.coinBalance, money: dto.moneyBalance)
    }

    func getTransactionHistory(childId: Int) async throws -> [Transaction] {
        let dtos: [TransactionResponseDTO] = try await network.get(
            urlString: baseURL + "/coins/history/\(childId)"
        )
        let formatter = ISO8601DateFormatter()
        return dtos.map {
            Transaction(
                id: $0.id,
                amount: $0.amount,
                type: $0.transactionType ?? "",
                reason: $0.reason ?? "",
                createdAt: formatter.date(from: $0.createdAt) ?? Date()
            )
        }
    }

    func createWish(childId: Int, title: String, description: String?) async throws -> Wish {
        struct CreateWishRequest: Codable {
            let childId: Int
            let title: String
            let description: String?
        }
        let dto: WishResponseDTO = try await network.post(
            urlString: baseURL + "/wishes",
            body: CreateWishRequest(childId: childId, title: title, description: description)
        )
        return dto.toDomain()
    }

    func getWishes(childId: Int) async throws -> [Wish] {
        let dtos: [WishResponseDTO] = try await network.get(
            urlString: baseURL + "/wishes/child/\(childId)"
        )
        return dtos.map { $0.toDomain() }
    }
}

extension WishResponseDTO {
    func toDomain() -> Wish {
        Wish(
            id: id,
            title: title ?? "Wish",
            description: description,
            coinPrice: coinPrice,
            status: WishStatus(raw: status)
        )
    }
}
