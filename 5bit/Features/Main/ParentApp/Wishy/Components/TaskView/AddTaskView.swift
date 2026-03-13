//
//  AddTaskView.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct AddTaskView: View {
    @StateObject var viewModel: AddTaskViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            TBCBackground()
            VStack(spacing: 0) {
                headerSection
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        kidPickerSection
                        taskPickerSection
                        rewardSection
                        descriptionSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 40)
                }
            }
        }
        .onChange(of: viewModel.didSubmitSuccessfully) { _, success in
            if success { dismiss() }
        }
    }
}
