//
//  WishyView.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct WishyView: View {
    @StateObject var viewModel = WishyViewModel()
    
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
    }
}

#Preview {
    WishyView()
}
