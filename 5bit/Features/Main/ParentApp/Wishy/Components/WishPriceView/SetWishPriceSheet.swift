//
//  SetWishPriceSheet.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct SetWishPriceView: View {
    @ObservedObject var viewModel: ParentWishyViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            TBCBackground()
            VStack(spacing: 24) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Set Wish Price")
                            .font(.system(size: 22, weight: .bold))
                        Text("How many coins should this cost?")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(.systemGray))
                    }
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 36, height: 36)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray5)))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 28)

                if let wish = viewModel.selectedWish {
                    SectionCard {
                        HStack(spacing: 14) {
                            Text("⭐️")
                                .font(.system(size: 28))
                                .frame(width: 52, height: 52)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray5)))
                            VStack(alignment: .leading, spacing: 4) {
                                Text(wish.title)
                                    .font(.system(size: 15, weight: .bold))
                                if let desc = wish.description, !desc.isEmpty {
                                    Text(desc)
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color(.systemGray))
                                        .lineLimit(2)
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                }

                SectionCard {
                    HStack {
                        Image("coin").resizable().frame(width: 20, height: 20)
                        TextField("Coin price", text: $viewModel.wishPriceInput)
                            .keyboardType(.numberPad)
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                        if viewModel.wishPriceInt > 0 {
                            Text("= \(viewModel.wishPriceInt) coins")
                                .font(.system(size: 13))
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                }
                .padding(.horizontal, 16)

                HStack(spacing: 10) {
                    ForEach([10, 25, 50, 100], id: \.self) { amount in
                        Button { viewModel.wishPriceInput = "\(amount)" } label: {
                            Text("\(amount) 🪙")
                                .font(.system(size: 13, weight: .semibold))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Capsule().fill(Color(.systemGray5)))
                                .foregroundStyle(.primary)
                        }
                    }
                }

                Button { viewModel.submitWishPrice() } label: {
                    Text("Set Price & Notify Kid")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(viewModel.isWishPriceValid ? Color.purple : Color(.systemGray3))
                        )
                }
                .disabled(!viewModel.isWishPriceValid)
                .padding(.horizontal, 16)

                Spacer()
            }
        }
        .onChange(of: viewModel.showSetPriceSheet) { _, show in
            if !show { dismiss() }
        }
    }
    
    private func wishRow(_ wish: Wish) -> some View {
        HStack(spacing: 14) {
            Text("⭐️")
                .font(.system(size: 20))
                .frame(width: 42, height: 42)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray5)))
            
            VStack(alignment: .leading, spacing: 3) {
                Text(wish.title)
                    .font(.system(size: 14, weight: .semibold))
                if let desc = wish.description, !desc.isEmpty {
                    Text(desc)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(.systemGray))
                        .lineLimit(1)
                }
            }
            Spacer()
            Button {
                viewModel.openSetPrice(for: wish)
            } label: {
                Text("Set Price")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.purple))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}
