//
//  TestSwiftUIRegistration.swift
//  TestSwiftUI
//
//  Created by Neil on 4/6/25.
//

import Foundation
import SwiftUI
import Combine

struct TestSwiftUIRegistration: View {

    //直接引用ViewModel
    @ObservedObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        VStack {
            RegistrationView(isTextField: true, fieldName: "用户名", fieldValue: $viewModel.username)
            if !viewModel.isUsernameLengthValid {
                InputErrorView(iconName: "exclamationmark.circle.fill", text: "用户不存在")
            }
            RegistrationView(isTextField: false, fieldName: "密码", fieldValue: $viewModel.password)
            if !viewModel.isPasswordLengthValid || !viewModel.isPasswordCapitalLetter {
                InputErrorView(iconName: "exclamationmark.circle.fill", text: "密码不正确")
            }
            RegistrationView(isTextField: false, fieldName: "再次输入密码", fieldValue: $viewModel.rePassword)
            if !viewModel.isPasswordConfirmValid {
                InputErrorView(iconName: "exclamationmark.circle.fill", text: "再次密码需要相同")
            }
            
            //注册按钮
            Button {
                
            } label: {
                Text("注册")
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color(red: 51/255, green: 51/255, blue: 51/255))
                    .cornerRadius(10)
                    .padding()
            }

        }
    }
}

//注册输入框
struct RegistrationView: View {
    var isTextField = false
    var fieldName = ""
    @Binding var fieldValue: String
    
    var body: some View {
        VStack {
            //判断是不是输入框
            if isTextField {
                //正常输入框
                TextField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.horizontal)
                    .padding(.top, 10)
            } else {
                //密码输入框
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
            //分割线
            Divider()
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
        }
    }
}

//错误提示视图
struct InputErrorView: View {
    var iconName = ""
    var text = ""
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundStyle(Color(red: 251/255, green: 128/255, blue: 128/255))
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundStyle(Color(red: 251/255, green: 128/255, blue: 128/255))
            Spacer()
        }.padding(.leading, 10)
    }
}

//ViewModel
class RegistrationViewModel: ObservableObject {
    //输入
    @Published var username = ""
    @Published var password = ""
    @Published var rePassword = ""
    
    //输出
    @Published var isUsernameLengthValid = false   //用户名长度有效
    @Published var isPasswordLengthValid = false   //密码长度有效
    @Published var isPasswordCapitalLetter = false //密码至少一位大写
    @Published var isPasswordConfirmValid = false  //两次输入密码是否一致
    
    //取消订阅
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        //用户名长度检验
        $username
            .receive(on: RunLoop.main)
            .map { username in
                return username.count > 0 ? username.count > 2 : true
            }
            .assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &cancellableSet)
        //密码长度校验
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count > 0 ? password.count > 6 : true
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        //密码大写校验
        $password
            .receive(on: RunLoop.main)
            .map { password in
                if password.count > 0 {
                    let pattern = "[A-Z]"
                    if let _ = password.range(of: pattern, options: .regularExpression) {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return true
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)
        //两次密码是否相同
        Publishers.CombineLatest($password, $rePassword).receive(on: RunLoop.main)
            .map { password, rePassword in
                rePassword.count > 0 ? rePassword.isEmpty == false && (password == rePassword) : true
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
    }
}
