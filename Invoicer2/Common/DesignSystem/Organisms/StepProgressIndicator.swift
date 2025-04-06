//
//  StepProgressIndicator.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 06/04/25.
//

import SwiftUI

struct StepProgressIndicator: View {
    var step: Int
    var total: Int

    private var progress: CGFloat {
        guard total > 0 else { return 0 }
        return min(CGFloat(step) / CGFloat(total), 1)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 20)

                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.green)
                    .frame(width: geometry.size.width * progress, height: 20)
                    .animation(.easeInOut, value: progress)
            }
        }
        .frame(height: 20)
    }
}

