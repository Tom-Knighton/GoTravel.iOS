//
//  PostSignupView.swift
//  GoTravel
//
//  Created by Tom Knighton on 11/02/2024.
//

import SwiftUI
import PhotosUI
import GoTravel_Models

public struct PostSignupView: View {
    
    @Environment(GlobalViewModel.self) private var globalVM
    @State private var viewModel = PostSignupViewModel()
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 16)
                Text("Woohoo!")
                    .font(.title2.bold())
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Thank you for signing up, now you can choose how others will see you:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .fontDesign(.rounded)
                
                Spacer()
                
                if let image = self.viewModel.userImage {
                    PhotosPicker(selection: $viewModel.userChosenFile, matching: .images) {
                        VStack {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipShape(.circle)
                                .contentShape(.circle)
                            
                            Text("Change Profile Image")
                                .buttonStyle(.bordered)
                        }
                    }
                }
                else {
                    AsyncImage(url: URL(string: globalVM.currentUser?.userPictureUrl ?? "")) { img in
                        
                        PhotosPicker(selection: $viewModel.userChosenFile, matching: .images) {
                            VStack {
                                img
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(.circle)
                                    .contentShape(.circle)
                                
                                Text("Change Profile Image")
                                    .buttonStyle(.bordered)
                            }
                        }
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                if viewModel.needsUsernameSet() {
                    Spacer().frame(height: 8)
                    
                    Text("Your username:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ValidatedView({
                        TextField("Username", text: $viewModel.usernameText)
                            .textFieldStyle(AuthTextFieldStyle())
                            .textContentType(.username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .onChange(of: viewModel.usernameText) { _, newValue in
                                viewModel.usernameText = filterUsername(newValue)
                            }
                    }, errors: [])
                    
                    Spacer().frame(height: 8)
                }
                
                Spacer()
                
                Button(action: { viewModel.saveUser() }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(viewModel.isLoading)
                .buttonStyle(.borderedProminent)
                .bold()
                .fontDesign(.rounded)
                
                Spacer().frame(height: 16)
            }
            .padding(.horizontal, 16)
            
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
        .onChange(of: viewModel.userChosenFile, initial: false) { _, newValue in
            Task {
                if let newValue, let data = try? await newValue.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        viewModel.userImage = image
                    }
                }
                viewModel.userChosenFile = nil
            }
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
}

#Preview {
    
    let gvm = GlobalViewModel()
    gvm.currentUser = CurrentUser(userId: "apple|", userName: "tomknighton_11213", userEmail: "tomknighton@icloud.com", userPictureUrl: "https://s.gravatar.com/avatar/5fb6ef12d27e312547e9b45d139a0a4f?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fto.png", dateCreated: Date())
    
    return VStack {
        
    }
    .sheet(isPresented: .constant(true)) {
        PostSignupView()
            .presentationDetents([.fraction(0.6)])
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.disabled)
    }
    .environment(gvm)
}
