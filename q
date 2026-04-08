import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    // MARK: - DATA
    
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
        
        // BACK
        "upper_lats": 80,
        "middle_lats": 70,
        "lower_lats": 60,
        "upper_traps": 50,
        "mid_traps": 40,
        "lower_traps": 30,
        "teres_major": 50,
        "erector_spinae": 30
    ]
    
    // МЫШЦА → ГРУППА
    let map: [String: String] = [
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
                VStack(spacing: 4) {
                    Text("GYMES").font(.largeTitle).bold()
                    Text(date()).foregroundColor(.gray)
                    Text("Chest Day").foregroundColor(.blue)
                }
                
                HStack {
                    bodyView(base: "body_front_base", muscles: frontMuscles)
                    backView()
                }
                
                Spacer()
            }
            
            // FULLSCREEN POPUP
            if let group = selectedGroup {
                fullScreenPopup(group)
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
                muscle(m)
            }
        }
    }
    
    func muscle(_ name: String) -> some View {
        let value = fatigue[name] ?? 0
        
        return ZStack {
            
            // КОНТУР
            Image(name)
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
            
            // ЦВЕТ
            Image(name)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(color(value))
                .opacity(0.8)
        }
        .onTapGesture {
            selectedGroup = map[name]
        }
    }
}

// MARK: - BACK

extension ContentView {
    
    func backView() -> some View {
        ZStack {
            
            // 👉 ТВОЙ КОНТУР СПИНЫ
            Image("back_base")
                .resizable()
                .scaledToFit()
            
            ForEach(backMuscles, id: \.self) { m in
                Image(m)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(color(fatigue[m] ?? 0))
                    .opacity(0.8)
            }
        }
    }
}

// MARK: - FULLSCREEN POPUP

extension ContentView {
    
    func fullScreenPopup(_ group: String) -> some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
            
            VStack {
                
                Text(group.uppercased())
                    .font(.largeTitle)
                    .bold()
                
                ZStack {
                    
                    Image("body_front_base")
                        .resizable()
                        .scaledToFit()
                    
                    // 👉 ТОЛЬКО нужная группа
                    ForEach(frontMuscles, id: \.self) { m in
                        if map[m] == group {
                            Image(m)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(color(fatigue[m] ?? 0))
                        }
                    }
                }
                
                Button("Close") {
                    selectedGroup = nil
                }
                .padding()
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
