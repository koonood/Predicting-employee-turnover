import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    // 🔥 FATIGUE
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
        
        // BACK
        "upper_lats": 80,
        "middle_lats": 70,
        "lower_lats": 60,
        "upper_traps": 50,
        "mid_traps": 40,
        "lower_traps": 30,
        "rear_delts": 60,
        "teres_major": 50,
        "erector_spinae": 30
    ]
    
    // 🔥 ГРУППЫ → МЫШЦЫ
    let groups: [String: [String]] = [
        "Chest": ["upper_pecs", "middle_pecs", "lower_pecs"],
        "Arms": ["long_head_bicep", "short_head_bicep", "brachialis", "brachioradialis"],
        "Shoulders": ["front_delts", "side_delts", "rear_delts"],
        "Core": ["upper_abs", "lower_abs", "external_abdominal_obliques"],
        "Legs": ["quads", "gastrocnemius", "tibialis_anterior", "adductors"],
        "Back": ["upper_lats", "middle_lats", "lower_lats", "upper_traps", "mid_traps", "lower_traps", "teres_major", "erector_spinae"]
    ]
    
    var body: some View {
        ZStack {
            
            VStack {
                
                // 🔥 HEADER
                VStack(spacing: 5) {
                    Text("GYMES")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(formattedDate())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Chest Day")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .padding(.top)
                
                // 🔥 BODY
                HStack {
                    bodyView(base: "body_front_base", muscles: allFront())
                    bodyView(base: "body_back_base", muscles: allBack())
                }
                
                Spacer()
            }
            
            // 🔥 POPUP
            if let group = selectedGroup {
                popupView(group)
            }
        }
    }
}

// MARK: - BODY

extension ContentView {
    
    func allFront() -> [String] {
        groups.filter { $0.key != "Back" }.flatMap { $0.value }
    }
    
    func allBack() -> [String] {
        groups["Back"] ?? []
    }
    
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
            
            .onTapGesture {
                selectedGroup = findGroup(for: name)
            }
    }
    
    func findGroup(for muscle: String) -> String {
        for (group, muscles) in groups {
            if muscles.contains(muscle) {
                return group
            }
        }
        return ""
    }
}

// MARK: - POPUP

extension ContentView {
    
    func popupView(_ group: String) -> some View {
        VStack {
            Spacer()
            
            VStack(spacing: 15) {
                
                Text(group)
                    .font(.title)
                    .fontWeight(.bold)
                
                // мышцы внутри
                ForEach(groups[group] ?? [], id: \.self) { muscle in
                    HStack {
                        Text(muscle)
                        Spacer()
                        Circle()
                            .fill(color(for: fatigue[muscle] ?? 0))
                            .frame(width: 15, height: 15)
                    }
                }
                
                Button("Close") {
                    selectedGroup = nil
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding()
        }
        .background(Color.black.opacity(0.4))
    }
}

// MARK: - HELPERS

extension ContentView {
    
    func color(for fatigue: Int) -> Color {
        switch fatigue {
        case 75...100: return .red
        case 40..<75: return .yellow
        default: return .green
        }
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date())
    }
}
