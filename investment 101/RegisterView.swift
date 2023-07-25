//
//  RegisterView.swift
//  investment 101
//
//  Created by Celine Tsai on 25/7/23.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var navigationSelection: NavigationDestination?
    
    enum NavigationDestination {
        case mainMenu
    }
    
    var body: some View {
        ZStack {
            Color(hexString: "576CBC").ignoresSafeArea()
            
            VStack {
                EmailView()
                    .frame(height: 90)
                    .padding(.top, -30)
                
                PasswordView(navigationSelection: $navigationSelection)
                    .frame(height: 40)
                
                Spacer()
                
                
                .padding(.horizontal, 48)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true) // Hide default back button
        .navigationBarItems(leading: backButton) // Set custom back button
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.white) // Change color to white
        }
    }
}

struct EmailView: View {
    @State private var email = ""
    
    var body: some View {
        TextField("Email", text: $email)
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(25)
            .multilineTextAlignment(.center)
            .frame(width: 360, height: 230)
    }
}

struct PasswordView: View {
    @State private var password = ""
    @Binding var navigationSelection: RegisterView.NavigationDestination?
    
    var body: some View {
        SecureField("Password", text: $password)
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(25)
            .frame(width: 360, height: 200)
            .multilineTextAlignment(.center)
        Group { // Wrap the Button and NavigationLink in a Group
            Button(action: {
                navigationSelection = .mainMenu
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .frame(height: 70)
                    .background(Color.clear)
                    .padding(.top, 30)
            }
            
            NavigationLink(
                destination: MainMenuView()
                    .navigationBarBackButtonHidden(true),
                tag: .mainMenu,
                selection: $navigationSelection,
                label: { EmptyView() }
            )
        }
    }
}

extension Color {
    init(hexString: String) {
        let scanner = Scanner(string: hexString)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
