//
//  KidsWishyView.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct KidsWishyView: View {
    
    @StateObject var viewModel: KidsWishyViewModel
    @State var showRequestView = false
    
    var body: some View {
        ZStack {
            TBCBackground()

            VStack(spacing: 0) {
                headerSection
                    .padding(.bottom, 20)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        activeMissionsSection
                        askParentSection
                        wishesSection
                        completedSection
                    }
                    .padding(.bottom, 32)
                    .padding(.top, 16)
                }
            }
            .padding(.top, 20)
        }
        .sheet(isPresented: $showRequestView, onDismiss: {
            viewModel.onLoad()
        }) {
            RequestView(viewModel: DIContainer.shared.makeRequestViewModel(childId: viewModel.childId))
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(24)
        }
        .task { viewModel.onLoad() }
    }
}
