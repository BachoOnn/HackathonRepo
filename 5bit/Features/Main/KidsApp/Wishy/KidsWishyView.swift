//
//  KidsWishyView.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct KidsWishyView: View {
    
    @StateObject var viewModel: KidsWishyViewModel
    
    var body: some View {
        ZStack {
            TBCBackground()

            VStack(spacing: 0) {
                headerSection
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        activeMissionsSection
                        askParentSection
                        completedSection
                    }
                    .padding(.bottom, 32)
                    .padding(.top, 16)
                }
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    KidsWishyView(viewModel: KidsWishyViewModel())
}
