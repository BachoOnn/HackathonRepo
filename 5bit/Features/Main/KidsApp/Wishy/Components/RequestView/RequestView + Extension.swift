//
//  RequestView + Extension.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

extension RequestView {
    
    var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Request a Task")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.primary)
                Text("Ask your parent for a task")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.systemGray))
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(width: 36, height: 36)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray5))
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .padding(.bottom, 8)
    }
    
    var requestTypeSection: some View {
        HStack(spacing: 10) {
            requestTypeButton(
                icon: "⭐️",
                label: "Wish",
                subtitle: "Want something",
                type: .wish
            )
            requestTypeButton(
                icon: "⚡️",
                label: "Task Request",
                subtitle: "Ask for a task",
                type: .task
            )
        }
    }
    
    private func requestTypeButton(icon: String, label: String, subtitle: String, type: RequestType) -> some View {
        let isSelected = viewModel.selectedType == type
        
        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.selectedType = type
                viewModel.selectedCategory = nil
            }
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                Text(icon)
                    .font(.system(size: 24))
                
                Text(label)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(isSelected ? Color.purple : .primary)
                
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundStyle(Color(.systemGray))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(
                                isSelected ? Color.purple : Color.clear,
                                lineWidth: 1.5
                            )
                    )
                    .shadow(
                        color: isSelected ? Color.purple.opacity(0.2) : .black.opacity(0.15),
                        radius: isSelected ? 6 : 2, x: 0, y: 2
                    )
            )
        }
    }
    
    var categorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel("What do you want to do?")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.categories) { category in
                        categoryChip(category)
                    }
                }
                .padding(.horizontal, 1)
            }
        }
    }
    
    private func categoryChip(_ category: RequestCategory) -> some View {
        let isSelected = viewModel.selectedCategory?.id == category.id
        
        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.selectedCategory = category
            }
        } label: {
            HStack(spacing: 6) {
                Text(category.emoji)
                    .font(.system(size: 14))
                Text(category.label)
                    .font(.system(size: 14, weight: isSelected ? .bold : .medium))
                    .foregroundStyle(isSelected ? .white : .primary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(isSelected
                          ? LinearGradient(colors: [Color.purple, Color(red: 0.5, green: 0.1, blue: 0.9)], startPoint: .leading, endPoint: .trailing)
                          : LinearGradient(colors: [Color(.systemGray5), Color(.systemGray5)], startPoint: .leading, endPoint: .trailing)
                         )
            )
        }
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel("Description")
            
            ZStack(alignment: .bottomTrailing) {
                SectionCard {
                    TextField("Describe what you want to do...", text: $viewModel.description, axis: .vertical)
                        .font(.system(size: 15))
                        .foregroundStyle(.primary)
                        .lineLimit(6, reservesSpace: true)
                        .tint(Color.purple)
                }
                
                Text("\(viewModel.description.count)/100")
                    .font(.system(size: 11))
                    .foregroundStyle(Color(.systemGray))
                    .padding(.trailing, 28)
                    .padding(.bottom, 14)
            }
        }
    }
    
    var sendButtonSection: some View {
        VStack(spacing: 10) {
            Button {
                viewModel.send()
                dismiss()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "envelope.fill")
                        .font(.system(size: 15, weight: .semibold))
                    Text("📩")
                        .font(.system(size: 15))
                    Text("Send Request")
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
            .disabled(!viewModel.isValid)
            .opacity(viewModel.isValid ? 1 : 0.5)
            
            Text("Parent will receive notification")
                .font(.system(size: 12))
                .foregroundStyle(Color(.systemGray))
        }
    }
    
    private func sectionLabel(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(.primary)
    }
}
