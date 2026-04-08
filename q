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
    
    // 🔥 ГРУППЫ (FRONT)
    let groups: [String: [String]] = [
        "chest": ["upper_pecs", "middle_pecs", "lower_pecs"],
        "arms": ["long_head_bicep", "short_head_bicep", "brachialis", "brachioradialis"],
        "shoulders": ["front_delts", "side_delts", "rear_delts"],
        "core": ["upper_abs", "lower_abs", "external_abdominal_obliques"],
        "legs": ["quads", "gastrocnemius", "tibialis_anterior", "adductors"]
    ]
    
    // BACK пока как есть
    let backMuscles: [String] = [
        "upper_lats", "middle_lats", "lower_lats",
        "upper_traps", "mid_traps", "lower_traps",
        "teres_major", "erector_spinae"
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
                    
                    // FRONT (ГРУППЫ)
                    frontView()
                    
                    // BACK (ПОКА ПРОСТО МЫШЦЫ)
                    backView()
                }
                .padding()
                
                Spacer()
            }
            
            // 🔥 POPUP
            if let group = selectedGroup {
                popupView(group)
            }
        }
    }
}

// MARK: - FRONT VIEW (ГРУППЫ)

extension ContentView {
    
    func frontView() -> some View {
        ZStack {
            
            Image("body_front_base")
                .resizable()
                .scaledToFit()
            
            // 👉 каждая группа = 1 слой
            ForEach(groups.keys.sorted(), id: \.self) { group in
                groupLayer(group)
            }
        }
    }
    
    func groupLayer(_ group: String) -> some View {
        let muscles = groups[group] ?? []
        
        return ZStack {
            
            // 🔲 КОНТУР
            Image(group)
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
            
            // 🎨 ЦВЕТ (среднее по группе)
            Image(group)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(color(for: avgFatigue(muscles)))
                .opacity(0.7)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedGroup = group
        }
    }
}

// MARK: - BACK VIEW

extension ContentView {
    
    func backView() -> some View {
        ZStack {
            Image("body_back_base")
                .resizable()
                .scaledToFit()
            
            ForEach(backMuscles, id: \.self) { muscle in
                Image(muscle)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(color(for: fatigue[muscle] ?? 0))
                    .opacity(0.7)
            }
        }
    }
}

// MARK: - POPUP (С КАРТИНКОЙ)

extension ContentView {
    
    func popupView(_ group: String) -> some View {
        VStack {
            Spacer()
            
            VStack(spacing: 15) {
                
                Text(group.capitalized)
                    .font(.title)
                    .bold()
                
                ZStack {
                    
                    // 👉 используем ТВОЙ файл (chest, arms, etc)
                    Image(group)
                        .resizable()
                        .scaledToFit()
                    
                    // 👉 детальные мышцы
                    ForEach(groups[group] ?? [], id: \.self) { muscle in
                        Image(muscle)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(color(for: fatigue[muscle] ?? 0))
                            .opacity(0.9)
                    }
                }
                .frame(height: 220)
                
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
    
    func avgFatigue(_ muscles: [String]) -> Int {
        let values = muscles.compactMap { fatigue[$0] }
        guard !values.isEmpty else { return 0 }
        return values.reduce(0, +) / values.count
    }
    
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
