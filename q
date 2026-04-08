import SwiftUI

struct ContentView: View {
    
    @State private var selectedGroup: String? = nil
    
    // MARK: DATA
    
    let fatigue: [String: Int] = [
        "upper_pecs": 90, "middle_pecs": 70, "lower_pecs": 40,
        "long_head_bicep": 50, "short_head_bicep": 30, "brachialis": 20, "brachioradialis": 10,
        "front_delts": 60, "side_delts": 30, "rear_delts": 60,
        "upper_abs": 20, "lower_abs": 10, "external_abdominal_obliques": 25,
        "quads": 40, "gastrocnemius": 30, "tibialis_anterior": 15, "adductors": 25,
        "upper_lats": 80, "middle_lats": 70, "lower_lats": 60,
        "upper_traps": 50, "mid_traps": 40, "lower_traps": 30,
        "teres_major": 50, "erector_spinae": 30
    ]
    
    let map: [String: String] = [
        "upper_pecs": "chest","middle_pecs": "chest","lower_pecs": "chest",
        "long_head_bicep": "arms","short_head_bicep": "arms","brachialis": "arms","brachioradialis": "arms",
        "front_delts": "shoulders","side_delts": "shoulders","rear_delts": "shoulders",
        "upper_abs": "core","lower_abs": "core","external_abdominal_obliques": "core",
        "quads": "legs","gastrocnemius": "legs","tibialis_anterior": "legs","adductors": "legs",
        "upper_lats": "back","middle_lats": "back","lower_lats": "back",
        "upper_traps": "back","mid_traps": "back","lower_traps": "back",
        "teres_major": "back","erector_spinae": "back"
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
                
                VStack(spacing: 4) {
                    Text("GYMES").font(.largeTitle).bold()
                    Text(date()).foregroundColor(.gray)
                    Text("Chest Day").foregroundColor(.blue)
                }
                
                HStack {
                    frontView()
                    backView()
                }
                
                Spacer()
            }
            
            if let group = selectedGroup {
                popup(group)
            }
        }
    }
}

// MARK: FRONT

extension ContentView {
    
    func frontView() -> some View {
        ZStack {
            Image("body_front_base")
                .resizable()
                .scaledToFit()
            
            ForEach(frontMuscles, id: \.self) { m in
                muscle(m)
            }
        }
    }
    
    func muscle(_ name: String) -> some View {
        let value = fatigue[name] ?? 0
        
        return ZStack {
            
            Image(name)
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
            
            Image(name)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(color(value))
                .opacity(0.85)
        }
        // 🔥 ВАЖНО: кликаем по форме PNG
        .contentShape(Image(name))
        .onTapGesture {
            selectedGroup = map[name]
        }
    }
}

// MARK: BACK

extension ContentView {
    
    func backView() -> some View {
        ZStack {
            Image("back_base")
                .resizable()
                .scaledToFit()
            
            ForEach(backMuscles, id: \.self) { m in
                Image(m)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(color(fatigue[m] ?? 0))
                    .opacity(0.85)
            }
        }
    }
}

// MARK: POPUP

extension ContentView {
    
    func popup(_ group: String) -> some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
            
            VStack {
                
                Text(group.uppercased())
                    .font(.largeTitle)
                    .bold()
                
                GeometryReader { geo in
                    
                    ZStack {
                        
                        Image("body_front_base")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                        
                        ForEach(frontMuscles, id: \.self) { m in
                            if map[m] == group {
                                Image(m)
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width)
                                    .foregroundColor(color(fatigue[m] ?? 0))
                            }
                        }
                    }
                    // 🔥 ЗУМ В ЗАВИСИМОСТИ ОТ ГРУППЫ
                    .scaleEffect(zoom(group))
                    .offset(offset(group, geo.size))
                }
                
                Button("Close") {
                    selectedGroup = nil
                }
                .padding()
            }
        }
    }
}

// MARK: HELPERS

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
    
    // 🔥 ЗУМ И СМЕЩЕНИЕ (подогнать можно потом)
    
    func zoom(_ group: String) -> CGFloat {
        switch group {
        case "chest": return 2.2
        case "arms": return 2.0
        case "legs": return 1.8
        case "core": return 2.0
        case "shoulders": return 2.3
        default: return 1.5
        }
    }
    
    func offset(_ group: String, _ size: CGSize) -> CGSize {
        switch group {
        case "chest": return CGSize(width: 0, height: -size.height * 0.25)
        case "arms": return CGSize(width: 0, height: -size.height * 0.15)
        case "legs": return CGSize(width: 0, height: size.height * 0.35)
        case "core": return CGSize(width: 0, height: 0)
        case "shoulders": return CGSize(width: 0, height: -size.height * 0.35)
        default: return .zero
        }
    }
}
