import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    // 🔥 FATIGUE (для цвета)
    let fatigue: [String: Int] = [
        "upper_pecs": 90,
        "middle_pecs": 70,
        "lower_pecs": 40,
        
        "front_delts": 60,
        "side_delts": 30,
        "rear_delts": 50,
        
        "upper_abs": 20,
        "lower_abs": 10,
        
        "quads": 80,
        "gastrocnemius": 30,
        
        "upper_lats": 70,
        "middle_lats": 60,
        "lower_lats": 40
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
            
            VStack {
                
                // HEADER
                VStack {
                    Text("GYMES")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Test Mode")
                        .foregroundColor(.blue)
                }
                
                GeometryReader { geo in
                    
                    let w = geo.size.width
                    let h = geo.size.height
                    
                    HStack {
                        
                        // 🔥 FRONT
                        ZStack {
                            Image("body_front_base")
                                .resizable()
                                .scaledToFit()
                            
                            // 👉 ЦВЕТА ВЕРНУЛИ
                            ForEach(frontMuscles, id: \.self) { m in
                                Image(m)
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(color(fatigue[m] ?? 20))
                                    .opacity(0.85)
                            }
                            
                            // 👉 ХИТБОКСЫ
                            frontHitboxes(w: w/2, h: h)
                        }
                        
                        // 🔥 BACK
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
                }
                
                Spacer()
            }
            
            // 🔥 POPUP (ТЕПЕРЬ ВСЕГДА ВИДЕН)
            if let group = selectedGroup {
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    VStack {
                        Text("SELECTED:")
                            .font(.headline)
                        
                        Text(group.uppercased())
                            .font(.largeTitle)
                            .bold()
                        
                        Button("Close") {
                            selectedGroup = nil
                        }
                        .padding()
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
    
    func frontHitboxes(w: CGFloat, h: CGFloat) -> some View {
        ZStack {
            
            // 🟥 CHEST
            Rectangle()
                .fill(Color.clear)
                .frame(width: w * 0.4, height: h * 0.18)
                .position(x: w * 0.5, y: h * 0.30)
                .onTapGesture {
                    print("CHEST TAP")
                    selectedGroup = "chest"
                }
            
            // 🟦 SHOULDERS
            Rectangle()
                .fill(Color.clear)
                .frame(width: w * 0.5, height: h * 0.12)
                .position(x: w * 0.5, y: h * 0.20)
                .onTapGesture {
                    print("SHOULDERS TAP")
                    selectedGroup = "shoulders"
                }
            
            // 🟨 CORE
            Rectangle()
                .fill(Color.clear)
                .frame(width: w * 0.25, height: h * 0.22)
                .position(x: w * 0.5, y: h * 0.45)
                .onTapGesture {
                    print("CORE TAP")
                    selectedGroup = "core"
                }
            
            // 🟪 LEGS
            Rectangle()
                .fill(Color.clear)
                .frame(width: w * 0.4, height: h * 0.4)
                .position(x: w * 0.5, y: h * 0.75)
                .onTapGesture {
                    print("LEGS TAP")
                    selectedGroup = "legs"
                }
        }
    }
}

// MARK: - COLOR

extension ContentView {
    
    func color(_ f: Int) -> Color {
        switch f {
        case 75...100: return .red
        case 40..<75: return .yellow
        default: return .green
        }
    }
}
