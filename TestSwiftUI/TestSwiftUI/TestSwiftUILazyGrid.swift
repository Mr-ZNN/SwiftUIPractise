//
//  TestSwiftUILazyGrid.swift
//  TestSwiftUI
//
//  Created by Neil on 5/6/25.
//

import Foundation
import SwiftUI

struct TestSwiftUILazyVGrid: View {
    private var appleSymbols = ["house.circle", "person.circle", "bag.circle", "location.circle", "bookmark.circle", "gift.circle", "globe.asia.australia.fill", "lock.circle", "pencil.circle", "link.circle"]
    
    //1. 使用.flexible灵活适应修饰符
    private var gridItemLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    //2. 使用.adaptive自适应修饰符来自适应调整LazyVGrid垂直网格内的排布。LazyVGrid垂直网格会在每个GridItem列项大小为80的基础上，在一行中会填充尽可能多的图像。
    //private var gridItemLayout: [GridItem] = [GridItem(.adaptive(minimum: 50))]
    //3. 使用.fixed自定义每列的宽度
    //private var gridItemLayout = [GridItem(.fixed(100)), GridItem(.fixed(150)),GridItem(.fixed(100))]
    //3. 混合使用
    //private var gridItemLayout = [GridItem(.flexible()), GridItem(.fixed(150)),GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout) {
                ForEach(0 ... 99, id: \.self) { index in
                    Image(systemName: appleSymbols[index % appleSymbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct TestSwiftUILazyHGrid: View {
    private var appleSymbols = ["house.circle", "person.circle", "bag.circle", "location.circle", "bookmark.circle", "gift.circle", "globe.asia.australia.fill", "lock.circle", "pencil.circle", "link.circle"]
    
    //1. 使用.flexible灵活适应修饰符
    private var gridItemLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 10)
    //2. 使用.adaptive自适应修饰符来自适应调整LazyVGrid垂直网格内的排布。LazyVGrid垂直网格会在每个GridItem列项大小为80的基础上，在一行中会填充尽可能多的图像。
    //private var gridItemLayout: [GridItem] = [GridItem(.adaptive(minimum: 80))]
    //3. 使用.fixed自定义每列的宽度
    //private var gridItemLayout = [GridItem(.fixed(100)), GridItem(.fixed(150)),GridItem(.fixed(100))]
    //3. 混合使用
    //private var gridItemLayout = [GridItem(.flexible()), GridItem(.fixed(150)),GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItemLayout, spacing: 10) {
                ForEach(0 ... 99, id: \.self) { index in
                    Image(systemName: appleSymbols[index % appleSymbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 80, minHeight: 80, maxHeight: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
        }
    }
}
