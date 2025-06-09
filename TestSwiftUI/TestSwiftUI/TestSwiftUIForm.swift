//
//  TestSwiftUIForm.swift
//  TestSwiftUI
//
//  Created by Neil on 29/5/25.
//

import Foundation
import SwiftUI

//普通from
struct TestSwiftUIForm: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("组头部文字")) {
                    Text("关于本机")
                    Text("系统更新")
                }
                Section {
                    Text("隔空投送")
                    Text("隔空播放与接力")
                    Text("画中画")
                }
                Section {
                    Text("iPhone存储空间")
                    Text("后台App刷新")
                }
                Section(footer: Text("组脚部文字")) {
                    Text("日期与时间")
                    Text("键盘")
                    Text("字体")
                    Text("语言与地区")
                    Text("词典")
                }
            }
            .navigationTitle("通用") //导航栏标题
            .navigationBarTitleDisplayMode(.inline) //导航栏标题显示模式
        }
    }
}

//Toggle
struct TestSwiftUIToggle: View {
    @State var isDownload = false    //是否下载
    @State var isInstall = false    //是否安装
    
    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text("下载后在夜间自动安装软件更新。更新安装前您会收到通知。iPhone 必须为充电状态并接入 Wi-Fi以完成更新。")) {
                    Toggle(isOn: $isDownload) {
                        Text("下载iOS更新")
                    }
                    .onChange(of: isDownload) { oldValue, newValue in
                        print("isDownload - oldValue:\(oldValue), newValue:\(newValue)")
                    }
                    Toggle(isOn: $isInstall) {
                        Text("安装iOS更新")
                    }
                    .onChange(of: isInstall) { oldValue, newValue in
                        print("isInstall - oldValue:\(oldValue), newValue:\(newValue)")
                    }
                }
            }
            .navigationTitle("自动更新") //导航栏标题
            .navigationBarTitleDisplayMode(.inline) //导航栏标题显示模式
        }
    }
}

//Picker
struct TestSwiftUIPicker: View {
    private var displayState = ["接收关闭", "仅限联系人", "所有人"]
    @State private var selectedNumber = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Picker(selection: $selectedNumber) {
                        //选择器可选项内容
                        ForEach(0 ..< displayState.count, id: \.self) {
                            Text(self.displayState[$0])
                        }
                    } label: {
                        Text("隔空投送")
                    }
                    .onChange(of: selectedNumber) { oldValue, newValue in
                        print("selectedNumber - newValue:\(newValue)")
                    }
                }
            }
            .navigationTitle("通用") //导航栏标题
            .navigationBarTitleDisplayMode(.inline) //导航栏标题显示模式
        }
    }
}

//Stepper
struct TestSwiftUIStepper: View {
    @State private var amount = 1
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    //步进器
                    Stepper("\(amount)") {
                        self.amount += 1
                        if self.amount > 99 {
                            self.amount = 99
                        }
                    } onDecrement: {
                        self.amount -= 1
                        if self.amount < 1 {
                            self.amount = 1
                        }
                    }
                    
                }
            }
            .navigationTitle("通用") //导航栏标题
            .navigationBarTitleDisplayMode(.inline) //导航栏标题显示模式
        }
    }
}
