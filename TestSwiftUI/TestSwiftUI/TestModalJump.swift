//
//  TestModalJump.swift
//  TestSwiftUI
//
//  Created by Neil on 29/5/25.
//

import Foundation
import SwiftUI

struct TestModalJump: View {
    @State var isShowDetail: Bool = false
    @State var isShowAlert: Bool = false
    
    var body: some View {
        VStack {
            Button {
                isShowDetail.toggle()
            } label: {
                Text("跳转模态弹窗")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.cyan)
                    .cornerRadius(6)
                    .padding(.horizontal, 20)
            }.sheet(isPresented: $isShowDetail) {
                //TestModalJumpDetailView()
                TestModalJumpDetailView2(isShowDetail: $isShowDetail)
            }
            Button {
                isShowAlert.toggle()
            } label: {
                Text("跳转Alert")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.cyan)
                    .cornerRadius(6)
                    .padding(.horizontal, 20)
            }.alert(isPresented: $isShowAlert) {
                //Alerts结构体
                Alert(title: Text("这是弹窗标题"), message: Text("这是弹窗的内容"), primaryButton: .default(Text("确定")), secondaryButton: .cancel(Text("取消")))
            }
        }
    }
}
//模态返回方法1：使用内置环境值
struct TestModalJumpDetailView: View {
    //内置环境值
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Text("这是一个新页面").navigationBarItems(leading: Button(action: {
                    //返回上级页面
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.down.circle.fill")
                        .foregroundStyle(.gray)
                }))
        }
    }
}
//模态返回方法2：使用State和Binding
struct TestModalJumpDetailView2: View {
    //Binding
    @Binding var isShowDetail: Bool
    
    var body: some View {
        NavigationView {
            Text("这是一个新页面").navigationBarItems(leading: Button(action: {
                    //返回上级页面
                    isShowDetail.toggle()
                }, label: {
                    Image(systemName: "chevron.down.circle.fill")
                        .foregroundStyle(.gray)
                }))
        }
    }
}
/*
那么两种方法有什么不同呢？
第一种方法简单来说，是“撤销”原有的操作。
而第二种绑定的方式，是反向传递参数值给到第一个页面。
两种方式各有好处，第二种方法的好处是如果第二个页面返回的时候需要带参数值回来，那么我们可以通过绑定的方式将DetailView的值给回到第一个页面。
*/
