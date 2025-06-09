//
//  TestSwiftUIPath.swift
//  TestSwiftUI
//
//  Created by Neil on 27/5/25.
//

import Foundation
import SwiftUI

struct TestSwiftUIPath: View {
    var body: some View {
        TestArcPath()
    }
}
//绘制矩形
struct TestRectanglePath: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 200))
            path.addLine(to: CGPoint(x: 300, y: 200))
            path.addLine(to: CGPoint(x: 300, y: 0))
            path.closeSubpath()
        }
        .stroke(Color.blue, lineWidth: 10)
    }
}
//绘制贝塞尔圆弧
struct TestBezierCurvePath: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 40))
            path.addLine(to: CGPoint(x: 15, y: 40))
            path.addQuadCurve(to: CGPoint(x: 285, y: 40), control: CGPoint(x: 150, y: 0))
            path.addLine(to: CGPoint(x: 300, y: 40))
            path.addLine(to: CGPoint(x: 300, y: 100))
            path.addLine(to: CGPoint(x: 0, y: 100))
        }
        .fill(Color.blue)
    }
}
//绘制圆
struct TestArcPath: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 200))
            path.addArc(center: CGPoint(x: 200, y: 200), radius: 100, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: true)
        }
        .fill(Color.blue)
    }
}
