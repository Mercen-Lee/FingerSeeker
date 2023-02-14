import SwiftUI

@available(macOS 11, iOS 14, *)
extension CGRect: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(minX)
        hasher.combine(minY)
    }
}

@available(macOS 11, iOS 14, *)
public extension View {
    @ViewBuilder func finger(_ seeker: Binding<FingerSeeker>, _ tag: String) -> some View {
        self
            .background(
                GeometryReader { (geometry) -> Color in
                    let rect = geometry.frame(in: .global)
                    DispatchQueue.main.async {
                        seeker.seeker.wrappedValue[rect] = tag
                    }
                    return .clear
                }
            )
    }
}
