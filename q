import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    var body: some View {
        ZStack {
            
            VStack {
                
                Text("GYMES")
                    .font(.largeTitle)
                    .bold()
                
                ZStack {
                    
                    Image("body_front_base")
                        .resizable()
                        .scaledToFit()
                    
                    // 🔥 ВИЗУАЛ (как раньше)
                    Image("upper_pecs").resizable().scaledToFit().foregroundColor(.red)
                    Image("quads").resizable().scaledToFit().foregroundColor(.yellow)
                    
                    // 🔥 ТОЧНЫЕ HITBOX
                    AlphaHitView(imageName: "chest") {
                        selectedGroup = "chest"
                    }
                    
                    AlphaHitView(imageName: "arms") {
                        selectedGroup = "arms"
                    }
                    
                    AlphaHitView(imageName: "legs") {
                        selectedGroup = "legs"
                    }
                    
                    AlphaHitView(imageName: "core") {
                        selectedGroup = "core"
                    }
                }
                
                Spacer()
            }
            
            if let group = selectedGroup {
                popup(group)
            }
        }
    }
    
    func popup(_ group: String) -> some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                Text(group.uppercased())
                    .font(.largeTitle)
                
                Button("Close") {
                    selectedGroup = nil
                }
            }
        }
    }
}
