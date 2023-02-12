import SwiftUI

@available(macOS 11, iOS 14, *)
extension CGRect: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(minX)
        hasher.combine(minY)
    }
}
