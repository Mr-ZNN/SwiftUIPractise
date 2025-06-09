//
//  TestButton.swift
//  TestSwiftUI
//
//  Created by Neil on 26/5/25.
//

import Foundation
import SwiftUI

struct TestButton: View {
    var body: some View {
        //TextButton()
        //ImageButton()
        TextImageButton()
    }
}
struct TextButton: View {
    var body: some View {
        VStack(spacing: 15) {
            Button {
                //事件
                print("点击了微信登录")
            } label: {
                //样式
                Text("微信登录")
                    .font(.system(size: 16))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color(red:88/255, green: 224/255, blue: 133/255))
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
            }
            Button {
                //事件
                print("点击了Apple登录")
            } label: {
                //样式
                Text("Apple登录")
                    .font(.system(size: 16))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color(red:50/255, green: 50/255, blue: 50/255))
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
            }
        }
    }
}
struct ImageButton: View {
    var body: some View {
        HStack(spacing: 20) {
            Button {
                print("点击了微信")
            } label: {
                Image("icon_weixin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: 32, minHeight: 0, maxHeight: 32)
                    .padding()
                    .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                    .clipShape(Circle())
            }
            Button {
                print("点击了QQ")
            } label: {
                Image("icon_qq")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: 32, minHeight: 0, maxHeight: 32)
                    .padding()
                    .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                    .clipShape(Circle())
            }
            Button {
                print("点击了微博")
            } label: {
                Image("icon_weibo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: 32, minHeight: 0, maxHeight: 32)
                    .padding()
                    .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                    .clipShape(Circle())
            }
        }
    }
}
struct TextImageButton: View {
    var body: some View {
        Button {
            //事件
            print("点击了Apple登录")
        } label: {
            //样式
            HStack {
                Image("icon_apple")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("Apple登录")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(Color(red:51/255, green: 51/255, blue: 51/255))
            .cornerRadius(40)
            .padding(.horizontal, 20)
        }
    }
}
#Preview {
    ContentView()
}
