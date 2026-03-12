//
//  ParentHomeView + Extension.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

extension ParentHomeView {
    
    var headerSection: some View {
        HStack {
            NotificationIconButton(icon: "line.3.horizontal") { }
            Spacer()
            Image("tbcBank")
                .resizable()
                .frame(width: 90, height: 25)
            Spacer()
            NotificationIconButton(icon: "qrcode") { }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
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
                            Text("12.78")
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
                    Image("card")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Card")
                            .font(.system(size: 15, weight: .semibold))
                        Text("MC GOLD")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(.systemGray))
                    }
                    
                    Spacer()
                    AmountView(amount: "12.78")
                }
            }
        }
        .padding(.top, 20)
    }
    
    var WishySection: some View {
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
                    
                    HStack(spacing: 5) {
                        Image(systemName: "arrow.left.arrow.right.circle.fill")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color(.systemBlue))
                        
                        Text("GET STARTED")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(Color(.systemBlue))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(Color(.systemBlue).opacity(0.15)))
                    
                    Text("Create tasks for your kids")
                        .font(.system(size: 13))
                        .foregroundStyle(Color(.systemGray))
                        .lineLimit(2)
                }
                
                Spacer()
            }
        }
    }
    
    var loyaltySection: some View {
        SectionCard {
            VStack(alignment: .leading, spacing: 14) {
                Text("Loyalty Reward")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.primary)
                
                HStack(spacing: 12) {
                    Image("loyalty")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                    
                    Text("Earned amount")
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.label))
                    
                    Spacer()
                    AmountView(amount: "3.74")
                }
            }
        }
    }
}
