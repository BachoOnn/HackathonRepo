//
//  AmountView.swift
//  5bit
//
//  Created by Bacho on 12.03.26.
//

import SwiftUI

struct AmountView: View {
    let amount: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 3) {
            Text(amount)
                .font(.system(size: 18, weight: .semibold))
            Image("coin")
                .resizable()
                .frame(width: 12, height: 12)
        }
    }
}
