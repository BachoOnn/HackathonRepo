//
//  GetParentAssignmentsUseCase.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

protocol GetParentAssignmentsUseCase {
    func execute(parentId: Int) async throws -> [Assignment]
}

struct DefaultGetParentAssignmentsUseCase: GetParentAssignmentsUseCase {
    private let taskRepository: TaskRepositoryProtocol
    
    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
    
    func execute(parentId: Int) async throws -> [Assignment] {
        async let assignmentsTask = taskRepository.getParentAssignments(parentId: parentId)
        async let tasksTask = taskRepository.getParentTasks(parentId: parentId)
        
        var (all, tasks) = try await (assignmentsTask, tasksTask)
        
        let descriptionMap = Dictionary(uniqueKeysWithValues: tasks.map { ($0.id, $0.description) })
        
        all = all.map { assignment in
            Assignment(
                id: assignment.id,
                taskId: assignment.taskId,
                taskTitle: assignment.taskTitle,
                taskDescription: descriptionMap[assignment.taskId] ?? nil,
                coinReward: assignment.coinReward,
                childId: assignment.childId,
                childName: assignment.childName,
                status: assignment.status,
                isRewardGranted: assignment.isRewardGranted
            )
        }
        
        for childId in [2, 3, 4] {
            let wishes = (try? await taskRepository.getChildWishes(childId: childId)) ?? []
            all += wishes
        }
        
        return all
    }
}
