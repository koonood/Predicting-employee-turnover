import SwiftUI

struct ContentView: View {
    
    @State private var selectedMuscle: String? = nil
    
    // 🔥 ТЕСТ ДАННЫЕ (как ты хотел)
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
        "adductors": 25
    ]
    
    // 🔥 ВСЕ МЫШЦЫ (твои ассеты)
    let muscles: [String] = [
        "upper_pecs", "middle_pecs", "lower_pecs",
        "long_head_bicep", "short_head_bicep",
        "brachialis", "brachioradialis",
        "front_delts", "side_delts",
        "upper_abs", "lower_abs", "external_abdominal_obliques",
        "quads", "gastrocnemius", "tibialis_anterior", "adductors"
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                // BASE
                Image("body_front_base")
                    .resizable()
                    .scaledToFit()
                
                // 🔥 ВСЕ МЫШЦЫ
                ForEach(muscles, id: \.self) { muscle in
                    muscleView(muscle)
                }
            }
        }
    }
}

// MARK: - Muscle View

extension ContentView {
    
    func muscleView(_ name: String) -> some View {
        let value = fatigue[name] ?? 0
        
        return Image(name)
            .resizable()
            .scaledToFit()
            .foregroundColor(color(for: value))
            .opacity(0.7)
            
            // 🔥 GLOW
            .overlay(
                selectedMuscle == name ?
                Image(name)
                    .resizable()
                    .scaledToFit()
                    .blur(radius: 10)
                    .foregroundColor(.white)
                    .opacity(0.9)
                : nil
            )
            
            // 👆 TAP
            .onTapGesture {
                selectedMuscle = name
            }
    }
    
    // 🎨 ЦВЕТ НАГРУЗКИ
    func color(for fatigue: Int) -> Color {
        switch fatigue {
        case 75...100: return .red
        case 40..<75: return .yellow
        default: return .green
        }
    }
}
