//
//  TestSwiftUIList2.swift
//  TestSwiftUI
//
//  Created by Neil on 30/5/25.
//

import Foundation
import SwiftUI

struct TestSwiftUIList2: View {
    var body: some View {
        TestSwiftUIListActionSheet()
    }
}

//删除
struct TestSwiftUIListRemove: View {
    @State var myMessages: [Message] = [
        Message(image: "icon_weixin_circle", name: "这是微信"),
        Message(image: "icon_weibo_circle", name: "这是微博"),
        Message(image: "icon_qq_circle", name: "这是QQ"),
        Message(image: "icon_phone_circle", name: "这是电话"),
        Message(image: "icon_email_circle", name: "这是邮箱")
    ]
    
    var body: some View {
        List {
            ForEach(myMessages) { message in
                HStack {
                    Image(message.image)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text(message.name)
                        .padding()
                }
            }.onDelete { index in
                myMessages.remove(atOffsets: index)
            }
        }
    }
}
//编辑按钮删除和排序
struct TestSwiftUIListRemove2: View {
    @State var myMessages: [Message] = [
        Message(image: "icon_weixin_circle", name: "这是微信"),
        Message(image: "icon_weibo_circle", name: "这是微博"),
        Message(image: "icon_qq_circle", name: "这是QQ"),
        Message(image: "icon_phone_circle", name: "这是电话"),
        Message(image: "icon_email_circle", name: "这是邮箱")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(myMessages) { message in
                    HStack {
                        Image(message.image)
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text(message.name)
                            .padding()
                    }
                }.onDelete { index in
                    //删除
                    myMessages.remove(atOffsets: index)
                }.onMove { source, destination in
                    //拖拽排序
                    myMessages.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationTitle("测试")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: EditButton())
        }
    }
}
//ContentMenu
struct TestSwiftUIListContentMenu: View {
    @State var myMessages: [Message] = [
        Message(image: "icon_weixin_circle", name: "这是微信"),
        Message(image: "icon_weibo_circle", name: "这是微博"),
        Message(image: "icon_qq_circle", name: "这是QQ"),
        Message(image: "icon_phone_circle", name: "这是电话"),
        Message(image: "icon_email_circle", name: "这是邮箱")
    ]
    
    var body: some View {
        List {
            ForEach(myMessages) { message in
                HStack {
                    Image(message.image)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text(message.name)
                        .padding()
                }.contextMenu {
                    Button {
                        //点击删除
                        self.delete(item: message)
                    } label: {
                        HStack {
                            Text("删除")
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
    }
    
    func delete(item: Message) {
        if let deleteIndex: Int = self.myMessages.firstIndex(where: {$0.id == item.id}) {
            self.myMessages.remove(at: deleteIndex)
        }
    }
}

//ActionSheet
struct TestSwiftUIListActionSheet: View {
    @State var myMessages: [Message] = [
        Message(image: "icon_weixin_circle", name: "这是微信"),
        Message(image: "icon_weibo_circle", name: "这是微博"),
        Message(image: "icon_qq_circle", name: "这是QQ"),
        Message(image: "icon_phone_circle", name: "这是电话"),
        Message(image: "icon_email_circle", name: "这是邮箱")
    ]
    @State var showActionSheet = false
    
    var body: some View {
        List {
            ForEach(myMessages) { message in
                HStack {
                    Image(message.image)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text(message.name)
                        .padding()
                }
                .contextMenu{
                    Button {
                        //点击删除
                        self.showActionSheet.toggle()
                    } label: {
                        HStack {
                            Text("删除")
                            Image(systemName: "trash")
                        }
                    }
                }
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("确定删除？"), message: nil, buttons: [
                        .destructive(Text("删除"), action: {
                            self.delete(item: message)
                        }),
                        .cancel(Text("取消"), action: {
                            
                        })
                    ])
                }
            }
        }
    }
    
    func delete(item: Message) {
        if let deleteIndex: Int = self.myMessages.firstIndex(where: {$0.id == item.id}) {
            self.myMessages.remove(at: deleteIndex)
        }
    }
}
