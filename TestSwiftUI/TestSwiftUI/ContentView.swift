//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Neil on 20/5/25.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    var body: some View {
        VStack {
            TitleViewView()
            HStack {
                ZStack {
                    PricingView(title: "连续包月", price: "$18", bgColor: Color(red: 244 / 255, green: 244 / 255, blue: 245 / 255), perPrice: "")
                        .overlay {
                            RoundedRectangle(cornerRadius: 6).stroke(Color(red: 202 / 255, green: 169 / 255, blue: 106 / 255), lineWidth: 2)
                        }
                    SpecialOfferView()
                }
                PricingView(title: "一个月", price: "$30", bgColor: Color(red: 244 / 255, green: 244 / 255, blue: 245 / 255), perPrice: "")
                    .cornerRadius(10)
                PricingView(title: "12个月", price: "$228", bgColor: Color(red: 244 / 255, green: 244 / 255, blue: 245 / 255), perPrice: "$19.00/月")
                    .cornerRadius(10)
            }.padding()
        }
    }
    
}

#Preview {
    ContentView()
}

struct TitleViewView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("会员套餐")
                    .fontWeight(.bold)
                    .font(.title)
                Text("解锁高级功能")
                    .fontWeight(.bold)
                    .font(.title)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct PricingView: View {
    var title: String
    var price: String
    var bgColor: Color
    var perPrice: String
    
    var body: some View {
        HStack {
            VStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.system(size: 17))
                    .foregroundColor(Color(red: 190/255, green: 188/255, blue: 184/255))
                Text(price)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .foregroundColor(Color(red: 239/255, green: 129/255, blue: 112/255))
                Text(perPrice)
                    .fontWeight(.bold)
                    .font(.system(size: 17))
                    .foregroundColor(Color(red: 190/255, green: 188/255, blue: 184/255))
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 90)
            .padding(20)
            .background(bgColor)
        }
    }
}

struct SpecialOfferView: View {
    var body: some View {
        Text("首月特惠")
            .fontWeight(.bold)
            .font(.system(size: 14))
            .foregroundStyle(.white)
            .padding(5)
            .background(Color(red: 202 / 255, green: 169 / 255, blue: 106 / 255))
            .cornerRadius(4)
            .offset(x:0, y: -65)
    }
}
