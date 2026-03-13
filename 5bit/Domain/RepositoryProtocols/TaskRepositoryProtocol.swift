//
//  TaskRepositoryProtocol.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol TaskRepositoryProtocol {
    func getParentAssignments(parentId: Int) async throws -> [Assignment]
    func getPendingAssignments(parentId: Int) async throws -> [Assignment]
    func getParentTasks(parentId: Int) async throws -> [TaskResponseDTO]
    func getChildBalance(childId: Int) async throws -> Int
    func getChildrenForParent() async throws -> [(id: Int, name: String)]
    func createTask(parentId: Int, title: String, description: String?, type: String?, coinReward: Int) async throws -> Int
    func assignTask(taskId: Int, childId: Int) async throws
    func getChildWishes(childId: Int) async throws -> [Assignment]
    func approveTask(assignmentId: Int, parentId: Int) async throws -> AssignmentResponseDTO
    func getPendingWishes(parentId: Int) async throws -> [Wish]
    func setWishPrice(wishId: Int, coinPrice: Int, parentId: Int) async throws -> Wish
}
