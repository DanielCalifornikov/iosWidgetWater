//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @State var waterAmount: Int = 0
    @State var maxVolume = 3000
    var waterIntakePercent : Int {
        Int(CGFloat(waterAmount) / CGFloat(maxVolume) * CGFloat(100))
    }
    
    var body: some View {
        ZStack {
            Image("bg").resizable().aspectRatio(contentMode: .fill)
            
            VStack {
                Text("Моя дневная норма").font(.system(size: 22, weight: .bold)).foregroundColor(.white).padding(.bottom, 60)
                
                Text(.now, style: .date).font(.title2)
                
                BottleView(waterAmount: $waterAmount, maxVolume: $maxVolume)
                
                Text("Добавить или убрать 250 мл. Воды").foregroundStyle(.gray).padding()
                
                HStack {
                    Stepper(value: $waterAmount, in: 0...maxVolume, step: 250) {
                        Text("\(waterAmount) мл").foregroundColor(.black).font(.title2)
                    }.padding().frame(width: 240)
                    
                    Image(systemName: "checkmark").imageScale(.large).onTapGesture {
                        DispatchQueue.global().async {
                            LogManager.shared.saveLog(waterAmount: waterAmount)
                            WidgetCenter.shared.reloadTimelines(ofKind: "WaterWidgets")
                            
                        }
                    }
                }
                
                Text("\(waterIntakePercent) %").font(.system(size: 22, weight: .medium))
                
                Text("\(maxVolume - waterAmount) мл. Осталось выпить за сегодня").foregroundColor(.gray)
                
                
                Text("Поздравляю! 🎉 Вы выпили достаточное количество воды за сегодня").foregroundColor(Color("AppColor")).padding().opacity(waterAmount == maxVolume ? 1.0 : 0)
                
            }.foregroundColor(.blue)
                .onAppear() {
                    fetchLatestLog()
                }.onReceive(NotificationCenter.default.publisher(for: .widgetChangedData), perform: { _ in
                    fetchLatestLog()
                })
        }.edgesIgnoringSafeArea(.all)
    }
    
    func fetchLatestLog() {
        DispatchQueue.global().async {
            if let latestLog = LogManager.shared.getLatestLog() {
                DispatchQueue.main.async {
                    waterAmount = Int(latestLog.amount)
                }
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}

