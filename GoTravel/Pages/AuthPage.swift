//
//  AuthPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 10/02/2024.
//

import SwiftUI

private enum page {
    case login
    case signup
}

public struct AuthPage: View {
    
    @Namespace private var anim
    @State private var page: page = .login
    
    
    public var body: some View {
        switch page {
        case .login:
            LoginView(goToSignup: self.goToSignUp)
                .toolbarTitleDisplayMode(.large)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .navigationTitle("Login")
                .transition(.opacity)
                .matchedGeometryEffect(id: "page", in: anim)
        case .signup:
            SignUpView(goToLogin: self.goToLogin)
                .toolbarTitleDisplayMode(.large)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .navigationTitle("Sign Up")
                .transition(.opacity)
                .matchedGeometryEffect(id: "page", in: anim)
        }
        
    }
    
    private func goToSignUp() {
        withAnimation {
            self.page = .signup
        }
    }
    
    private func goToLogin() {
        withAnimation {
            self.page = .login
        }
    }
}

#Preview {
    NavigationStack {
        AuthPage()
    }
}
