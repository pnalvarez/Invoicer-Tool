import SwiftUI

public struct StepProgressIndicator: View {
    public enum Size {
        case small
        case medium
        
        var height: CGFloat {
            switch self {
            case .small:
                return 4
            case .medium:
                return 16
            }
        }
    }
    
    let step: Int
    let total: Int
    let size: Size
    let showLabel: Bool
    
    public init(
        step: Int,
        total: Int,
        size: Size = .medium,
        showLabel: Bool = false
    ) {
        self.step = step
        self.total = total
        self.size = size
        self.showLabel = showLabel
    }
    
    private var progress: CGFloat {
        guard total > 0 else { return 0 }
        return min(CGFloat(step) / CGFloat(total), 1)
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            Text("\(step) of \(total)")
                .font(.body)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: size.height)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.green)
                        .frame(width: geometry.size.width * progress, height: size.height)
                        .animation(.easeInOut, value: progress)
                }
            }
        }
    }
}

#Preview {
    StepProgressIndicator(step: 3, total: 4, size: .small)
        .frame(maxWidth: 120)
        .padding()
}

