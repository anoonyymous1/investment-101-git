//
//  LoginView.swift
//  investment 101
//
//  Created by Celine Tsai on 25/7/23.
//

import SwiftUI
//import FirebaseCore
//import FirebaseFirestore
//import FirebaseAuth

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var navigationSelection: NavigationDestination?
    
    enum NavigationDestination {
        case mainMenu
    }
    
    var body: some View {
        ZStack {
            Color(hexString: "A5D7EB").ignoresSafeArea()
            
            VStack {
                EmailView1()
                    .frame(height: 90)
                    .padding(.top, -30)
                
                PasswordView1(navigationSelection: $navigationSelection)
                    .frame(height: 40)
                
                Spacer()
                
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.black)
        }
    }
}

struct EmailView1: View {
    @State public var email = ""
    
    var body: some View {
        TextField("Email", text: $email)
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(30)
            .multilineTextAlignment(.center)
            .frame(width: 360, height: 230)
    }
}

struct PasswordView1: View {
    @State public var password = ""
    @Binding var navigationSelection: LoginView.NavigationDestination?
    
    var body: some View {
        SecureField("Password", text: $password)
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(30)
            .frame(width: 360, height: 230)
            .multilineTextAlignment(.center)
        Group {
            Button(action: {
                navigationSelection = .mainMenu
                //self.signIn()
            }) {
                Text("Log in")
                    .foregroundColor(.black)
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .frame(height: 70)
                    .background(Color.clear)
                    .padding(.top, 30)
            }
            
            NavigationLink(
                destination: MainMenuView(),
                tag: .mainMenu,
                selection: $navigationSelection,
                label: { EmptyView() }
            )
        }
    }
}

extension Color {
    init(hexString1: String) {
        let scanner = Scanner(string: hexString1)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

//func signIn(){
    //Auth.auth().signIn(withEmail: //username, password: password)
//}
