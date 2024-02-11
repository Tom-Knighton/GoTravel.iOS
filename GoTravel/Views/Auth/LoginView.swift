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
    @State private var bgColours: [Color] = ColorfulPreset.sunrise.colors
    
    @State private var userField: String = ""
    @State private var passwordField: String = ""
    
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
                TextField("Username or email address", text: $userField)
                    .textFieldStyle(AuthTextFieldStyle())
                    .textContentType(.emailAddress)
                Spacer().frame(height: 16)
                SecureField("Password", text: $passwordField)
                    .textFieldStyle(AuthTextFieldStyle())
                    .textContentType(.password)
                                
                Button(action: { self.login() }) {
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
                        switch result {
                        case .success(let authResults):
                            print("Authorization successful.")
                            guard let credentials = authResults.credential as? ASAuthorizationAppleIDCredential,
                                  let authCode = credentials.authorizationCode,
                                  let authCodeString = String(data: authCode, encoding: .utf8),
                                  let identity = credentials.identityToken,
                                  let identityString = String(data: identity, encoding: .utf8) else { return }
                            Task {
                                do {
                                    print(authCodeString)
                                    print(identityString)
                                    let success = try await AuthClient.Authenticate(with: authCodeString)
                                    print("Auth: \(success)")
                                }
                                catch {
                                    print(error.localizedDescription.debugDescription)
                                }
                            }
                        case .failure(let error):
                            print("Authorization failed: " + error.localizedDescription)
                      }
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
    }
    
    @ViewBuilder
    private func AuthField() -> some View {
        ZStack {
            
        }
    }
    
    private func login() {
        Task {
            do {
                let success = try await AuthClient.Authenticate(with: self.userField, password: self.passwordField)
                print("Auth: \(success)")
            }
            catch {
                print(error)
            }
        }
    }
}

#Preview {
    LoginView(goToSignup: {})
}

