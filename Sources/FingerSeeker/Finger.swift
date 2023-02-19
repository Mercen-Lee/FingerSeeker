import SwiftUI

@available(macOS 11, iOS 14, *)
extension CGRect: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(minX)
        hasher.combine(minY)
    }
}

@available(macOS 11, iOS 14, *)
public struct Finger: ViewModifier {
    
    public let tag: String
    @EnvironmentObject public var seeker: FingerSeeker
    
    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { (geometry) -> Color in
                    let rect = geometry.frame(in: .global)
                    DispatchQueue.main.async {
                        seeker.seeker[rect] = tag
                    }
                    return .clear
                }
            )
    }
}

@available(macOS 11, iOS 14, *)
public extension View {
    @ViewBuilder func finger(_ tag: String) -> some View {
        self
            .modifier(Finger(tag: tag))
    }
}
