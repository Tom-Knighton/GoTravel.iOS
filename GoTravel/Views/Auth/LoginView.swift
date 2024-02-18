//
//  LoginView.swift
//  GoTravel
//
//  Created by Tom Knighton on 10/02/2024.
//

import SwiftUI
import ColorfulX
import AuthenticationServices
import GoTravel_API

public struct LoginView: View {
    
    @Environment(\.colorScheme) private var scheme
    @State private var viewModel = SignInViewModel()
    @State private var bgColours: [Color] = ColorfulPreset.sunrise.colors
        
    private var goToSignup: () -> Void
    
    init(goToSignup: @escaping () -> Void) {
        self.goToSignup = goToSignup
    }
    
    public var body: some View {
        ZStack {
            bgColours[0].ignoresSafeArea()
            ColorfulView(color: $bgColours, speed: .constant(0.2))
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 25))
                    .shadow(radius: 10)
                
                Spacer().frame(height: 50)
                
                ValidatedView({
                    TextField("Username or email address", text: $viewModel.userText)
                        .textFieldStyle(AuthTextFieldStyle())
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .onChange(of: viewModel.userText) { _, newValue in
                            viewModel.userText = filterUserText(newValue)
                        }
                }, errors: viewModel.error == nil ? nil : [viewModel.error ?? ""])
              
                Spacer().frame(height: 16)
                SecureField("Password", text: $viewModel.passwordText)
                    .textFieldStyle(AuthTextFieldStyle())
                    .textContentType(.password)
                                
                Button(action: { viewModel.SignIn() }) {
                    Text("Log In")
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

                VStack {

                    Divider()
                    HStack {
                        Spacer()
                        Image(systemName: Icons.minus)
                        Text("Or")
                        Image(systemName: Icons.minus)
                        Spacer()
                    }
                    .ignoresSafeArea(.keyboard)
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.fullName, .email, .init("openid"), .init("profile"), .init("offline_access")]
                    } onCompletion: { result in
                        viewModel.AppleAuthenticate(result)
                    }
                    .frame(height: 45)
                    .clipShape(.rect(cornerRadius: 10))
                }
            

                Spacer().frame(height: 8)
                
                Button(action: { self.goToSignup() }) {
                    Text("Don't have an account? Sign Up")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .bold().fontDesign(.rounded)
                .tint(Color.white)
                Spacer().frame(height: 16)

            }
            .padding(.horizontal, 16)
        }
        .onChange(of: self.scheme, initial: true) { _, value in
            self.bgColours = value == .dark ? ColorfulPreset.love.colors : ColorfulPreset.sunrise.colors
        }
        .alert("Error", isPresented: $viewModel.somethingWentWrong) {
            Button(action: {}) {
                Text("Ok")
            }
        } message: {
            Text("Something went wrong. Please try again.")
        }
    }
    
    private func filterUserText(_ input: String) -> String {
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
    LoginView(goToSignup: {})
}

