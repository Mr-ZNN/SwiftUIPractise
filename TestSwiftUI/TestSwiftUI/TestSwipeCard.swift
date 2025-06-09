//
//  TestSwipeCard.swift
//  TestSwiftUI
//
//  Created by Neil on 30/5/25.
//

import Foundation
import SwiftUI

//创建演示数据
var album = [
    Album(name: "图片00", image: "cute_0_original"),
    Album(name: "图片01", image: "cute_1_original"),
    Album(name: "图片02", image: "cute_2_original"),
    Album(name: "图片03", image: "cute_3_original"),
    Album(name: "图片04", image: "cute_4_original"),
    Album(name: "图片05", image: "cute_5_original"),
    Album(name: "图片06", image: "cute_6_original"),
    Album(name: "图片07", image: "cute_7_original"),
    Album(name: "图片08", image: "cute_8_original"),
    Album(name: "图片09", image: "cute_9_original"),
    Album(name: "图片10", image: "cute_10_original"),
    Album(name: "图片11", image: "cute_11_original"),
    Album(name: "图片12", image: "cute_12_original"),
    Album(name: "图片13", image: "cute_13_original"),
    Album(name: "图片14", image: "cute_14_original")
]
var showAlbums: [Album] = {
    var views = [Album]()
    for index in 0..<2 {
        views.append(Album(name: album[index].name, image: album[index].image))
    }
    return views
}()

//Gestures手势特性
enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
        }
    }
    
    var isPressing: Bool {
        switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
        }
    }
}
//转场动画效果
extension AnyTransition {
    
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge : .bottom))
            )
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom))
            )
    }
}


struct TestSwipeCard: View {
    @GestureState private var dragState = DragState.inactive
    @State private var offset: CGFloat = .zero
    private let dragPosition: CGFloat = 80.0
    
    @State var showAlbums: [Album] = {
        var views = [Album]()
        
        for index in 0..<2 {
            views.append(Album(name: album[index].name, image: album[index].image))
        }
        return views
    }()
    //最后一张图片索引值
    @State private var lastIndex = 1
    
    //转场类型动画
    @State private var removalTransition = AnyTransition.trailingBottom
    
    var body: some View {
        VStack {
            //顶部导航栏
            TopBarMenu()
            //卡片视图
            ZStack {
                ForEach(showAlbums) { album in
                    SwipeCardView(name: album.name, image: album.image)
                        .zIndex(self.isTopCard(item: album) ? 1 : 0)
                        .offset(x: self.isTopCard(item: album) ? self.dragState.translation.width : 0, y: self.isTopCard(item: album) ? self.dragState.translation.height : 0)
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(item: album) ? 0.95 : 1)
                        .rotationEffect(Angle(degrees: self.isTopCard(item: album) ? Double(self.dragState.translation.width / 10) : 0))
                        .animation(.interpolatingSpring(stiffness: 180, damping: 100), value: offset)
                        //转场动画
                        .transition(self.removalTransition)
                        .gesture(LongPressGesture(minimumDuration: 1)
                            .sequenced(before: DragGesture())
                            .updating($dragState, body: { value, state, transaction in
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                            })
                                .onChanged({ value in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    if drag.translation.width < -self.dragPosition {
                                        self.removalTransition = .leadingBottom
                                    }
                                    if drag.translation.width > self.dragPosition {
                                        self.removalTransition = .trailingBottom
                                    }
                                })
                                .onEnded({ value in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    if drag.translation.width < -self.dragPosition || drag.translation.width > self.dragPosition {
                                        self.moveCard()
                                    }
                                })
                        )
                        .overlay {
                            ZStack {
                                Image(systemName: "hand.thumbsdown.fill")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width < -self.dragPosition && self.isTopCard(item: album) ? 1.0 : 0)
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width > self.dragPosition && self.isTopCard(item: album) ? 1.0 : 0)
                            }
                        }
                }
            }
            Spacer(minLength: 20)
            //底部导航栏
            BottomBarMenu()
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: offset)
        }
    }
    //获取图片zIndex值
    func isTopCard(item: Album) -> Bool {
        guard let index = showAlbums.firstIndex(where: {$0.id == item.id}) else { return false }
        return index == 0
    }
    //最后一张图片索引值
    func moveCard() {
        self.showAlbums.removeFirst()
        self.lastIndex += 1
        let cards = album[self.lastIndex % album.count]
        let newCardView = Album(name: cards.name, image: cards.image)
        self.showAlbums.append(newCardView)
    }
}
struct TopBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "ellipsis.circle")
                .font(.system(size: 26))
            Spacer()
            Image(systemName: "heart.circle")
                .font(.system(size: 26))
        }
        .padding(.horizontal, 15)
    }
}
struct SwipeCardView: View {
    var name: String
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .overlay(alignment: .bottom) {
                VStack {
                    Text(name)
                        .font(.system(.headline, design: .rounded)).fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(5)
                }
                .padding(.bottom, 20)
            }
    }
}
struct BottomBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "xmark")
                .font(.system(size: 26))
                .foregroundStyle(.black)
            
            Button {
                
            } label: {
                Text("立即选择")
                    .font(.system(.subheadline, design: .rounded)).bold()
                    .foregroundStyle(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 12)
                    .background(.black)
                    .cornerRadius(10)
            }.padding(.horizontal, 20)
            
            Image(systemName: "heart")
                .font(.system(size: 26))
                .foregroundStyle(.black)
        }
    }
}
//创建Album定义变量
struct Album: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

