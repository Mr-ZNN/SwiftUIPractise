//
//  TestSwiftUITextEditor.swift
//  TestSwiftUI
//
//  Created by Neil on 4/6/25.
//

import Foundation
import SwiftUI

struct TestSwiftUITextEditor: View {
    
    @State private var message = ""  //文本内容
    @State private var wordCount = 0 //文字个数
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .bottomTrailing) {
                //多行文本框
                TextEditor(text: $message)
                    .font(.title3)
                    .lineSpacing(15) // 行距
                    .autocapitalization(.words)
                    .autocorrectionDisabled(true)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                    //改变时
                    .onChange(of: message) { oldValue, newValue in
                        // 过滤掉空格和换行符后计算字符数
                        let words = newValue.filter { !$0.isWhitespace && !$0.isNewline }
                        self.wordCount = words.count
                    }
                //字数统计
                Text("\(self.wordCount)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.trailing)
                    .padding()
            }
            //边框
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            }
            //注释文字
            if message.isEmpty {
                Text("请输入内容")
                    .foregroundStyle(Color(uiColor: UIColor.placeholderText))
                    .padding(15)
            }
        }
        .padding()
    }
}
