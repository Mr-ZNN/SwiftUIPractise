//
//  TestSwiftUIDisclosureGroup.swift
//  TestSwiftUI
//
//  Created by Neil on 4/6/25.
//

import Foundation
import SwiftUI

struct TestSwiftUIDisclosureGroup: View {
    @State var isExpanded = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            //答案代码块
            Text("第一步：把冰箱门打开。第二步：把大象放进去。第三步：把冰箱门关上。")
                .fontWeight(.bold)
        } label: {
            //问题代码块
            Text("如何把大象装进冰箱？")
                .fontWeight(.bold)
        }.padding()

    }
}

struct TestSwiftUIDisclosureGroupList: View {
    @State var isExpanded = Array(repeating: false, count: 3)
    
    private let faqList = [
        (question: "如何把大象装进冰箱？", answer: "第一步：把冰箱门打开。第二步：把大象放进去。第三步：把冰箱门关上。"),
        (question: "如何把大象装进冰箱？", answer: "第一步：把冰箱门打开。第二步：把大象放进去。第三步：把冰箱门关上。"),
        (question: "如何把大象装进冰箱？", answer: "第一步：把冰箱门打开。第二步：把大象放进去。第三步：把冰箱门关上。")
    ]
    
    var body: some View {
        List {
            ForEach(faqList.indices, id: \.self) { index in
                let faq = faqList[index]
                DisclosureGroup(isExpanded: $isExpanded[index]) {
                    //答案代码块
                    Text(faq.answer)
                        .fontWeight(.bold)
                } label: {
                    //问题代码块
                    Text(faq.question)
                        .fontWeight(.bold)
                }.padding()
            }
        }
    }
}
