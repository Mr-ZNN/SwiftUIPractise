//
//  TestSwiftUIState.swift
//  TestSwiftUI
//
//  Created by Neil on 27/5/25.
//

import Foundation
import SwiftUI

struct TestSwiftUIState: View {
    
    @State var isSelected: Bool = false
    
    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            VStack {
                Image(systemName: isSelected ? "checkmark.circle.fill" :"circle")
                    .font(.system(size: 40))
                    .foregroundStyle(isSelected ? Color(red: 92/255, green: 182/255, blue: 92/255) : Color(red: 170/255, green: 170/255, blue: 170/255))
                TitleView(isSelected: $isSelected)
            }
        }
    }
}
struct TitleView: View {
    
    @Binding var isSelected: Bool
    
    var body: some View {
        Text(isSelected ? "已选中" : "非选中")
            .fontWeight(.bold)
            .font(.system(size: 15))
            .padding()
    }
}

