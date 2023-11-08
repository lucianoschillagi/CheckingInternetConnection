import SwiftUI
import Network

/// Network Monitor
@Observable
class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "NetworkMonitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}

/// View
struct ContentView: View {
    @State private var networkMonitor = NetworkMonitor()
    var body: some View {
        ZStack {
            Color.white.opacity(0.3)
                .ignoresSafeArea()
            if networkMonitor.isConnected {
                Text("The app is online!").foregroundColor(.green)
            } else {
                Text("The app is offline :(").foregroundColor(.red)
            }
        }.font(.largeTitle).bold()
    }
}

#Preview {
    ContentView()
}

