import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    // 🔥 fatigue
    let fatigue: [String: Int] = [
        "upper_pecs": 90,
        "middle_pecs": 70,
        "lower_pecs": 40,
        
        "long_head_bicep": 50,
        "short_head_bicep": 30,
        "brachialis": 20,
        "brachioradialis": 10,
        
        "front_delts": 60,
        "side_delts": 30,
        "rear_delts": 60,
        
        "upper_abs": 20,
        "lower_abs": 10,
        "external_abdominal_obliques": 25,
        
        "quads": 40,
        "gastrocnemius": 30,
        "tibialis_anterior": 15,
        "adductors": 25,
        
        "upper_lats": 80,
        "middle_lats": 70,
        "lower_lats": 60,
        "upper_traps": 50,
        "mid_traps": 40,
        "lower_traps": 30,
        "teres_major": 50,
        "erector_spinae": 30
    ]
    
    // 🔥 МЫШЦА → ГРУППА (фикс бага с shoulders)
    let muscleToGroup: [String: String] = [
        "upper_pecs": "chest",
        "middle_pecs": "chest",
        "lower_pecs": "chest",
        
        "long_head_bicep": "arms",
        "short_head_bicep": "arms",
        "brachialis": "arms",
        "brachioradialis": "arms",
        
        "front_delts": "shoulders",
        "side_delts": "shoulders",
        "rear_delts": "shoulders",
        
        "upper_abs": "core",
        "lower_abs": "core",
        "external_abdominal_obliques": "core",
        
        "quads": "legs",
        "gastrocnemius": "legs",
        "tibialis_anterior": "legs",
        "adductors": "legs",
        
        "upper_lats": "back",
        "middle_lats": "back",
        "lower_lats": "back",
        "upper_traps": "back",
        "mid_traps": "back",
        "lower_traps": "back",
        "teres_major": "back",
        "erector_spinae": "back"
    ]
    
    let frontMuscles = [
        "upper_pecs","middle_pecs","lower_pecs",
        "long_head_bicep","short_head_bicep","brachialis","brachioradialis",
        "front_delts","side_delts",
        "upper_abs","lower_abs","external_abdominal_obliques",
        "quads","gastrocnemius","tibialis_anterior","adductors"
    ]
    
    let backMuscles = [
        "upper_lats","middle_lats","lower_lats",
        "upper_traps","mid_traps","lower_traps",
        "rear_delts","teres_major","erector_spinae"
    ]
    
    var body: some View {
        ZStack {
            
            VStack {
                
                // HEADER
                VStack(spacing: 5) {
                    Text("GYMES")
                        .font(.largeTitle).bold()
                    
                    Text(formattedDate())
                        .foregroundColor(.gray)
                    
                    Text("Chest Day")
                        .foregroundColor(.blue)
                }
                
                HStack {
                    bodyView(base: "body_front_base", muscles: frontMuscles)
                    bodyView(base: "body_back_base", muscles: backMuscles)
                }
                
                Spacer()
            }
            
            if let group = selectedGroup {
                popup(group)
            }
        }
    }
}

// MARK: - BODY

extension ContentView {
    
    func bodyView(base: String, muscles: [String]) -> some View {
        ZStack {
            
            Image(base)
                .resizable()
                .scaledToFit()
            
            ForEach(muscles, id: \.self) { m in
                muscleView(m)
            }
        }
    }
    
    func muscleView(_ name: String) -> some View {
        let value = fatigue[name] ?? 0
        
        return ZStack {
            
            // 🔲 КОНТУР (фикс back)
            Image(name)
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
                .opacity(1)
            
            // 🎨 ЦВЕТ
            Image(name)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(color(for: value))
                .opacity(0.8)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedGroup = muscleToGroup[name]
        }
    }
}

// MARK: - POPUP (НОВЫЙ)

extension ContentView {
    
    func popup(_ group: String) -> some View {
        VStack {
            Spacer()
            
            ZStack {
                
                // 🔥 ЗУМ НА ОБЛАСТЬ
                Image("body_front_base")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale(for: group))
                    .offset(offset(for: group))
                
                // 🔥 мышцы
                ForEach(frontMuscles, id: \.self) { m in
                    if muscleToGroup[m] == group {
                        Image(m)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(scale(for: group))
                            .offset(offset(for: group))
                            .foregroundColor(color(for: fatigue[m] ?? 0))
                    }
                }
            }
            .frame(height: 300)
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            
            Button("Close") {
                selectedGroup = nil
            }
        }
        .background(Color.black.opacity(0.4))
    }
}

// MARK: - HELPERS

extension ContentView {
    
    func color(for f: Int) -> Color {
        switch f {
        case 75...100: return .red
        case 40..<75: return .yellow
        default: return .green
        }
    }
    
    func formattedDate() -> String {
        let f = DateFormatter()
        f.dateStyle = .full
        return f.string(from: Date())
    }
    
    // 🔥 ЗУМ ПОД ОБЛАСТЬ
    
    func scale(for group: String) -> CGFloat {
        switch group {
        case "chest": return 2.0
        case "arms": return 1.8
        case "legs": return 1.6
        case "core": return 2.0
        case "shoulders": return 2.2
        default: return 1.5
        }
    }
    
    func offset(for group: String) -> CGSize {
        switch group {
        case "chest": return CGSize(width: 0, height: -120)
        case "arms": return CGSize(width: 0, height: -80)
        case "legs": return CGSize(width: 0, height: 150)
        case "core": return CGSize(width: 0, height: 0)
        case "shoulders": return CGSize(width: 0, height: -160)
        default: return .zero
        }
    }
}
