//
//  TestSwiftUITransition.swift
//  TestSwiftUI
//
//  Created by Neil on 9/6/25.
//

import Foundation
import SwiftUI

struct Model: Identifiable {
    var id = UUID()
    var category: String
    var headline: String
    var subHeadline: String
    var content: String
    var image: String
}

var sampleModels = [
    Model(category: "推荐", headline: "编辑精选", subHeadline: "本周推荐语录", content: "要想在一个生活圈中生活下去，或者融入职场的氛围，首先你要学习这个圈子的文化和发展史，并尝试用这个圈子里面的“话术”和他们交流，这样才能顺利地融入这个圈子。", image: "cute_0_original"),
    Model(category: "热榜", headline: "每日热榜", subHeadline: "今日热门事件推送", content: "对于产品经理来说，用户真正使用产品或产品上线交付后，产品的价值才真正发挥出来。这时候，价值的多少就取决于产品本身所提供的服务，以及产品的设计者后续的运营了。", image: "cute_1_original"),
    Model(category: "头条", headline: "精选头条", subHeadline: "你关注的才是头条", content: "在任何环境中都需要去发现他人身上的优点，但在学习他人优点的同时，也不要忘了自己本身的个人特性，因为这才是你的优点。遇到困难时，我们要迎难而上，而不是畏畏缩缩。找到一个明确的目标，不在乎别人的眼光，努力去做就好了。", image: "cute_2_original")
]
struct TestSwiftUITransitionView: View {
    var body: some View {
        let model = sampleModels[0]
        TestSwiftUITransitionCardView(category: model.category, headline: model.headline, subHeadline: model.subHeadline, image: UIImage(named: model.image)!, content: model.content, isShowContent: .constant(false))
    }
}
struct TestSwiftUITransitionSummaryView: View {
    let category: String
    let headline: String
    let subHeadline: String
    @Binding var isShowContent: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Rectangle()
                .frame(minHeight: 100, maxHeight: 150)
                .overlay {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(self.category.uppercased())
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.gray)
                            Text(self.headline)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.gray)
                                .minimumScaleFactor(0.1)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                            if !self.isShowContent {
                                Text(self.subHeadline)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                    .minimumScaleFactor(0.1)
                                    .lineLimit(3)
                            }
                        }.padding()
                        Spacer()
                    }
                }
        }
        .foregroundStyle(.white)
    }
}

struct TestSwiftUITransitionCardView: View {
    let category: String
    let headline: String
    let subHeadline: String
    let image: UIImage
    var content: String = ""
    @Binding var isShowContent: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: min(self.image.size.height / 3, 500))
                    .border(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), width: self.isShowContent ? 0 : 1)
                    .cornerRadius(15)
                    .overlay {
                        TestSwiftUITransitionSummaryView(category: self.category, headline: self.headline, subHeadline: self.subHeadline, isShowContent: self.$isShowContent)
                            .cornerRadius(self.isShowContent ? 0 : 15)
                    }
                if self.isShowContent {
                    Text(self.content)
                        .foregroundStyle(Color(.darkGray))
                        .font(.system(.body, design: .rounded))
                        .padding(.horizontal)
                        .padding(.bottom, 50)
                        .transition(.move(edge: .top))
                        .animation(.linear, value: 0)
                }
            }
        }
        .shadow(color: Color(.sRGB, red: 64/255, green: 64/255, blue: 64/255, opacity: 0.3), radius: self.isShowContent ? 0 : 15)
    }
}
