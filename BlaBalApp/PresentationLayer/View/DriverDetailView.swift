//
//  DriverDetailView.swift
//  BlaBalApp
//
//  Created by ChicMic on 29/06/23.
//

import SwiftUI

struct DriverDetailView: View {
    var data: DecodeUser
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    var rideData: AllPublishRideData?
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
                     case .failure:
                         // Show placeholder for failed image load
                         Image("Cathy").resizable().scaledToFit().frame(width: 80).clipShape(Circle())
                     }
                 }
             } else {
                 Image("Cathy").resizable().scaledToFit().frame(width: 80).clipShape(Circle())
             }
               
                VStack(alignment: .leading) {
                    Text(data.user.firstName+" "+data.user.lastName).font(.title).bold()
                }.padding(.leading)
                Spacer()
           
            }.frame(height: 80)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                VStack(spacing: 10) {
                    //MODEL
                    RideDetailTileView(title: "Phone Number", value: data.user.phoneNumber ?? "xxxxxxxxxx")
                    RideDetailTileView(title: "Email", value: String(data.user.email))
                    RideDetailTileView(title: "Bio", value: data.user.bio)
                    RideDetailTileView(title: "User Since", value: Helper().formatDate(data.user.createdAt) ?? "2023-06-27T11:00:23.662Z")
                }.padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            HollowButton(image: "message.badge", text: "Chat Now", color: Constants.Colors.bluecolor).onTapGesture {
                chatVm.receiverId = data.user.id
                
                chatVm.apiCall(mehtod: .createChatRoom)
                
            }
            .navigationDestination(isPresented: $chatVm.chatRoomSuccessAlert, destination: {
                ChatView(recieverImage: data.imageURL, reciverName: data.user.firstName+" "+data.user.lastName, source: rideData?.source, destination: rideData?.destination, date: rideData?.updatedAt)
                 
            })
            .navigationDestination(isPresented: $chatVm.chatRoomFailAlert, destination: {
                ChatView(recieverImage: data.imageURL, reciverName: data.user.firstName+" "+data.user.lastName, source: rideData?.source, destination: rideData?.destination, date: rideData?.updatedAt)
            })
            // first button create chat room than change it to chat now
            .alert(isPresented: $chatVm.notFoundErrorAlert) {
                Alert(title: Text("Error"), message: Text("Fail to create a chat room"), dismissButton: .cancel(Text(Constants.Buttons.ok)))
         
            }
            Spacer()
        }.padding()
            .navigationTitle("Driver Details")
   
        
    }
}

struct DriverDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DriverDetailView(data: DecodeUser(code: 200, user: DecodeUserData(id: 155, email: "hriday@gmail.com", createdAt: "2023-05-26T09:36:26.594Z", updatedAt: "2023-06-12T12:48:16.403Z", jti: "d701293b-4525-4b7b-99ac-9ba75a0689da", firstName: "Hriday", lastName: "Garg", dob: "2005-05-25", title: "Male", phoneNumber: nil, bio: "fwegernrtwjwrkjw", travelPreferences: nil, postalAddress: nil, activationDigest: "$2a$12$VQkYl5MGWbhzJITwzmB8UOlEeL8LmBzs4/IfJ33.tnakaM7otPOA2", activated: false, activatedAt: nil, activateToken: "ZQKswFebAKCrehPtKQk6ig", sessionKey: nil, averageRating: nil, otp: 0, phoneVerified: false), imageURL: nil))
    }
}
