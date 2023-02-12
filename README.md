# FingerSeeker

FingerSeeker is Finger-seeking SwiftUI Library

## Usage
```
struct ContentView: View {

    @State var seeker = FingerSeeker()
    
    var body: some View {
        Seeker($seeker) {
            VStack {
                Text("Current seeker is \(seeker ?? "none")")
                Circle()
                    .frame(width: 100, height: 100)
                    .finger($seeker, "Seeking 1")
                Circle()
                    .frame(width: 100, height: 100)
                    .finger($seeker, "Seeking 2")
            }
            .padding(20)
        }
    }
}

```
