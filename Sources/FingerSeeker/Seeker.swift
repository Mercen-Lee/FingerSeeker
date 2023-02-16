import SwiftUI

@available(macOS 11, iOS 14, *)
public struct FingerSeeker {
    public var seeker: [CGRect: String] = [CGRect.zero: String()]
    public var finger: String? = nil
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
        content
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
    }
}
