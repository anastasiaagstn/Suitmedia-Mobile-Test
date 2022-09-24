//
//  Model.swift
//  Suitmedia Mobile Test
//
//  Created by Anastasia Agustine on 24/09/22.
//

import Foundation

class SelectedUserViewModel: ObservableObject {
    @Published var selectedUser: String = "Selected User Name"
}

struct UsersData: Codable{
    var total_pages: Int
    var data: [User]
}

struct User: Codable, Identifiable{
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
    var avatar: String

}

//struct User: Identifiable {
//    var id: Int
//    var email: String
//    var first_name: String
//    var last_name: String
//    var avatar: String
//}
