//
//  ParentHomeView.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct ParentHomeView: View {
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

#Preview {
    ParentHomeView()
}
    
