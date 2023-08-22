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
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    var body: some View {
        VStack(alignment: .leading) {
            Text("Inbox").font(.title).fontWeight(.semibold).padding(.leading).padding(.top)
            Rectangle().frame(height: 3).foregroundColor(.gray.opacity(0.2))
            
           Spacer()
                if let data = chatVm.allChats {
                    if data.count > 0 {
                        ScrollView {
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
                                     case .failure:
                                         // Show placeholder for failed image load
                                         Image("Cathy").resizable().scaledToFit().frame(width: 50).clipShape(Circle())
                                     @unknown default:
                                         fatalError("")
                                     }
                                 }
                             } else {
                                 Image("Cathy").resizable().scaledToFit().frame(width: 50).clipShape(Circle())
                             }
                                
                                VStack(alignment: .leading) {
                                    Text(data[index].receiver.firstName + " " + data[index].receiver.lastName).fontWeight(.semibold).padding(.leading)
                                    HStack {
                                        Text(data[index].publish?.source ?? "unable to fetch").font(.subheadline)
                                        Image(systemName: Constants.Icons.arrowRight)
                                        Text(data[index].publish?.destination ?? "unable to fetch").font(.subheadline)
                                    }.padding(.leading)
                                        .foregroundColor(.gray)
                                }
                                
                                
                                Spacer()
                            }.padding(.horizontal).frame(height: 60)
                            .onTapGesture {
                                    chatVm.chatId = data[index].id
                                chatVm.receiverId = data[index].receiverID
                                    self.indexToSend = index
                                    openChat.toggle()
                                    
                            }
                            .navigationDestination(isPresented: $openChat) {
                                ChatView(recieverImage: data[indexToSend ?? 0].receiverImage,
                                         reciverName: data[indexToSend ?? 0].receiver.firstName + " " + data[indexToSend ?? 0].receiver.lastName,
                                         source: data[indexToSend ?? 0].publish?.source,
                                         destination: data[indexToSend ?? 0].publish?.destination,
                                         date: data[indexToSend ?? 0].publish?.updatedAt)
                      
//                                ChatView(recieverImage: data[indexToSend ?? 0].receiverImage, reciverName: data[indexToSend ?? 0].receiver.firstName + " " + data[indexToSend ?? 0].receiver.lastName, source:data[index].publish?.source, destination: data[index].publish?.destination, date: data[index].publish?.updatedAt)
                            }
                            
                            Divider().padding(.horizontal)
                        }
                        
                    }.refreshable {
                        chatVm.apiCallForChat(mehtod: .getAllChatRoom)
                    }
                } else {
                    HStack {
                        Spacer()
                        VStack {
                            Image("chat").resizable().frame(width: 150, height: 150)
                            Text("No chat found").fontWeight(.semibold).font(.title2)
                        }
                        
                        Spacer()
                    }
                 // changes made here
                }
                } else {
                    HStack {
                        Spacer()
                        VStack {
                            Image("chat").resizable().frame(width: 150, height: 150)
                            Text("No chat found").fontWeight(.semibold).font(.title2)
                        }
                        
                        Spacer()
                    }
                 
                }
            Spacer()
            
        }.overlay(
            VStack {
                if chatVm.isLoading {
                    Spacer() // Push the ProgressView to the top
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                Spacer() // Push the following content to the bottom
                if chatVm.showToast {
                    CustomAlert(text: chatVm.toastMessage, dismiss: $chatVm.showToast)
                        .onAppear {
                            // Automatically hide the toast message after a delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    chatVm.showToast = false
                                }
                                
                            }
                        }
                        .animation(.easeInOut)
                }
            }
        ).onAppear {
            chatVm.apiCallForChat(mehtod: .getAllChatRoom)
            LoginSignUpViewModel.shared.decodeData()
            print(LoginSignUpViewModel.shared.recievedData)
        }
        }
        
    }



struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView().environmentObject(ChatViewModel())
    }
}
