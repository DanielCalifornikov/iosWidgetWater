
import WidgetKit
import SwiftUI


struct WaterEntry: TimelineEntry {
    var date: Date
    let amount: Int
}

struct WaterWidgets: Widget {
    let kind: String = "WaterWidgets"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WaterWidgetsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WaterWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Water Widget")
        .description("Моя дневная норма воды")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    WaterWidgets()
} timeline: {
    WaterEntry(date: .now, amount: 500)
    WaterEntry(date: .now, amount: 500)
}
