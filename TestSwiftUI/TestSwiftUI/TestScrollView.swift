//
//  TestScrollView.swift
//  TestSwiftUI
//
//  Created by Neil on 26/5/25.
//

import Foundation
import SwiftUI

struct TestScrollView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                CardView(image: "food_1", title: "番茄是茄科茄属的一种植物。番茄原产于中美洲和南美洲。")
                CardView(image: "food_2", title: "扬州炒饭是一种源于中国并冠名为“扬州”的炒饭，根据其来源和制作形式而在各地区有所差异。")
                CardView(image: "food_3", title: "三文鱼进入高级寿司店，人气稳超金枪鱼。")
                CardView(image: "food_4", title: "和菓子食譜-簡單!上品!抹茶幕斯(日本料理)的做法。")
            }
        }
    }
}
struct CardView: View {
    var image: String
    var title: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(title)
                .fontWeight(.medium)
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .padding()
        }
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10).stroke(Color(red: 150/255, green: 150/255, blue: 150/255), lineWidth: 1)
        }
        .padding([.top, .horizontal])
    }
}
