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
            
            VStack(spacing: 12) {
                ForEach(KidsRewardTask.mock.filter { !$0.isCompleted && !$0.isRecent }) { task in
                    MissionCard(task: task)
                }
            }
            .padding(.horizontal, 16)
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
            
            VStack(spacing: 1) {
                ForEach(KidsRewardTask.mock.filter { $0.isCompleted }) { task in
                    RewardRow(task: task)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.systemGray6))
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
            )
            .padding(.horizontal, 16)
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
