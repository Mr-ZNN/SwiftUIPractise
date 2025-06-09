//
//  TestGradient.swift
//  TestSwiftUI
//
//  Created by Neil on 27/5/25.
//

import Foundation
import SwiftUI

struct TestGradient: View {
    var body: some View {
        Button {
            print("点击按钮")
        } label: {
            Text("登录")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 45)
                .fontWeight(.bold)
                .font(.system(size: 15))
                .foregroundStyle(.white)
                .background(LinearGradient(colors: [.red, .orange], startPoint: .leading, endPoint: .trailing))
                .background(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }

    }
}
