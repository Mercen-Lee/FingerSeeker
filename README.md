# FingerSeeker
![FingerSeeker](https://user-images.githubusercontent.com/98750438/219871957-cbfed5f6-9406-4e9f-8103-dd55b9d096b7.svg)
FingerSeeker is Finger-seeking SwiftUI Library

## Usage
```swift
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
