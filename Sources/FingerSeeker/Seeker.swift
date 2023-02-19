import SwiftUI

@available(macOS 11, iOS 14, *)
public class FingerSeeker: ObservableObject {
    public init(_ seeker: [CGRect: String] = [CGRect: String](),
                _ finger: String? = nil) {
        self.seeker = seeker
        self.finger = finger
    }
    @Published public var seeker: [CGRect: String]
    @Published public var finger: String?
}

@available(macOS 11, iOS 14, *)
public struct Seeker<Content: View>: View {
    
    @StateObject public var seeker = FingerSeeker()
    @Binding public var finger: String?
    public let content: Content
    public var seekEnd: (String?) -> Void?

    public init(_ finger: Binding<String?> = Binding.constant(nil),
                seekEnd: @escaping (String?) -> Void = { _ in },
                @ViewBuilder content: () -> Content)
    {
        self._finger = finger
        self.content = content()
        self.seekEnd = seekEnd
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.000000001)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .global)
                        .onChanged { dragGesture in
                            for key in seeker.seeker.keys {
                                if key.contains(dragGesture.location) {
                                    seeker.finger = seeker.seeker[key]
                                } else {
                                    seeker.finger = nil
                                }
                                finger = seeker.finger
                            }
                        }
                        .onEnded { dragGesture in
                            DispatchQueue.main.async {
                                seekEnd(seeker.finger)
                                seeker.finger = nil
                                finger = seeker.finger
                            }
                        }
                )
            content
                .environmentObject(seeker)
        }
    }
}

@available(macOS 11, iOS 14, *)
public extension Seeker {
    func seekEnded(_ action: @escaping (String?) -> Void) -> Seeker {
        Seeker(self._finger, seekEnd: action) {
            self.content
        }
    }
}
