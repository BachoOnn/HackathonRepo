//
//  KidsWishyView + Extension.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

extension KidsWishyView {
    
    var headerSection: some View {
        HStack {
            Image("Wishy")
                .resizable()
                .frame(width: 28, height: 28)
            Text("Wishy")
                .font(.system(size: 18, weight: .bold))
        }
    }
    
    var activeMissionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel(title: "ACTIVE MISSIONS")
            
            if viewModel.isLoading {
                ProgressView().padding(.top, 10).padding(.horizontal, 16)
            } else if viewModel.activeMissions.isEmpty {
                Text("No active missions yet")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.systemGray))
                    .padding(.horizontal, 16)
            } else {
                VStack(spacing: 12) {
                    ForEach(viewModel.activeMissions) { assignment in
                        KidMissionCard(
                            assignment: assignment,
                            onAccept: { viewModel.acceptTask(assignment) },
                            onComplete: { viewModel.completeTask(assignment) }
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    var wishesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel(title: "MY WISHES ⭐️")
            
            if viewModel.kidWishes.isEmpty {
                Text("No wishes yet — send one!")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.systemGray))
                    .padding(.horizontal, 16)
            } else {
                VStack(spacing: 10) {
                    ForEach(viewModel.kidWishes) { wish in
                        WishCard(wish: wish, onRedeem: { viewModel.redeemWish(wish) })
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    var askParentSection: some View {
        Button {
            showRequestView = true
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "envelope.fill")
                    .font(.system(size: 16, weight: .semibold))
                Text("Ask Parent for Task")
                    .font(.system(size: 16, weight: .bold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(
                        LinearGradient(
                            colors: [Color.purple, Color(red: 0.5, green: 0.1, blue: 0.9)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: Color.purple.opacity(0.4), radius: 10, x: 0, y: 4)
            )
        }
        .padding(.horizontal, 16)
    }
    
    var completedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel(title: "COMPLETED")
            
            if viewModel.completedMissions.isEmpty {
                Text("No completed tasks yet")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.systemGray))
                    .padding(.horizontal, 16)
            } else {
                VStack(spacing: 1) {
                    ForEach(viewModel.completedMissions) { assignment in
                        KidCompletedRow(assignment: assignment)
                    }
                }
                .background(RoundedRectangle(cornerRadius: 18).fill(Color(.systemGray6)))
                .padding(.horizontal, 16)
            }
        }
    }
    
    private func sectionLabel(title: String) -> some View {
        Text(title)
            .font(.system(size: 13, weight: .heavy))
            .foregroundStyle(Color(.systemGray))
            .tracking(1.2)
            .padding(.horizontal, 16)
    }
}
