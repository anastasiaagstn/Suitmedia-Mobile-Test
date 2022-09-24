//
//  SecondView.swift
//  Suitmedia Mobile Test
//
//  Created by Anastasia Agustine on 23/09/22.
//

import SwiftUI

struct SecondView: View {
    
    var username: String
    var body: some View {
//        NavigationView{
            VStack{
                Text("Welcome")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 20)
                    .navigationTitle("Second Screen")
                Text("\(username)")
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 20)
                Text("\(userItem.selectedUser)")
                    .font(.system(size: 28, weight: .bold))
                    .frame(height: 500)
                NavigationLink (destination: ThirdView()) {
                    Text("Choose a User")
                        .frame(width: 300, height: 40, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor.opacity(0.7))
                        .cornerRadius(10)
                }
            }
            
//        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(username: "Test")
    }
}
