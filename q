import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    let fatigue: [String: Int] = [
        "upper_pecs": 90, "middle_pecs": 70, "lower_pecs": 40,
        "front_delts": 60, "side_delts": 30,
        "upper_abs": 20, "lower_abs": 10,
        "quads": 80, "gastrocnemius": 30,
        "upper_lats": 70, "middle_lats": 60
    ]
    
    let frontMuscles = [
        "upper_pecs","middle_pecs","lower_pecs",
        "front_delts","side_delts",
        "upper_abs","lower_abs",
        "quads","gastrocnemius"
    ]
    
    let backMuscles = [
        "upper_lats","middle_lats"
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
                
                HStack(spacing: 40) { // 👈 расстояние между front/back
                    
                    // 🔥 FRONT
                    ZStack {
                        
                        Image("body_front_base")
                            .resizable()
                            .scaledToFit()
                            .allowsHitTesting(false) // 🔥 КЛЮЧ
                        
                        ForEach(frontMuscles, id: \.self) { m in
                            Image(m)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(color(fatigue[m] ?? 20))
                                .opacity(0.85)
                                .allowsHitTesting(false) // 🔥 КЛЮЧ
                        }
                        
                        // 🔥 HITBOX (ТЕПЕРЬ РАБОТАЮТ)
                        
                        // CHEST
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 120, height: 80)
                            .offset(x: 0, y: -120)
                            .onTapGesture {
                                print("CHEST")
                                selectedGroup = "chest"
                            }
                        
                        // SHOULDERS
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 180, height: 60)
                            .offset(x: 0, y: -180)
                            .onTapGesture {
                                print("SHOULDERS")
                                selectedGroup = "shoulders"
                            }
                        
                        // CORE
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 100, height: 100)
                            .offset(x: 0, y: -20)
                            .onTapGesture {
                                print("CORE")
                                selectedGroup = "core"
                            }
                        
                        // LEGS
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 150, height: 200)
                            .offset(x: 0, y: 150)
                            .onTapGesture {
                                print("LEGS")
                                selectedGroup = "legs"
                            }
                    }
                    .frame(width: 220, height: 500)
                    .padding(.leading, 20) // 👈 ОТСТУП СЛЕВА
                    
                    // 🔥 BACK
                    ZStack {
                        Image("back_base")
                            .resizable()
                            .scaledToFit()
                            .allowsHitTesting(false) // 🔥 КЛЮЧ
                        
                        ForEach(backMuscles, id: \.self) { m in
                            Image(m)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(color(fatigue[m] ?? 20))
                                .opacity(0.85)
                                .allowsHitTesting(false) // 🔥 КЛЮЧ
                        }
                    }
                    .frame(width: 220, height: 500)
                }
                
                Spacer()
            }
            
            // 🔥 POPUP (ТЕПЕРЬ ТОЧНО РАБОТАЕТ)
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
