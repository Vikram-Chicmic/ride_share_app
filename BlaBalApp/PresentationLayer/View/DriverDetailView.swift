//
//  DriverDetailView.swift
//  BlaBalApp
//
//  Created by ChicMic on 29/06/23.
//

import SwiftUI

struct DriverDetailView: View {
    var data: DecodeUser
    @EnvironmentObject var chatVm: ChatViewModel
    var body: some View {
        VStack(spacing: 20) {
            HStack {
            
          
                if let imageURL = URL(string: data.imageURL ?? "") {
                 AsyncImage(url: imageURL) { phase in
                     switch phase {
                     case .empty:
                         ProgressView()
                             .progressViewStyle(CircularProgressViewStyle())
                     case .success(let image):
                         image.resizable().frame(width: 80).clipShape(Circle()).scaledToFit()
                     case .failure(_):
                         // Show placeholder for failed image load
                         Image("Cathy").resizable().scaledToFit().frame(width: 80).clipShape(Circle())
                     }
                 }
             } else {
                 Image("Cathy").resizable().scaledToFit().frame(width: 80).clipShape(Circle())
             }
               
                VStack(alignment: .leading) {
                    Text(data.user.firstName+data.user.lastName).font(.title).bold()
                }.padding(.leading)
                Spacer ()
           
            }.frame(height: 80)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(20)
                VStack(spacing: 10) {
                    //MODEL
                    RideDetailTileView(title: "Phone Number", value: data.user.phoneNumber ?? "xxxxxxxxxx")
                    RideDetailTileView(title: "Email", value: String(data.user.email))
                    RideDetailTileView(title: "Bio", value: data.user.bio)
                    RideDetailTileView(title: "User Since", value: Helper().formatDate(data.user.createdAt) ?? "2023-06-27T11:00:23.662Z")
                }.padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(20)
            
            HollowButton(image: "message.badge", text: "Initiate Chat", color: Constants.Colors.bluecolor).onTapGesture {
                chatVm.receiverId = data.user.id
                chatVm.apiCall(mehtod: .createChatRoom)
            }
            .alert(isPresented: $chatVm.chatRoomSuccessAlert) {
                Alert(title: Text("Success"), message: Text("Chat room has been created successfully. You can contact the driver through chat section."),dismissButton: .cancel(Text(Constants.Buttons.ok)))
            }
            .alert(isPresented: $chatVm.chatRoomFailAlert) {
                Alert(title: Text("Error"), message: Text("Chat room has been created already. You can contact the driver through chat section."),dismissButton: .cancel(Text(Constants.Buttons.ok)))
            }
            Spacer()
        }.padding().background(Color.gray.opacity(0.1)).cornerRadius(20)
            .navigationTitle("Driver Details")
   
        
    }
}

struct DriverDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DriverDetailView(data: DecodeUser(code: 200, user: DecodeUserData(id: 155, email: "hriday@gmail.com", createdAt: "2023-05-26T09:36:26.594Z", updatedAt: "2023-06-12T12:48:16.403Z", jti: "d701293b-4525-4b7b-99ac-9ba75a0689da", firstName: "Hriday", lastName: "Garg", dob: "2005-05-25", title: "Male", phoneNumber: nil, bio: "fwegernrtwjwrkjw", travelPreferences: nil, postalAddress: nil, activationDigest: "$2a$12$VQkYl5MGWbhzJITwzmB8UOlEeL8LmBzs4/IfJ33.tnakaM7otPOA2", activated: false, activatedAt: nil, activateToken: "ZQKswFebAKCrehPtKQk6ig", sessionKey: nil, averageRating: nil, otp: 0, phoneVerified: false), imageURL: nil))
    }
}
