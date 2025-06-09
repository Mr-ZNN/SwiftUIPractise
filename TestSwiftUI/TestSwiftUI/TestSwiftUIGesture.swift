//
//  TestSwiftUIGesture.swift
//  TestSwiftUI
//
//  Created by Neil on 30/5/25.
//

import Foundation
import SwiftUI

struct TestSwiftUIGesture: View {
    var body: some View {
        TestSwiftUIGestureCombination()
    }
}

//点击手势用法一
struct TestSwiftUITapGesture1: View {
    
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(circleColorChanged ? .gray : .red)
            Image(systemName: "heart.fill")
                .foregroundStyle(heartColorChanged ? .red : .white)
                .font(.system(size: 80))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        //点击手势
        .onTapGesture {
            circleColorChanged.toggle()
            heartColorChanged.toggle()
            heartSizeChanged.toggle()
        }
    }
}

//点击手势用法二
struct TestSwiftUITapGesture2: View {
    
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(circleColorChanged ? .gray : .red)
            Image(systemName: "heart.fill")
                .foregroundStyle(heartColorChanged ? .red : .white)
                .font(.system(size: 80))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        //添加手势
        .gesture(
            //点击手势
            TapGesture()
                //手势结束
                .onEnded({
                    circleColorChanged.toggle()
                    heartColorChanged.toggle()
                    heartSizeChanged.toggle()
                })
        )
    }
}

//长按手势用法一
struct TestSwiftUILongPressGesture1: View {
    
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(circleColorChanged ? .gray : .red)
            Image(systemName: "heart.fill")
                .foregroundStyle(heartColorChanged ? .red : .white)
                .font(.system(size: 80))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        .gesture(
            //长按手势
            LongPressGesture()
                .onEnded({ _ in
                    circleColorChanged.toggle()
                    heartColorChanged.toggle()
                    heartSizeChanged.toggle()
                })
        )
    }
}

//长按手势用法二
struct TestSwiftUILongPressGesture2: View {
    
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    @GestureState private var longPressTap = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(circleColorChanged ? .gray : .red)
            Image(systemName: "heart.fill")
                .foregroundStyle(heartColorChanged ? .red : .white)
                .font(.system(size: 80))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
                .opacity(longPressTap ? 0.4 : 1.0)
        }
        .gesture(
            LongPressGesture(minimumDuration: 1.0)
                //点击时更改图片透明度
                .updating($longPressTap, body: { currentState, state, transaction in
                    state = currentState
                })
                //长按结束更改状态
                .onEnded({ _ in
                    circleColorChanged.toggle()
                    heartColorChanged.toggle()
                    heartSizeChanged.toggle()
                })
        )
    }
}

//拖拽手势用法
struct TestSwiftUIDragGesture: View {
    
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(.red)
            Image(systemName: "heart.fill")
                .foregroundStyle(.white)
                .font(.system(size: 80))
                .scaleEffect(0.5)
        }
        .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
        .gesture(
            //拖拽手势
            DragGesture()
                //更新方法
                .updating($dragOffset, body: { currentPosition, state, transaction in
                    state = currentPosition.translation
                })
                //拖拽结束后的位置
                .onEnded({ currentPosition in
                    self.position.height += currentPosition.translation.height
                    self.position.width += currentPosition.translation.width
                })
        )
    }
}

//多种手势组合用法
struct TestSwiftUIGestureCombination: View {
    
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    @GestureState private var longPressTap = false
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(circleColorChanged ? .gray : .red)
            Image(systemName: "heart.fill")
                .foregroundStyle(heartColorChanged ? .red : .white)
                .font(.system(size: 80))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
                .opacity(longPressTap ? 0.4 : 1.0)
        }
        // 移动位置
        .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
        .gesture(
            LongPressGesture(minimumDuration: 1.0)
                //长按手势更新方法
                .updating($longPressTap, body: { currentState, state, transaction in
                    state = currentState
                    circleColorChanged.toggle()
                    heartColorChanged.toggle()
                    heartSizeChanged.toggle()
                })
                //拖拽手势
                .sequenced(before: DragGesture())
                //拖拽手势更新方法
                .updating($dragOffset, body: { currentPosition, state, transaction in
                    switch currentPosition {
                    case .first(true):
                        print("正在点击")
                    case .second(true, let drag):
                        state = drag?.translation ?? .zero
                    default:
                        break
                    }
                })
                .onEnded({ currentPosition in
                    guard case .second(true, let drag?) = currentPosition else {
                        return
                    }
                    self.position.height += drag.translation.height
                    self.position.width += drag.translation.width
                    self.circleColorChanged.toggle()
                    self.heartColorChanged.toggle()
                    self.heartSizeChanged.toggle()
                })
        )
    }
}
