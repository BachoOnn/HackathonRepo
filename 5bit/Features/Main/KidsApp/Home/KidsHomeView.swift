//
//  KidsHomeView.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct KidsHomeView: View {
    @StateObject var viewModel: KidsHomeViewModel
    
    var body: some View {
        ZStack {
            TBCBackground()
            VStack(spacing: 20) {
                headerSection
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        cardSection
                        balanceCardSection
                        missionSection
                        achievementsSection
                        recentRewardsSection
                    }
                    .padding(.bottom, 32)
                }
            }
            .padding(.top, 20)
        }
        .task { viewModel.onLoad() }
        .refreshable { viewModel.onLoad() }
    }
}
