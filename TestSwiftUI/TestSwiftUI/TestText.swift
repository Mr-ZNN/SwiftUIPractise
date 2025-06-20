//
//  TestText.swift
//  TestSwiftUI
//
//  Created by Neil on 19/6/25.
//

import SwiftUI

struct TestText: View {
    var body: some View {
        Text("Hello, world!ceewvwervewrvewrvewrvervrevevwevrwevrwvewvrewvrewv")
         .fontWeight(.bold)//字重
         .fontWidth(.expanded)//字宽
         .font(.system(size: 17))//字体
         .foregroundColor(.red)//文字颜色
         .padding(0)//边距
         .shadow(color: .black, radius: 10, x: 10, y: 10)//阴影
         .background(Color.cyan)//背景色
         .multilineTextAlignment(.center)//对齐方式
         .lineSpacing(10)//行间距
         .truncationMode(.middle)//文字截断方式
         .frame(width: 200, height: 100)
         .border(Color.blue, width: 2)//边框
         .blur(radius: 2)//模糊
         .rotationEffect(.degrees(45), anchor: UnitPoint(x: 0, y: 0))//2D旋转，以(0,0)为中心旋转45度
         .rotation3DEffect(.degrees(45), axis: (x: 1, y: 0, z: 0))//3D旋转，以(1,0,0)为中心旋转45度

    }
}
