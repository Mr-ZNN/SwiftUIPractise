//
//  TestSwiftUIProgress.swift
//  TestSwiftUI
//
//  Created by Neil on 5/6/25.
//

import Foundation
import SwiftUI

struct TestSwiftUIProgress: View {
    var thickness: CGFloat = 30.0
    var width: CGFloat = 250.0
    var startAngle: Double = -90.0
    @State var progress = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                //外环
                Circle()
                    .stroke(Color(.systemGray6), lineWidth: thickness)
                //内环
                RingShape(progress: self.progress, thickness: thickness)
                    .fill(AngularGradient(colors: [.gradientPink, .gradientYellow], center: .center, startAngle: .degrees(startAngle), endAngle: .degrees(360 * self.progress + startAngle)))
            }
            .frame(width: width, height: width, alignment: .center)
            .animation(Animation.easeInOut(duration: 1), value: self.progress)
            
            //进度调节
            HStack {
                Group {
                    Text("0%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            self.progress = 0.0
                        }
                    Text("50%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            self.progress = 0.5
                        }
                    Text("100%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            self.progress = 1.0
                        }
                }
                .padding()
                .background(Color(.systemGray6)).clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                .padding()
            }
            .padding()
        }
    }
}
//内环
struct RingShape: Shape {
    var progress: Double = 0.0
    var thickness: CGFloat = 30.0
    var startAngle: Double = -90.0
    
    var animatableData: Double {
        get {progress}
        set {progress = newValue}
    }
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5), radius: min(rect.width, rect.height) * 0.5, startAngle: .degrees(startAngle), endAngle: .degrees(360 * progress + startAngle), clockwise: false)
        return path.strokedPath(.init(lineWidth: thickness, lineCap: .round))
    }
}
