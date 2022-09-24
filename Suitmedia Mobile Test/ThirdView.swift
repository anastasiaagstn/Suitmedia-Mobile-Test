//
//  ThirdView.swift
//  Suitmedia Mobile Test
//
//  Created by Anastasia Agustine on 24/09/22.
//

import SwiftUI

extension User {
    static let mockData = [
        User(id: 1, email: "email@mail.com", first_name: "John", last_name: "Doe", avatar: "https://xsgames.co/randomusers/assets/avatars/male/8.jpg"),
        User(id: 2, email: "email@mail.com", first_name: "John", last_name: "Doe", avatar: "https://xsgames.co/randomusers/assets/avatars/male/8.jpg"),
        User(id: 3, email: "email@mail.com", first_name: "John", last_name: "Doe", avatar: "https://xsgames.co/randomusers/assets/avatars/male/8.jpg"),
       User(id: 4, email: "email@mail.com", first_name: "John", last_name: "Doe", avatar: "https://xsgames.co/randomusers/assets/avatars/male/8.jpg")]
}

@MainActor
class userModel: ObservableObject{
    
    @Published var users: [User] = [User]()
    @Published var page = 1
    @Published var totalPage = 1
    
    func loadNewData() async {
        if self.page <= self.totalPage{
            guard let url = URL(string: "https://reqres.in/api/users?page=\(self.page)") else {
                print("Url does not work")
                return
            }

            //fetch the data
            do {
                let(data, response) = try await URLSession.shared.data(from: url)

                //decode data handle
                if let decodedData = try? JSONDecoder().decode(UsersData.self, from: data) {
                    self.totalPage = decodedData.total_pages
                    self.users.append(contentsOf: decodedData.data)
                    print(users)
                }
            } catch {
                print("DATA IS INVALID")
            }
        }
    }
}

struct ThirdView: View {
    @ObservedObject var usernameViewModel: SelectedUserViewModel
    @ObservedObject var viewModel = userModel()
    
//    @State private var users = [User]()
    
    var body: some View {
        List(viewModel.users) {user in
            userRowView(userItem: user).onTapGesture {
                usernameViewModel.selectedUser = "\(user.first_name) \(user.last_name)"
            }
        }.task {
            await viewModel.loadNewData()
            print(viewModel.page)
        }
        .refreshable {
            viewModel.page = viewModel.page + 1
            await viewModel.loadNewData()
        }.navigationTitle("Third Screen")
    }
    
    func fetchData() async{
        //get url
        guard let url = URL(string: "https://reqres.in/api/users?page=1") else {
            print("Url does not work")
            return
        }

        //fetch the data
        do {
            let(data, _) = try await URLSession.shared.data(from: url)

            //decode data handle
            if let decodedData = try? JSONDecoder().decode(UsersData.self, from: data) {
                viewModel.users.append(contentsOf: decodedData.data)
                viewModel.totalPage = decodedData.total_pages
//                print(users)
            }
        } catch {
            print("DATA IS INVALID")
        }
    }
    
}

private struct userRowView: View{
    var userItem: User
    var body: some View{
        HStack{
//            AsyncImage(url: URL(string: userItem.avatar))
            AsyncImage(url: URL(string: userItem.avatar)) { image in
                image
                    .resizable()
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)

            VStack(spacing: 5){
                Text("\(userItem.first_name) \(userItem.last_name)")
                    .font(.system(size: 20, weight: .bold))
//                    .frame(width: 200, height: 20, alignment: .leading)
                    .frame(minWidth: 200, maxWidth: 250, alignment: .leading)
                Text("\(userItem.email)")
                    .font(.system(size: 16, weight: .thin))
//                    .frame(width: 200, height: 18, alignment: .leading)
                    .frame(minWidth: 200, maxWidth: 250, alignment: .leading)
            }
        }
        .frame(width: 310, height: 60, alignment: .leading)
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView(usernameViewModel: SelectedUserViewModel())
    }
}
