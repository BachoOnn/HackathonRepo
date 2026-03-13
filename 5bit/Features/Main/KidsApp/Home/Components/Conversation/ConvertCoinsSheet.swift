//
//  ConvertCoinsSheet.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct ConvertCoinsView: View {
    @ObservedObject var viewModel: KidsHomeViewModel
    
    var body: some View {
        ZStack {
            TBCBackground()
            
            VStack(spacing: 24) {
                VStack(spacing: 6) {
                    Text("Convert Coins")
                        .font(.system(size: 22, weight: .bold))
                    Text("10 coins = 1 ₾")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(.systemGray))
                }
                .padding(.top, 28)
                
                HStack(spacing: 20) {
                    balancePill(icon: "coin", value: "\(viewModel.balance.coins)", label: "Available")
                    Image(systemName: "arrow.right")
                        .foregroundStyle(Color(.systemGray))
                    balancePill(icon: nil, value: String(format: "%.2f ₾", viewModel.balance.money), label: "Current GEL")
                }
                
                SectionCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image("coin").resizable().frame(width: 20, height: 20)
                            TextField("Amount (multiples of 10)", text: $viewModel.convertAmount)
                                .keyboardType(.numberPad)
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                            if viewModel.convertAmountInt > 0 {
                                Text("= \(String(format: "%.1f", viewModel.gelPreview)) ₾")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color(.systemGreen))
                            }
                        }
                        
                        if !viewModel.convertAmount.isEmpty && viewModel.convertAmountInt % 10 != 0 {
                            Text("⚠️ Must be a multiple of 10")
                                .font(.system(size: 12))
                                .foregroundStyle(Color(.systemOrange))
                        }
                        
                        if viewModel.convertAmountInt > viewModel.balance.coins {
                            Text("⚠️ Not enough coins")
                                .font(.system(size: 12))
                                .foregroundStyle(Color(.systemRed))
                        }
                        
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .font(.system(size: 12))
                                .foregroundStyle(Color(.systemRed))
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                HStack(spacing: 10) {
                    ForEach([10, 20, 50], id: \.self) { amount in
                        if amount <= viewModel.balance.coins {
                            Button {
                                viewModel.convertAmount = "\(amount)"
                            } label: {
                                Text("\(amount) 🪙")
                                    .font(.system(size: 13, weight: .semibold))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(Capsule().fill(Color(.systemGray5)))
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                }
                
                Button {
                    viewModel.convert()
                } label: {
                    Group {
                        if viewModel.isConverting {
                            ProgressView().tint(.white)
                        } else {
                            Text("Convert to GEL")
                                .font(.system(size: 16, weight: .bold))
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(viewModel.isConvertValid
                                  ? Color(.systemBlue)
                                  : Color(.systemGray3))
                    )
                }
                .disabled(!viewModel.isConvertValid || viewModel.isConverting)
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
    }
    
    private func balancePill(icon: String?, value: String, label: String) -> some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                if let icon { Image(icon).resizable().frame(width: 16, height: 16) }
                Text(value).font(.system(size: 16, weight: .bold))
            }
            Text(label).font(.system(size: 11)).foregroundStyle(Color(.systemGray))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
    }
}
