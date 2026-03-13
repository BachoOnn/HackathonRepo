//
//  AuthRepository.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import Foundation
import MyNetworkManager

final class AuthRepository: AuthRepositoryProtocol {
    private let network: NetworkManager
    private let baseURL: String

    init(network: NetworkManager = NetworkManager()) {
        self.network = network
        self.baseURL = Bundle.main.API_BASE_URL
        print("🌐 baseURL: \(baseURL)")
    }

    func login(email: String, password: String) async throws -> User {
        let dto: LoginResponseDTO = try await network.post(
            urlString: baseURL + "/auth/login",
            body: LoginRequestDTO(email: email, password: password)
        )
        return try dto.toDomain()
    }
}
