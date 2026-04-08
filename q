import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    // MARK: DATA
    
    let fatigue: [String: Int] = [
        "upper_pecs": 90, "middle_pecs": 70, "lower_pecs": 40,
        "front_delts": 60, "side_delts": 30, "rear_delts": 50,
        "upper_abs": 20, "lower_abs": 10,
        "quads": 80, "gastrocnemius": 30,
        "upper_lats": 70, "middle_lats": 60, "lower_lats": 40
    ]
    
    let frontMuscles = [
        "upper_pecs","middle_pecs","lower_pecs",
        "front_delts","side_delts",
        "upper_abs","lower_abs",
        "quads","gastrocnemius"
    ]
    
    let backMuscles = [
        "upper_lats","middle_lats","lower_lats",
        "rear_delts"
    ]
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 10) {
                
                // 🔥 HEADER
                VStack(spacing: 4) {
                    Text("GYMES")
                        .font(.largeTitle).bold()
                    
                    Text(date())
                        .foregroundColor(.gray)
                    
                    Text("Chest Day")
                        .foregroundColor(.blue)
                }
                
                // 🔥 BODY
                HStack {
                    
                    // FRONT
                    ZStack {
                        Image("body_front_base")
                            .resizable()
                            .scaledToFit()
                        
                        // цвета мышц
                        ForEach(frontMuscles, id: \.self) { m in
                            Image(m)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(color(fatigue[m] ?? 20))
                                .opacity(0.85)
                        }
                        
                        // 🔥 ЧЕТКИЕ HITBOX
                        frontHitboxes()
                    }
                    
                    // BACK
                    ZStack {
                        Image("back_base")
                            .resizable()
                            .scaledToFit()
                        
                        ForEach(backMuscles, id: \.self) { m in
                            Image(m)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(color(fatigue[m] ?? 20))
                                .opacity(0.85)
                        }
                    }
                }
                .frame(height: 500) // 👈 фиксируем размер (ВАЖНО)
                
                Spacer()
            }
            
            // 🔥 POPUP (ТОЧНО РАБОТАЕТ)
            if let group = selectedGroup {
                ZStack {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Text(group.uppercased())
                            .font(.largeTitle)
                            .bold()
                        
                        Button("Close") {
                            selectedGroup = nil
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                }
            }
        }
    }
}

// MARK: - HITBOXES

extension ContentView {
    
    func frontHitboxes() -> some View {
        ZStack {
            
            // 🔴 CHEST (разбит)
            Group {
                box(0.5, 0.28, 0.30, 0.12, "chest")
                box(0.5, 0.34, 0.28, 0.10, "chest")
            }
            
            // 🔵 SHOULDERS
            Group {
                box(0.5, 0.20, 0.45, 0.10, "shoulders")
            }
            
            // 🟢 ARMS (2 зоны)
            Group {
                box(0.20, 0.40, 0.18, 0.30, "arms")
                box(0.80, 0.40, 0.18, 0.30, "arms")
            }
            
            // 🟡 CORE
            Group {
                box(0.5, 0.48, 0.22, 0.20, "core")
            }
            
            // 🟣 LEGS (2 зоны)
            Group {
                box(0.5, 0.70, 0.30, 0.25, "legs")
                box(0.5, 0.88, 0.30, 0.20, "legs")
            }
        }
    }
    
    // универсальный хитбокс
    func box(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ group: String) -> some View {
        GeometryReader { geo in
            Rectangle()
                .fill(Color.clear)
                .frame(width: geo.size.width * w, height: geo.size.height * h)
                .position(x: geo.size.width * x, y: geo.size.height * y)
                .onTapGesture {
                    print("Tapped:", group)
                    selectedGroup = group
                }
        }
    }
}

// MARK: - HELPERS

extension ContentView {
    
    func color(_ f: Int) -> Color {
        switch f {
        case 75...100: return .red
        case 40..<75: return .yellow
        default: return .green
        }
    }
    
    func date() -> String {
        let f = DateFormatter()
        f.dateStyle = .full
        return f.string(from: Date())
    }
}
