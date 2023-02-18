import SwiftUI

@available(macOS 11, iOS 14, *)
public struct FingerSeeker {
    public init(_ seeker: [CGRect: String] = [CGRect: String](),
                _ finger: String? = nil) {
        self.seeker = seeker
        self.finger = finger
    }
    public var seeker: [CGRect: String]
    public var finger: String?
}

@available(macOS 11, iOS 14, *)
public struct Seeker<Content: View>: View {

    public let content: Content
    @Binding public var seeker: FingerSeeker
    
    public init(_ seeker: Binding<FingerSeeker>,
                @ViewBuilder content: () -> Content)
    {
        self._seeker = seeker
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.000000001)
                .gesture(
                    DragGesture(minimumDistance: 2, coordinateSpace: .global)
                        .onChanged { dragGesture in
                            for key in seeker.seeker.keys {
                                if key.contains(dragGesture.location) {
                                    seeker.finger = seeker.seeker[key]
                                } else {
                                    seeker.finger = nil
                                }
                            }
                        }
                        .onEnded { dragGesture in
                            DispatchQueue.main.async {
                                seeker.finger = nil
                            }
                        }
                )
            content
        }
    }
}
