//

import SwiftUI

struct WaterWidgetsEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var maxVolume = 3000
    
    var entryPercent: Int {
        Int(CGFloat(entry.amount) / CGFloat(maxVolume) * CGFloat(100))
    }

    var hoursFromNow: Int {
        let oneDayAhead = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
        let startOfNextDay = Calendar.current.startOfDay(for: oneDayAhead)
        let diffComponents = Calendar.current.dateComponents([.hour], from: entry.date, to: startOfNextDay)
        return diffComponents.hour ?? 0
    }
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
        VStack {
            Text("Вода сегодня")
            HStack {
                BottleView(waterAmount: .constant(entry.amount), maxVolume: .constant(maxVolume), bottleType: .small)
                
                VStack{
                    Text("\(entryPercent)%")
                    Text("Часов: \(hoursFromNow)").font(.system(size: 12))
                }
            }
        }.foregroundColor(Color("AppColor"))
            
        default:
            VStack {
                Text("Ваш уровень воды сегодня")
                HStack(alignment: .center, spacing: 15) {
                    Spacer()
                    BottleView(waterAmount: .constant(entry.amount), maxVolume: .constant(maxVolume), bottleType: .small)
                    
                    VStack{
                        Text("\(entryPercent)%").font(.title2)
                        Text("Часов осталось: \(hoursFromNow)").font(.system(size: 12))
                    }
                    
                    if #available(iOS 17.0, *) {
                        Button(intent: LogWaterIntent()) {
                            Image(systemName: entry.amount == maxVolume ? "checkmark.circle.fill" : "plus.circle.fill").resizable().frame(width: 30, height: 30)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                }
            }.foregroundColor(Color("AppColor"))
    }
    }
}
