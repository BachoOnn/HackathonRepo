//
//  RequestView.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct RequestView: View {
    @StateObject var viewModel: RequestViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            TBCBackground()

            VStack(spacing: 0) {
                headerSection
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        requestTypeSection
                        categorySection
                        descriptionSection
                        sendButtonSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 40)
                }
            }
        }
        .onChange(of: viewModel.didSendSuccessfully) { _, success in
            if success { dismiss() }
        }
    }
}
