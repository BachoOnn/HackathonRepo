//
//  KidsHomeView+Extension.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

extension KidsHomeView {
    
    var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Image("tbc")
                    .resizable()
                    .frame(width: 35, height: 30)
                    .padding(.bottom, 4)
                
                Text("Hello,")
                    .font(.system(size: 16))
                    .foregroundStyle(Color(.systemGray))
                
                HStack(spacing: 8) {
                    Text("\(viewModel.childName)!")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.primary)
                    Text("👋")
                        .font(.system(size: 22))
                }
            }
            
            Spacer()
            kidAvatar
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
    
    private var kidAvatar: some View {
        ZStack(alignment: .bottomTrailing) {
            Text("👧🏼")
                .font(.system(size: 34))
                .frame(width: 60, height: 60)
                .background(Circle().fill(Color(.systemBlue)))
            
            Circle()
                .fill(Color(.systemGreen))
                .frame(width: 14, height: 14)
                .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 2))
        }
    }
    
    var cardSection: some View {
        SectionCard {
            VStack(alignment: .leading, spacing: 45) {
                
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total Available")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.primary)
                        
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            Text(String(format: "%.2f", viewModel.balance.money))
                                .font(.system(size: 30, weight: .bold))
                            Text("₾")
                                .font(.system(size: 22, weight: .semibold))
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button { } label: {
                            Image(systemName: "pencil")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color(.systemBlue))
                        }
                        Button { } label: {
                            Image(systemName: "eye.slash")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color(.systemBlue))
                        }
                    }
                }
                
                HStack(spacing: 16) {
                    Image("card1")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Kid Card")
                            .font(.system(size: 15, weight: .semibold))
                        Text("MC GOLD")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(.systemGray))
                    }
                    
                    Spacer()
                    AmountView(amount: "\(viewModel.balance.money)")
                }
            }
        }
        .padding(.top, 20)
    }
    
    var balanceCardSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Image("balance")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("My Balance")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color(.systemGreen))
                    }
                    
                    HStack(alignment: .center, spacing: 14) {
                        Text("\(viewModel.balance.coins)")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundStyle(.white)
                        Image("coin")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    HStack(spacing: 6) {
                        Text("Level \(viewModel.level)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                        Text("🏆")
                            .font(.system(size: 16))
                    }
                    starRating(current: viewModel.level, total: 5)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ProgressView(value: viewModel.xpProgress)
                    .tint(
                        LinearGradient(
                            colors: [Color(.systemGreen), Color(.systemTeal)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .scaleEffect(x: 1, y: 1.6)
                
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(Color(.systemGreen))
                        Text("\(viewModel.xpInLevel) XP")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color(.systemGreen))
                    }
                    Spacer()
                    if viewModel.level < 5 {
                        Text("\(viewModel.xpForNextLevel) XP → Level \(viewModel.level + 1)")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(.systemGreen))
                    } else {
                        Text("Max Level! 👑")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(.systemYellow))
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.08, green: 0.28, blue: 0.12),
                            Color(red: 0.05, green: 0.20, blue: 0.10)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color(.systemGreen).opacity(0.3), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
    }
    
    private func starRating(current: Int, total: Int) -> some View {
        HStack(spacing: 4) {
            ForEach(1...total, id: \.self) { index in
                Image(systemName: "star.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(index <= current ? Color(.systemYellow) : Color(.systemGray3))
            }
        }
    }
    
    var pocketQuestSection: some View {
        SectionCard {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray5))
                        .frame(width: 64, height: 64)
                    
                    Image("Wishy")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Wishy")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.primary)
                    
                    Text("\(viewModel.activeMissionCount) missions waiting! 🔥")
                        .font(.system(size: 13))
                        .foregroundStyle(Color(.systemGray))
                    
                    HStack(spacing: 5) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(Color(.systemBlue))
                        Text("total rewards: \(viewModel.totalActiveReward)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(Color(.systemBlue))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(Color(.systemBlue).opacity(0.15)))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color(.systemGray))
            }
        }
        .onTapGesture { viewModel.navigateToWishy() }
    }
    
    var achievementsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel(title: "ACHIEVEMENTS")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(KidsAchievement.mock) { achievement in
                        AchievementBadge(achievement: achievement)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    var recentRewardsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel(title: "RECENT REWARDS")
            
            if viewModel.recentTransactions.isEmpty {
                Text("No recent rewards yet")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.systemGray))
                    .padding(.horizontal, 16)
            } else {
                VStack(spacing: 1) {
                    ForEach(viewModel.recentTransactions) { tx in
                        TransactionRow(transaction: tx)
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
    }
    
    private func sectionLabel(title: String) -> some View {
        Text(title)
            .font(.system(size: 13, weight: .heavy))
            .foregroundStyle(Color(.systemGray))
            .tracking(1.2)
            .padding(.horizontal, 16)
    }
}
