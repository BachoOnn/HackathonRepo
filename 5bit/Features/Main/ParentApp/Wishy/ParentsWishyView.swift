//
//  WishyView.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct ParentsWishyView: View {
    @StateObject var viewModel: ParentWishyViewModel
    @State var showAddTask = false
    
    var body: some View {
        ZStack {
            TBCBackground()
            VStack(spacing: 16) {
                headerSection
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        kidCardSection
                        statsSection
                        taskListSection
                    }
                    .padding(.bottom, 24)
                }
            }
            .padding(.top, 10)
        }
        .sheet(isPresented: $showAddTask, onDismiss: {
            viewModel.onLoad()
        }) {
            AddTaskView(viewModel: DIContainer.shared.makeAddTaskViewModel(
                parentId: viewModel.coordinator?.currentUser?.userId ?? 1,
                kids: viewModel.kids
            ))
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(24)
        }
        .sheet(isPresented: $viewModel.showSetPriceSheet) {
            SetWishPriceView(viewModel: viewModel)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(24)
        }
        
        .task { viewModel.onLoad() }
        .refreshable { viewModel.onLoad() }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}
