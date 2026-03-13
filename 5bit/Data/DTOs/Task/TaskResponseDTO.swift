//
//  TaskResponseDTO.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//


struct TaskResponseDTO: Codable {
    let id: Int
    let title: String?
    let description: String?
    let type: String?
    let coinReward: Int
    let createdByParentId: Int
    let createdAt: String
}