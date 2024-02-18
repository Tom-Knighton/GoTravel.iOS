//
//  SignUpView.swift
//  GoTravel
//
//  Created by Tom Knighton on 11/02/2024.
//

import SwiftUI
import ColorfulX
import AuthenticationServices

public struct SignUpView: View {
    
    @Environment(\.colorScheme) private var scheme
    @State private var bgColours: [Color] = ColorfulPreset.sunrise.colors
    
    @State private var viewModel = SignupViewModel()
    
    private let goToLogin: () -> Void
    
    init(goToLogin: @escaping () -> Void) {
        self.goToLogin = goToLogin
    }
    
    public var body: some View {
        ZStack {
            bgColours[0].ignoresSafeArea()
            ColorfulView(color: $bgColours, speed: .constant(0.2))
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack {
                          
                        Spacer()
                        Text(Strings.Auth.FewDetails)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .bold()
                            .fontDesign(.rounded)
                        
                        
                        ValidatedView({
                            TextField(Strings.Auth.ChooseUsername, text: $viewModel.usernameField)
                                .textFieldStyle(AuthTextFieldStyle())
                                .textContentType(.username)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .onChange(of: viewModel.usernameField) { _, newValue in
                                    viewModel.usernameField = filterUsername(newValue)
                                }
                        }, errors: self.viewModel.errors(for: "username"))
                       
                        ValidatedView({
                            TextField(Strings.Auth.ChooseEmail, text: $viewModel.emailField)
                                .textFieldStyle(AuthTextFieldStyle())
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .onChange(of: viewModel.emailField) { _, newValue in
                                    viewModel.emailField = filterEmail(newValue)
                                }
                        }, errors: self.viewModel.errors(for: "email"))
                        
                        ValidatedView({
                            SecureField(Strings.Auth.ChoosePassword, text: $viewModel.passwordField)
                                .textFieldStyle(AuthTextFieldStyle())
                                .textContentType(.newPassword)
                        }, errors: self.viewModel.errors(for: "password"))
                        
                        ValidatedView({
                            SecureField(Strings.Auth.ChooseConfPassword, text: $viewModel.confirmPasswordField)
                                .textFieldStyle(AuthTextFieldStyle())
                                .textContentType(.password)
                        }, errors: self.viewModel.errors(for: "passwordConfirm"))
                        
                       

                        Button(action: { viewModel.Signup() }) {
                            Text(Strings.Auth.SignUp)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 4)
                                .bold()
                                .fontDesign(.rounded)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.clear)
                        .background(LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(.rect(cornerRadius: 10))
                        
                        Spacer()

                        Spacer()

                    }
                    .frame(maxHeight: .infinity)
                }
                .scrollBounceBehavior(.basedOnSize)
                .frame(maxHeight: .infinity)
                .contentMargins(.horizontal, 16, for: .scrollContent)
                .ignoresSafeArea(.keyboard)
                
                VStack {

                    Divider()
                    HStack {
                        Spacer()
                        Image(systemName: Icons.minus)
                        Text(Strings.Misc.Or)
                        Image(systemName: Icons.minus)
                        Spacer()
                    }
                    .accessibilityHidden()
                    
                    SignInWithAppleButton(.signUp) { request in
                        request.requestedScopes = [.fullName, .email, .init("openid"), .init("profile"), .init("offline_access")]
                    } onCompletion: { result in
                        self.viewModel.AppleAuthenticate(result)
                    }
                    .frame(height: 45)
                    .clipShape(.rect(cornerRadius: 10))
                    
                    Spacer().frame(height: 8)
                    
                    Button(action: { self.goToLogin() }) {
                        Text(Strings.Auth.LoginCTA)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .bold().fontDesign(.rounded)
                    .tint(Color.white)
                    
                    Spacer().frame(height: 16)
                }
                .padding(.horizontal, 16)
                .ignoresSafeArea(.keyboard)
            }
            .ignoresSafeArea(.keyboard)

            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.7).ignoresSafeArea(.all)
                    VStack {
                        Spacer()
                        ProgressView()
                            .tint(.white)
                        Spacer()
                    }
                        
                }
                .ignoresSafeArea(.all)
            }
          
        }
        .onChange(of: self.scheme, initial: true) { _, value in
            self.bgColours = value == .dark ? ColorfulPreset.love.colors : ColorfulPreset.sunrise.colors
        }
        .sheet(isPresented: $viewModel.showNextStep) {
            PostSignupView(tempUser: viewModel.tempUser)
                .presentationDetents([.medium])
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.disabled)
        }
        .alert(Strings.Misc.Error, isPresented: $viewModel.somethingWentWrong) {
            Button(action: {}) {
                Text(Strings.Misc.Ok)
            }
        } message: {
            Text(Strings.Errors.SomethingWrong)
        }

    }
    
    private func filterUsername(_ input: String) -> String {
        
        let max = 25
        let allowedCharacters = CharacterSet
            .lowercaseLetters
            .union(.decimalDigits)
            .union(.init(charactersIn: "-_"))
        let filtered = input.reduce(into: "") { result, char in
            if result.count < max {
                let string = String(char)
                if string.rangeOfCharacter(from: allowedCharacters) != nil {
                    result.append(char)
                }
            }
        }
        
        return filtered
    }
    
    private func filterEmail(_ input: String) -> String {
        let deniedCharacters = CharacterSet
            .whitespacesAndNewlines
        let filtered = input.filter { char in
            let string = String(char)
            return string.rangeOfCharacter(from: deniedCharacters) == nil
        }
        
        return filtered
    }
}

#Preview {
    SignUpView(goToLogin: {})
}
