//
//  SwiftUIView.swift
//
// Reference - https://gist.github.com/Koshimizu-Takehito/d3b2c4d78a77870c8d6f5a19ef3084d1
//

import SwiftUI

struct RainbowColor {
    let colors: [Color]

    init(hue: Double = 0, count: Int) {
        colors = (0 ..< count).map { i in
            var value = hue + Double(i) / Double(count)
            value -= floor(value)
            return Color(hue: value, saturation: 1 / 4, brightness: 1)
        }
    }
}

struct ContentView: View {
    let date = Date()

    @State private var isAnimation = true


    var body: some View {
        TimelineView(.animation) { context in
            let time = context.date.timeIntervalSince(date)
            
            Image(systemName: "apple.logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(
                    LinearGradient(
                        colors: RainbowColor(hue: time / 5, count: 250).colors.reversed(),
                        startPoint: .topTrailing,
                        endPoint: .bottom
                    )
                )
                .scaleEffect(isAnimation ? 1 : 1.1)
        }
        .padding(40)
        .onAppear {
            withAnimation(.spring(duration: 1.5).repeatForever(autoreverses: true)){
                isAnimation = false
            }
        }
    }
}

#Preview {
    Group {
        ContentView()
    }
}
