//
//  TestSwiftUIBanner.swift
//  TestSwiftUI
//
//  Created by Neil on 3/6/25.
//

import Foundation
import SwiftUI

struct BannerImageModel: Identifiable {
    var id = UUID()
    var image: String
    var name: String
}
let imageModels: [BannerImageModel] = [
    BannerImageModel(image: "cute_0_original", name: "图片00"),
    BannerImageModel(image: "cute_1_original", name: "图片01"),
    BannerImageModel(image: "cute_2_original", name: "图片02"),
    BannerImageModel(image: "cute_3_original", name: "图片03"),
    BannerImageModel(image: "cute_4_original", name: "图片04"),
    BannerImageModel(image: "cute_5_original", name: "图片05"),
    BannerImageModel(image: "cute_6_original", name: "图片06"),
    BannerImageModel(image: "cute_7_original", name: "图片07"),
    BannerImageModel(image: "cute_8_original", name: "图片08"),
    BannerImageModel(image: "cute_9_original", name: "图片09")
]

struct TestSwiftUIBanner: View {
    @State var currentIndex = 5 //当前卡片索引
    @GestureState var dragOffset: CGFloat = 0 //拖动偏移量
    @State private var offset: CGFloat = .zero
    @State var isShowDetailView: Bool = false
    
    var body: some View {
        ZStack {
            GeometryReader { outerView in
                HStack(spacing: 0) {
                    ForEach(imageModels.indices, id: \.self) { index in
                        let model: BannerImageModel = imageModels[index]
                        GeometryReader { innerView in
                            BannerCardView(image: model.image, imageName: model.name)
                            //如果点击图片就移上去
                                .offset(y: self.isShowDetailView ? -innerView.size.height * 0.3 : 0)
                        }
                        //如果点击图片两边就不留边距
                        .padding(.horizontal, self.isShowDetailView ? 0 : 20)
                        .opacity(self.currentIndex == index ? 1.0 : 0.7)
                        //如果点击图片就调整大小
                        .frame(width: outerView.size.width, height: self.currentIndex == index ? (self.isShowDetailView ? outerView.size.height : 250) : 200)
                        //点击进入详情页
                        .onTapGesture {
                            self.isShowDetailView = true
                        }
                    }
                }
                .frame(width: outerView.size.width, height: outerView.size.height, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * outerView.size.width)
                .offset(x: self.dragOffset)
                //拖动事件
                .gesture(
                    //如果没有被点击
                    !self.isShowDetailView ?
                    DragGesture()
                        .updating($dragOffset) { value, state, transaction in
                            state = value.translation.width
                        }
                        .onEnded({ value in
                            let threshold = outerView.size.width * 0.4
                            var newIndex = Int(-value.translation.width / threshold) + self.currentIndex
                            newIndex = min(max(newIndex, 0), imageModels.count-1)
                            self.currentIndex = newIndex
                        })
                    : nil
                )
            }
            .animation(.interpolatingSpring(mass: 0.6, stiffness: 100, damping: 10, initialVelocity: 0.3), value: offset)
            
            //详情页
            if self.isShowDetailView {
                BannerDetailView(image: imageModels[self.currentIndex].image, imageName: imageModels[self.currentIndex].name)
                    .offset(y: 200)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(mass: 0.5, stiffness: 100, damping: 10, initialVelocity: 0.3), value: offset)
                //关闭按钮
                Button {
                    self.isShowDetailView = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.black)
                        .opacity(0.7)
                        .contentShape(Rectangle())
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.trailing)
            }
        }
    }
}
//卡片视图
struct BannerCardView: View {
    let image: String
    let imageName: String
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(15)
                    .overlay {
                        Text(imageName)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(10)
                            .background(Color.white)
                            .padding([.bottom, .leading])
                            .opacity(1.0)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                    }
            }
        }
        
    }
}
//详情页
struct BannerDetailView: View {
    let image: String
    let imageName: String
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    //图片名称
                    Text(self.imageName)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .padding(.bottom, 30)
                    //描述文字
                    Text("要想在一个生活圈中生活下去，或者融入职场的氛围，首先你要学习这个圈子的文化和发展史，并尝试用这个圈子里面的“话术”和他们交流，这样才能顺利地融入这个圈子。")
                        .padding(.bottom, 40)
                    //按钮
                    Button {
                        
                    } label: {
                        Text("知道了")
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(15)
            }
        }
    }
}
