//
//  ContentView.swift
//  Suitmedia Mobile Test
//
//  Created by Anastasia Agustine on 23/09/22.
//

import SwiftUI


struct FirstView: View {
    @State var usernameViewModel : SelectedUserViewModel = SelectedUserViewModel()
    @State private var usernameInput: String = ""
    @State private var textInput: String = ""
    @State private var showAlert = false
    var isPalindrome = false
    var body: some View {
        NavigationView{
            VStack{
                TextField("Name", text: $usernameInput)
                    .padding()
                    .frame(width: 300, height: 40)
    //                .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray)
                    )
                    
                TextField("Palindrome", text: $textInput)
                    .padding()
                    .frame(width: 300, height: 40)
    //                .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray)
                    )
                Spacer()
                    .frame(height: 40)
                Button("CHECK"){
                    showAlert.toggle()
                    
                }
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: 300, height: 40)
                    .background(Color.accentColor.opacity(0.7))
                    .cornerRadius(10)
                    .alert("Palindrome Checker", isPresented: $showAlert){} message: {
                        Text("\(textInput)\(checkPalindrome(text:textInput))")
                    }
                    
                
                NavigationLink(destination: SecondView(usernameViewModel: usernameViewModel, username: usernameInput), label: {
                    Text("NEXT")
                        .frame(width: 300, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor.opacity(0.7))
                        .cornerRadius(10)
                })
            }
            .navigationTitle("First Screen")
            .offset(y: -40)
        
        }
    }
    
    func checkPalindrome(text: String) -> String {
        let characters = Array(text.lowercased())
        var count = 0
        if characters.isEmpty {
            return "Please Input a Character"
        }
        while count < characters.count/2{
            if characters[count] != characters[characters.count - (count + 1)] {
                return ": Not palindrome"
            }
            count += 1
        }
        return ": Is palindrome"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
