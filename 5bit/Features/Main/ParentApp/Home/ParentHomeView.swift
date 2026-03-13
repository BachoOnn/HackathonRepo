//
//  ParentHomeView.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct ParentHomeView: View {
    
    @StateObject var viewModel: ParentHomeViewModel
    
    var body: some View {
        ZStack {
            TBCBackground()
            
            VStack(spacing: 16) {
                headerSection
                cardSection
                WishySection
                loyaltySection
                Spacer()
            }
            .padding(.top, 20)
        }
    }
}
