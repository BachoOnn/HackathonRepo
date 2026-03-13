//
//  WishyView+Extension.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

extension ParentsWishyView {
    
    var headerSection: some View {
        HStack {

            Spacer()
            
                Text("Wishy")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.leading, 70)
            
            Spacer()
            
            Button {
                showAddTask = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "plus")
                        .font(.system(size: 13, weight: .bold))
                    Text("Task")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray3).opacity(0.4))
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
    
    var kidCardSection: some View {
        VStack(spacing: 10) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.kids) { kid in
                        kidCard(kid)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .contentMargins(.horizontal, 16, for: .scrollContent)
            
            HStack(spacing: 6) {
                ForEach(viewModel.kids) { kid in
                    Circle()
                        .fill(kid.id == viewModel.selectedKid.id ? Color(.systemBlue) : Color(.systemGray4))
                        .frame(
                            width: kid.id == viewModel.selectedKid.id ? 8 : 6,
                            height: kid.id == viewModel.selectedKid.id ? 8 : 6
                        )
                        .animation(.easeInOut(duration: 0.2), value: viewModel.selectedKid.id)
                }
            }
        }
    }
    
    private func kidCard(_ kid: KidProfile) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 14) {
                Text(kid.emoji)
                    .font(.system(size: 32))
                    .frame(width: 56, height: 56)
                    .background(Circle().fill(Color(.systemBlue)))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(kid.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.primary)
                    Text("\(kid.completedTasks) tasks completed")
                        .font(.system(size: 13))
                        .foregroundStyle(Color(.systemGray))
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image("coin")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("\(kid.balance)")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color(.systemYellow))
                }
            }
            
            HStack {
                Text("\(kid.completedTasks)/\(kid.totalTasks) tasks")
                    .font(.system(size: 13))
                    .foregroundStyle(Color(.systemGray))
                Spacer()
                Text("\(Int(kid.progress * 100))%")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color(.systemBlue))
            }
            
            ProgressView(value: max(0, min(kid.progress, 1)))
                .tint(Color(.systemBlue))
                .scaleEffect(x: 1, y: 1.4)
        }
        .padding(16)
        .containerRelativeFrame(.horizontal, count: 1, spacing: 12)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemGray6))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .strokeBorder(
                            viewModel.selectedKid.id == kid.id ? Color(.systemBlue) : Color.clear,
                            lineWidth: 1.5
                        )
                )
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.selectKid(kid)
            }
        }
    }
    
    var statsSection: some View {
        HStack(spacing: 10) {
            WishyStatCell(icon: "bolt.fill",       iconColor: .systemBlue,   count: viewModel.taskCount(for: .progress), label: "Progress", tab: .progress,  selectedTab: $viewModel.selectedTab)
            WishyStatCell(icon: "clock",            iconColor: .systemOrange, count: viewModel.taskCount(for: .review),   label: "Review",   tab: .review,    selectedTab: $viewModel.selectedTab)
            WishyStatCell(icon: "envelope",         iconColor: .systemPurple, count: viewModel.taskCount(for: .requests), label: "Request",  tab: .requests,  selectedTab: $viewModel.selectedTab)
            WishyStatCell(icon: "checkmark.circle", iconColor: .systemGreen,  count: viewModel.taskCount(for: .done),     label: "Done",     tab: .done,      selectedTab: $viewModel.selectedTab)
        }
        .padding(.horizontal, 16)
    }
    
    var taskListSection: some View {
        VStack(spacing: 10) {
            if viewModel.isLoading {
                ProgressView().padding(.top, 20)
            } else if viewModel.selectedTab == .requests {
                requestsTabContent
            } else {
                defaultTabContent
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var requestsTabContent: some View {
        let parentTasks = viewModel.filteredAssignments.filter { $0.status == .notStarted }
        let kidWishes   = viewModel.filteredAssignments.filter { $0.status == .wishRequest }
        
        return VStack(alignment: .leading, spacing: 16) {
            if parentTasks.isEmpty && kidWishes.isEmpty {
                Text("No requests")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.systemGray))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
            }
            
            if !parentTasks.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    subsectionLabel("ASSIGNED BY YOU")
                    VStack(spacing: 0) {
                        ForEach(parentTasks) { assignment in
                            AssignmentRow(assignment: assignment)
                            if assignment.id != parentTasks.last?.id {
                                Divider().padding(.leading, 74)
                            }
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
                }
            }
            
            if !kidWishes.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    subsectionLabel("REQUESTED BY KID ⭐️")
                    VStack(spacing: 0) {
                        ForEach(kidWishes) { assignment in
                            AssignmentRow(assignment: assignment)
                            if assignment.id != kidWishes.last?.id {
                                Divider().padding(.leading, 74)
                            }
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
                }
            }
        }
    }
    
    private var defaultTabContent: some View {
        VStack(spacing: 0) {
            if viewModel.filteredAssignments.isEmpty {
                EmptyView()
            } else {
                ForEach(viewModel.filteredAssignments) { assignment in
                    AssignmentRow(
                        assignment: assignment,
                        onApprove: viewModel.selectedTab == .review
                        ? { viewModel.approveTask(assignment) }
                        : nil
                    )
                    if assignment.id != viewModel.filteredAssignments.last?.id {
                        Divider().padding(.leading, 74)
                    }
                }
            }
        }
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
    }
    
    private func subsectionLabel(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 11, weight: .heavy))
            .foregroundStyle(Color(.systemGray))
            .tracking(1.0)
    }
}
