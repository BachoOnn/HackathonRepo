//
//  GetKidDataUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol GetKidDataUseCase {
    func execute(childId: Int, parentId: Int?) async throws -> (assignments: [Assignment], balance: KidBalance, history: [Transaction])
}

struct DefaultGetKidDataUseCase: GetKidDataUseCase {
    private let kidRepository: KidRepositoryProtocol
    private let taskRepository: TaskRepositoryProtocol
    
    init(kidRepository: KidRepositoryProtocol, taskRepository: TaskRepositoryProtocol) {
        self.kidRepository = kidRepository
        self.taskRepository = taskRepository
    }
    
    func execute(childId: Int, parentId: Int?) async throws -> (assignments: [Assignment], balance: KidBalance, history: [Transaction]) {
        async let assignmentsTask = kidRepository.getAssignments(childId: childId)
        async let balanceTask = kidRepository.getBalance(childId: childId)
        async let historyTask = kidRepository.getTransactionHistory(childId: childId)
        
        var (assignments, balance, history) = try await (assignmentsTask, balanceTask, historyTask)
        
        if let parentId = parentId {
            let tasks = (try? await taskRepository.getParentTasks(parentId: parentId)) ?? []
            let descMap = Dictionary(uniqueKeysWithValues: tasks.map { ($0.id, $0.description) })
            assignments = assignments.map { a in
                Assignment(
                    id: a.id,
                    taskId: a.taskId,
                    taskTitle: a.taskTitle,
                    taskDescription: descMap[a.taskId] ?? nil,
                    coinReward: a.coinReward,
                    childId: a.childId,
                    childName: a.childName,
                    status: a.status,
                    isRewardGranted: a.isRewardGranted
                )
            }
        }
        
        return (assignments, balance, history)
    }
}
