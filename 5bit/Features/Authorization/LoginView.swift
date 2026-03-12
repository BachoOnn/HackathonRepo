//
//  LoginView.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.tbc
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                logoSection
                inputsSection
                Spacer()
            }
            .padding(.top, 50)
        }
        .onTapGesture {
            isFocused = false
        }
    }
}

