//
//  KidRepositoryProtocol.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol KidRepositoryProtocol {
    func getAssignments(childId: Int) async throws -> [Assignment]
    func acceptTask(assignmentId: Int, childId: Int) async throws -> Assignment
    func completeTask(assignmentId: Int, childId: Int) async throws -> Assignment
    func getBalance(childId: Int) async throws -> KidBalance
    func getTransactionHistory(childId: Int) async throws -> [Transaction]
    func createWish(childId: Int, title: String, description: String?) async throws -> Wish
    func getWishes(childId: Int) async throws -> [Wish]
    func convertCoins(childId: Int, amount: Int) async throws -> KidBalance
    func redeemWish(wishId: Int, childId: Int) async throws -> Wish
}
