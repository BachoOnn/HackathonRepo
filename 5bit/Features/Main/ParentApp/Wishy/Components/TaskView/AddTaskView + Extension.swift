//
//  AddTaskView + Extension.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

extension AddTaskView {
    
    var headerSection: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            Text("New Task")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.primary)
                .padding(.leading, 40)
            
            Spacer()
            
            Button {
                viewModel.submit()
                dismiss()
            } label: {
                Text("Add")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color(.systemBlue))
                    )
            }
            .disabled(!viewModel.isValid)
            .opacity(viewModel.isValid ? 1 : 0.4)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
    
    var taskPickerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel("Choose a task")
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(TaskTemplate.all) { template in
                    taskCell(template)
                }
            }
        }
    }
    
    private func taskCell(_ template: TaskTemplate) -> some View {
        let isSelected = viewModel.selectedTemplate?.id == template.id
        
        return VStack(alignment: .leading, spacing: 12) {
            Text(template.emoji)
                .font(.system(size: 34))
            
            Text(template.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(
                            isSelected ? Color(.systemBlue) : Color.clear,
                            lineWidth: 1.5
                        )
                )
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.selectedTemplate = template
            }
        }
    }
    
    var rewardSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel("Reward")
            
            SectionCard {
                HStack {
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Image("coin")
                            .resizable()
                            .frame(width: 28, height: 28)
                        
                        TextField("0", text: $viewModel.rewardInput)
                            .font(.system(size: 36, weight: .bold))
                            .foregroundStyle(Color(.systemYellow))
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .tint(Color(.systemBlue))
                            .onChange(of: viewModel.rewardInput) { _, newValue in
                                let filtered = newValue.filter(\.isNumber)
                                let trimmed = filtered.isEmpty ? "" : String(Int(filtered) ?? 0)
                                if trimmed != newValue { viewModel.rewardInput = trimmed }
                            }
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            
            HStack(spacing: 10) {
                ForEach(AddTaskViewModel.quickRewards, id: \.self) { amount in
                    Button {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            viewModel.applyQuickReward(amount)
                        }
                    } label: {
                        Text("\(amount)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(viewModel.reward == amount ? .white : .primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(
                                Capsule()
                                    .fill(viewModel.reward == amount ? Color(.systemBlue) : Color(.systemGray5))
                            )
                    }
                }
            }
        }
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel("Description")
            
            SectionCard {
                TextField("Add details about this task...", text: $viewModel.description, axis: .vertical)
                    .font(.system(size: 15))
                    .foregroundStyle(.primary)
                    .lineLimit(4, reservesSpace: true)
                    .tint(Color(.systemBlue))
            }
        }
    }
    
    private func sectionLabel(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 15, weight: .medium))
            .foregroundStyle(Color(.systemGray))
    }
}
