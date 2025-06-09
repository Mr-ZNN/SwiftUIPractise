//
//  TestNavigationView.swift
//  TestSwiftUI
//
//  Created by Neil on 28/5/25.
//

import Foundation
import SwiftUI

struct TestNavigationView: View {
    var body: some View {
        let myMessages: [Message] = [
            Message(image: "icon_weixin_circle", name: "这是微信"),
            Message(image: "icon_weibo_circle", name: "这是微博"),
            Message(image: "icon_qq_circle", name: "这是QQ"),
            Message(image: "icon_phone_circle", name: "这是电话"),
            Message(image: "icon_email_circle", name: "这是邮箱")
        ]
        //导航栏
        NavigationView {
            List {
                ForEach(myMessages) { message in
                    NavigationLink(destination: TestNavigationDetailView(message: message)) {
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
                }
            }
            .navigationTitle("我是标题") //导航栏标题
            .navigationBarTitleDisplayMode(.inline) //导航栏标题显示模式
        }
    }
}

struct TestNavigationDetailView: View {
    var message: Message
    //内置环境值
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack {
            Image(message.image)
                .resizable()
                .frame(width: 80, height: 80)
            Text(message.name)
                .font(.system(size: 18))
                .foregroundStyle(.black)
        }
        .navigationBarBackButtonHidden() //隐藏系统返回按钮
        .navigationBarItems(leading: Button(action: {
            //返回上级页面
            self.mode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.gray)
        }))
    }
}
