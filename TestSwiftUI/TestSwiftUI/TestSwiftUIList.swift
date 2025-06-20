//
//  TestSwiftUIList.swift
//  TestSwiftUI
//
//  Created by Neil on 28/5/25.
//

import Foundation
import SwiftUI

struct TestSwiftUIList: View {
    var body: some View {
        TextAndImageList()
    }
}
//简单文字列表
struct TextList: View {
    var body: some View {
        VStack {
            //简单的列表
            List {
                ForEach(1...4, id: \.self) { index in
                    Text("第\(index)页")
                }
            }
            //更简单的遍历方法
            List {
                ForEach(1...4, id: \.self) {
                    Text("第\($0)页")
                }
            }
        }
    }
}
//图文列表
struct TextAndImageList: View {
    var body: some View {
        let myMessages: [Message] = [
            Message(image: "icon_weixin_circle", name: "这是微信"),
            Message(image: "icon_weibo_circle", name: "这是微博"),
            Message(image: "icon_qq_circle", name: "这是QQ"),
            Message(image: "icon_phone_circle", name: "这是电话"),
            Message(image: "icon_email_circle", name: "这是邮箱")
        ]
        
        List {
            ForEach(myMessages, id: \.id) { message in
                HStack {
                    Image(message.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Text(message.name)
                        .fontWeight(.bold)
                        .font(.system(size: 15))
                        .foregroundStyle(.black)
                }
            }
            //如果Message遵循了Identifiable协议，就不用绑定id
            ForEach(myMessages) { message in
                
            }
        }
    }
}
struct Message: Identifiable {
    var id = UUID()
    var image: String
    var name: String
}
