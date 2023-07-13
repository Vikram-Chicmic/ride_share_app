//
//  InboxView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct InboxView: View {
    @EnvironmentObject var chatVm: ChatViewModel
    @State var openChat = false
    @State var indexToSend: Int?
    var body: some View {
        VStack(alignment: .leading) {
            Text("Inbox").font(.title).fontWeight(.semibold).padding(.leading).padding(.top)
            Rectangle().frame(height: 3).foregroundColor(.gray.opacity(0.2))
            ScrollView {
                if let data = chatVm.allChats {
                    if data.count > 0 {
                        ForEach(data.indices, id: \.self) { index in
                            HStack {
                         
                                if let imageURL = URL(string: data[index].receiverImage ?? "") {
                                 AsyncImage(url: imageURL) { phase in
                                     switch phase {
                                     case .empty:
                                         ProgressView()
                                             .progressViewStyle(CircularProgressViewStyle()).frame(width: 50).clipShape(Circle())
                                     case .success(let image):
                                         image.resizable().frame(width: 50).clipShape(Circle()).scaledToFit()
                                     case .failure(_):
                                         // Show placeholder for failed image load
                                         Image("Cathy").resizable().scaledToFit().frame(width: 50).clipShape(Circle())
                                     }
                                 }
                             } else {
                                 Image("Cathy").resizable().scaledToFit().frame(width: 50).clipShape(Circle())
                             }
                                Text(data[index].receiver.firstName + " " + data[index].receiver.lastName).fontWeight(.semibold).padding(.leading)
                                Spacer()
                            }.padding(.horizontal).frame(height: 60)
                            .onTapGesture {
                                    chatVm.chatId = data[index].id
                                    chatVm.receiverId = data[index].receiverID
                                    self.indexToSend = index
                                    openChat.toggle()
                                    
                            }
                            .navigationDestination(isPresented: $openChat) {
                                ChatView(recieverImage: data[indexToSend ?? 0].receiverImage, reciverName: data[indexToSend ?? 0].receiver.firstName + " " + data[indexToSend ?? 0].receiver.lastName)
                            }
                            
                            Divider().padding(.horizontal)
                        }
                        
                    } else {
                       Text("You have no chats.")
                    }
                    
                } else {
                    Text("all chats is nil")
                }
            }.refreshable {
                chatVm.apiCall(mehtod: .getAllChatRoom)
            }
            Spacer()
        }.onAppear {
            chatVm.apiCall(mehtod: .getAllChatRoom)
        }
        }
        
    }


struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView().environmentObject(ChatViewModel())
    }
}
