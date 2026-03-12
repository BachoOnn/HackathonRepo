//
//  KidsHomeView.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct KidsHomeView: View {
    var body: some View {
        ZStack {
            TBCBackground()
            
            VStack(spacing: 20) {
                headerSection
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        balanceCardSection
                        pocketQuestSection
                        achievementsSection
                        recentRewardsSection
                    }
                    .padding(.bottom, 32)
                }
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    KidsHomeView()
}
