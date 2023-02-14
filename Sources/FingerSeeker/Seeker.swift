import SwiftUI

@available(macOS 11, iOS 14, *)
public struct FingerSeeker {
    public var seeker: [CGRect: String] = [CGRect.zero: String()]
    public var finger: String? = nil
}
