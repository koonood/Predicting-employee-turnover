import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    var body: some View {
        ZStack {
            
            VStack {
                
                Text("GYMES")
                    .font(.largeTitle)
                    .bold()
                
                GeometryReader { geo in
                    
                    let w = geo.size.width
                    let h = geo.size.height
                    
                    ZStack {
                        
                        // 🔥 ТВОЯ БАЗА
                        Image("body_front_base")
                            .resizable()
                            .scaledToFit()
                        
                        // 🔥 HITBOXES (ПОДОГНАНЫ)
                        
                        // 🟥 CHEST
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: w * 0.32, height: h * 0.16)
                            .position(x: w * 0.5, y: h * 0.30)
                            .onTapGesture { selectedGroup = "chest" }
                        
                        // 🟦 SHOULDERS
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: w * 0.50, height: h * 0.12)
                            .position(x: w * 0.5, y: h * 0.20)
                            .onTapGesture { selectedGroup = "shoulders" }
                        
                        // 🟩 ARMS (левая+правая)
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: w * 0.75, height: h * 0.35)
                            .position(x: w * 0.5, y: h * 0.40)
                            .onTapGesture { selectedGroup = "arms" }
                        
                        // 🟨 CORE
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: w * 0.25, height: h * 0.22)
                            .position(x: w * 0.5, y: h * 0.48)
                            .onTapGesture { selectedGroup = "core" }
                        
                        // 🟪 LEGS
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: w * 0.40, height: h * 0.40)
                            .position(x: w * 0.5, y: h * 0.75)
                            .onTapGesture { selectedGroup = "legs" }
                    }
                }
                
                Spacer()
            }
            
            if let group = selectedGroup {
                popup(group)
            }
        }
    }
}

// MARK: - POPUP

extension ContentView {
    
    func popup(_ group: String) -> some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                Text(group.uppercased())
                    .font(.largeTitle)
                    .bold()
                
                Image("body_front_base")
                    .resizable()
                    .scaledToFit()
                
                Button("Close") {
                    selectedGroup = nil
                }
                .padding()
            }
        }
    }
}
