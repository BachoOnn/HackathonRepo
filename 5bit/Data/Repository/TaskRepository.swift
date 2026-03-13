//
//  TaskRepository.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation
import MyNetworkManager

final class TaskRepository: TaskRepositoryProtocol {
    private let network: NetworkManager
    private let baseURL: String

    init(network: NetworkManager = NetworkManager()) {
        self.network = network
        self.baseURL = Bundle.main.API_BASE_URL
    }

    func getParentAssignments(parentId: Int) async throws -> [Assignment] {
        var all: [Assignment] = []
        for childId in [2, 3, 4] {
            let dtos: [AssignmentResponseDTO] = (try? await network.get(
                urlString: baseURL + "/tasks/child/\(childId)"
            )) ?? []
            all += dtos.map { $0.toDomain() }
        }
        return all
    }

    func getPendingAssignments(parentId: Int) async throws -> [Assignment] {
        let dtos: [AssignmentResponseDTO] = try await network.get(
            urlString: baseURL + "/tasks/pending/\(parentId)"
        )
        return dtos.map { $0.toDomain() }
    }
    
    func getChildBalance(childId: Int) async throws -> Int {
        struct BalanceResponse: Codable { let coinBalance: Int; let moneyBalance: Double }
        let dto: BalanceResponse = try await network.get(
            urlString: baseURL + "/coins/balance/\(childId)"
        )
        return dto.coinBalance
    }
    
    func getChildrenForParent() async throws -> [(id: Int, name: String)] {
        let childIds = [2, 3, 4]
        var result: [(Int, String)] = []
        for childId in childIds {
            let dtos: [AssignmentResponseDTO] = (try? await network.get(
                urlString: baseURL + "/tasks/child/\(childId)"
            )) ?? []
            let name = dtos.first?.childName ?? fallbackName(for: childId)
            result.append((childId, name))
        }
        return result
    }
    
    private func fallbackName(for id: Int) -> String {
        switch id { case 2: return "Alice"; case 3: return "Bob"; case 4: return "Charlie"; default: return "Kid" }
    }
    
    func createTask(parentId: Int, title: String, description: String?, type: String?, coinReward: Int) async throws -> Int {
        struct CreateTaskRequest: Codable {
            let parentId: Int
            let title: String
            let description: String?
            let type: String?
            let coinReward: Int
        }
        let dto: TaskResponseDTO = try await network.post(
            urlString: baseURL + "/tasks",
            body: CreateTaskRequest(parentId: parentId, title: title, description: description, type: type, coinReward: coinReward)
        )
        return dto.id
    }
    
    func assignTask(taskId: Int, childId: Int) async throws {
        struct AssignRequest: Codable { let taskId: Int; let childId: Int }
        let _: AssignmentResponseDTO = try await network.post(
            urlString: baseURL + "/tasks/assign",
            body: AssignRequest(taskId: taskId, childId: childId)
        )
    }
    func getChildWishes(childId: Int) async throws -> [Assignment] {
        struct WishResponse: Codable {
            let id: Int
            let childId: Int
            let title: String?
            let description: String?
            let coinPrice: Int?
            let status: String?
            let createdAt: String
        }
        let dtos: [WishResponse] = try await network.get(
            urlString: baseURL + "/wishes/child/\(childId)"
        )
        return dtos
            .filter { $0.status == "PendingPrice" }
            .map {
                Assignment(
                    id: $0.id,
                    taskId: -1,
                    taskTitle: $0.title ?? "Wish",
                    taskDescription: $0.description,
                    coinReward: $0.coinPrice ?? 0,
                    childId: $0.childId,
                    childName: fallbackName(for: $0.childId),
                    status: .wishRequest,
                    isRewardGranted: false
                )
            }
    }
    
    func getParentTasks(parentId: Int) async throws -> [TaskResponseDTO] {
        try await network.get(urlString: baseURL + "/tasks/parent/\(parentId)")
    }
    
    func approveTask(assignmentId: Int, parentId: Int) async throws -> AssignmentResponseDTO {
        struct ApproveRequest: Codable { let assignmentId: Int; let parentId: Int }
        return try await network.post(
            urlString: baseURL + "/tasks/approve",
            body: ApproveRequest(assignmentId: assignmentId, parentId: parentId)
        )
    }
    
    func getPendingWishes(parentId: Int) async throws -> [Wish] {
        do {
            let dtos: [WishResponseDTO] = try await network.get(
                urlString: baseURL + "/wishes/pending/\(parentId)"
            )
            return dtos.map { $0.toDomain() }
        } catch {
            return []
        }
    }
    func setWishPrice(wishId: Int, coinPrice: Int, parentId: Int) async throws -> Wish {
        let dto: WishResponseDTO = try await network.post(
            urlString: baseURL + "/wishes/price",
            body: SetWishPriceRequestDTO(wishId: wishId, price: coinPrice, parentId: parentId)
        )
        return dto.toDomain()
    }
}
