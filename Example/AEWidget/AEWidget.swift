//
//  AEWidget.swift
//  AEWidget
//
//  Created by Adam on 2022/11/22.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct AEWidgetEntryView : View {
    @Environment(\.openURL) private var openURL // 引入环境值
    var entry: Provider.Entry

    var body: some View {
        ZStack {
             AccessoryWidgetBackground()
             VStack {
                 Text(entry.date, style: .date)
                 Text(entry.date, style: .time)
                 Text(entry.date, style: .timer)
                 .font(.title)
                 
                 Button("NEW Widget") {
                     if let url = URL(string: "adam.hongyang://") {
                         openURL(url) { accepted in  // 通过设置 completion 闭包，可以检查是否已完成 URL 的开启。状态由 OpenURLAction 提供
                             print(accepted ? "Success" : "Failure")
                         }
                     }
                 }

            }
        }
        .padding(5)
        .foregroundColor(.purple)
    }
}

struct AEWidget: Widget {
    let kind: String = "AEWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AEWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct AEWidget_Previews: PreviewProvider {
    static var previews: some View {
        AEWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
