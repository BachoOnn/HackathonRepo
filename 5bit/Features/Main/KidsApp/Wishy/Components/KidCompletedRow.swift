//
//  KidCompletedRow.swift
//  5bit
//
//  Created by Bacho on 13.03.26.
//

import SwiftUI

struct KidCompletedRow: View {
    let assignment: Assignment

    var body: some View {
        HStack(spacing: 14) {
            Text("🏆")
                .font(.system(size: 20))
                .frame(width: 40, height: 40)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray5)))

            Text(assignment.taskTitle)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.primary)
                .strikethrough(true, color: Color(.systemGray))

            Spacer()

            HStack(spacing: 4) {
                Image("coin").resizable().frame(width: 16, height: 16)
                Text("+\(assignment.coinReward)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color(.systemGreen))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}
