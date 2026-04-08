import SwiftUI

struct ContentView: View {
    
    @State private var selectedMuscle: String? = nil
    
    // 🔥 fatigue (пример)
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
        
        "upper_abs": 20,
        "lower_abs": 10,
        "external_abdominal_obliques": 25,
        
        "quads": 40,
        "gastrocnemius": 30,
        "tibialis_anterior": 15,
        "adductors": 25,
        
        // 🔥 BACK
        "upper_lats": 80,
        "middle_lats": 70,
        "lower_lats": 60,
        
        "upper_traps": 50,
        "mid_traps": 40,
        "lower_traps": 30,
        
        "rear_delts": 60,
        "teres_major": 50,
        
        "erector_spinae": 30,
        
        "gluteus_maximus": 40,
        "hamstrings": 35,
        "lower_soleus": 25
    ]
    
    // FRONT мышцы
    let frontMuscles: [String] = [
        "upper_pecs", "middle_pecs", "lower_pecs",
        "long_head_bicep", "short_head_bicep",
        "brachialis", "brachioradialis",
        "front_delts", "side_delts",
        "upper_abs", "lower_abs", "external_abdominal_obliques",
        "quads", "gastrocnemius", "tibialis_anterior", "adductors"
    ]
    
    // BACK мышцы
    let backMuscles: [String] = [
        "upper_lats", "middle_lats", "lower_lats",
        "upper_traps", "mid_traps", "lower_traps",
        "rear_delts", "teres_major",
        "erector_spinae",
        "gluteus_maximus", "hamstrings", "lower_soleus"
    ]
    
    var body: some View {
        HStack {
            
            // 🔵 FRONT
            bodyView(
                base: "body_front_base",
                muscles: frontMuscles
            )
            
            // 🔴 BACK
            bodyView(
                base: "body_back_base",
                muscles: backMuscles
            )
        }
        .padding()
    }
}

// MARK: - BODY VIEW

extension ContentView {
    
    func bodyView(base: String, muscles: [String]) -> some View {
        ZStack {
            
            Image(base)
                .resizable()
                .scaledToFit()
            
            ForEach(muscles, id: \.self) { muscle in
                muscleView(muscle)
            }
        }
    }
    
    func muscleView(_ name: String) -> some View {
        let value = fatigue[name] ?? 0
        
        return Image(name)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundColor(color(for: value))
            .opacity(0.7)
            
            // 🔥 glow
            .overlay(
                selectedMuscle == name ?
                Image(name)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .blur(radius: 12)
                    .opacity(0.9)
                : nil
            )
            
            .contentShape(Rectangle())
            
            .onTapGesture {
                selectedMuscle = name
            }
    }
    
    func color(for fatigue: Int) -> Color {
        switch fatigue {
        case 75...100: return .red
        case 40..<75: return .yellow
        default: return .green
        }
    }
}
