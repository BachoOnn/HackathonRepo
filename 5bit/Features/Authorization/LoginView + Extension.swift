//
//  LoginView+Extension.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

extension LoginView {
    
    var logoSection: some View {
        Image("tbc")
            .resizable()
            .frame(width: 100, height: 100)
    }
    
    var inputsSection: some View {
        VStack(spacing: 20) {
            titleSection
            emailField
            passwordSection
            errorSection
            loginButton
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 24)
    }
    
    private var titleSection: some View {
        Text("Authorization")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.tbc)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Email")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .focused($isFocused)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
    
    private var passwordSection: some View {
        VStack(spacing: 16) {
            passwordField
            authLinks
        }
    }
    
    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Password")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                
                if viewModel.isPasswordVisible {
                    TextField("••••••••", text: $viewModel.password)
                        .focused($isFocused)
                } else {
                    SecureField("••••••••", text: $viewModel.password)
                        .focused($isFocused)
                }
                
                Button {
                    viewModel.isPasswordVisible.toggle()
                } label: {
                    Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
    
    private var authLinks: some View {
        HStack {
            Button("Sign-up") { }
                .font(.subheadline)
                .foregroundColor(.tbc)
            
            Spacer()
            
            Button("Password Reset") { }
                .font(.subheadline)
                .foregroundColor(.tbc)
        }
    }
    
    @ViewBuilder
    private var errorSection: some View {
        if let error = viewModel.errorMessage {
            Text(error)
                .font(.callout)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var loginButton: some View {
        Button {
            isFocused = false
            viewModel.login()
        } label: {
            Text("Login")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.tbc)
                .cornerRadius(30)
        }
        .padding(.top)
    }
}
