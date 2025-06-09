//
//  TestSwiftUISearchBar.swift
//  TestSwiftUI
//
//  Created by Neil on 3/6/25.
//

import Foundation
import SwiftUI

struct TestSwiftUISearchBar: View {
    @State var text: String = ""
    
    var body: some View {
        SwiftUISearchBar(text: $text)
            .padding()
        
    }
}
//搜索栏
struct SwiftUISearchBar: View {
    @Binding var text: String
    @State private var isEditing: Bool = false
    @State private var offset: CGFloat = .zero // 使用.animation防止报错，iOS15的特性
    
    var body: some View {
        HStack {
            TextField("搜你想看的", text: $text) { isEditing in
                //onTapGesture不起作用，要这样写
                self.isEditing = true
            }
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                        
                    //编辑时显示清除按钮
                    if isEditing {
                        Button {
                            self.text = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundStyle(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            
            //搜索按钮
            if isEditing {
                Button {
                    print("搜索内容: \(self.text)")
                    self.isEditing = false
                    self.text = ""
                    // 收起键盘
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text("搜索")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: offset)
            }
        }
    }
}

