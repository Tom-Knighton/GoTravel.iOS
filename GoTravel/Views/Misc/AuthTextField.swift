//
//  AuthTextField.swift
//  GoTravel
//
//  Created by Tom Knighton on 11/02/2024.
//

import SwiftUI

public struct ValidatedView<Content: View>: View {
    
    private let content: () -> Content
    private let errors: [LocalizedStringKey]

    public init(_ content: @escaping () -> Content, errors: [LocalizedStringKey]? = nil) {
        self.content = content
        self.errors = errors ?? []
    }
        
    public var body: some View {
        VStack {
            content()
            if !errors.isEmpty {
                ForEach(errors, id: \.self) { error in
                    Text(error)
                        .bold()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .shadow(radius: 3)
                }
            }
        }
    }
}

public struct AuthTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        VStack {
            configuration
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 2)
                        .fill(.layer1)
                }
        }
    }
}


#Preview(body: {
    @State var text: String = ""
    return TextField(Strings.Auth.Username, text: $text)
        .textFieldStyle(AuthTextFieldStyle())
})
