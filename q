import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    let fatigue: [String: Int] = [
        "upper_pecs": 90, "middle_pecs": 70, "lower_pecs": 40,
        "front_delts": 60, "side_delts": 30,
        "upper_abs": 20, "lower_abs": 10,
        "quads": 80, "gastrocnemius": 30
    ]
    
    let frontMuscles = [
        "upper_pecs","middle_pecs","lower_pecs",
        "front_delts","side_delts",
        "upper_abs","lower_abs",
        "quads","gastrocnemius"
    ]
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 10) {
                
                // HEADER
                VStack(spacing: 4) {
                    Text("GYMES")
                        .font(.largeTitle).bold()
                    
                    Text(date())
                        .foregroundColor(.gray)
                    
                    Text("Chest Day")
                        .foregroundColor(.blue)
                }
                
                // 🔥 MAIN AREA
                ZStack {
                    
                    // 🔥 ВИЗУАЛ (НЕ ТРОГАЕТ КЛИКИ)
                    visualLayer
                        .allowsHitTesting(false)
                    
                    // 🔥 КЛИКИ (ОТДЕЛЬНЫЙ СЛОЙ)
                    hitboxLayer
                }
                .frame(width: 300, height: 600)
                .offset(x: 60) // 👈 СДВИНУЛ ВПРАВО КАК ТЫ ХОТЕЛ
                
                Spacer()
            }
            
            // 🔥 POPUP (100% работает)
            if let group = selectedGroup {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
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

// MARK: - VISUAL

extension ContentView {
    
    var visualLayer: some View {
        ZStack {
            
            Image("body_front_base")
                .resizable()
                .scaledToFit()
            
            ForEach(frontMuscles, id: \.self) { m in
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

// MARK: - HITBOXES (ЖЁСТКО РАБОТАЮТ)

extension ContentView {
    
    var hitboxLayer: some View {
        ZStack {
            
            // 🔴 CHEST
            Button(action: {
                print("CHEST")
                selectedGroup = "chest"
            }) {
                Rectangle()
                    .fill(Color.red.opacity(0.2)) // 👈 ВИДНО ДЛЯ ТЕСТА
                    .frame(width: 140, height: 90)
                    .offset(x: 0, y: -150)
            }
            
            // 🔵 SHOULDERS
            Button(action: {
                print("SHOULDERS")
                selectedGroup = "shoulders"
            }) {
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 200, height: 60)
                    .offset(x: 0, y: -220)
            }
            
            // 🟡 CORE
            Button(action: {
                print("CORE")
                selectedGroup = "core"
            }) {
                Rectangle()
                    .fill(Color.yellow.opacity(0.2))
                    .frame(width: 100, height: 120)
                    .offset(x: 0, y: -20)
            }
            
            // 🟣 LEGS
            Button(action: {
                print("LEGS")
                selectedGroup = "legs"
            }) {
                Rectangle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 160, height: 250)
                    .offset(x: 0, y: 180)
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
