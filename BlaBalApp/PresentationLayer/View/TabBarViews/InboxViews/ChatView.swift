//
//  ChatView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/07/23.
//

import SwiftUI

struct ChatView: View {
    var recieverImage: String?
    var reciverName: String?
//    var chatFor: Chat?
    var source: String?
    var destination: String?
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @State var showSendButton = false
    var date: String?
    @State var messageTosend = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: ChatViewModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            VStack {
                
            
            HStack {
                Image(systemName: Constants.Icons.back).onTapGesture { dismiss() }
                if let imageURL = URL(string: recieverImage ?? "") {
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
                Text(reciverName ?? "").fontWeight(.semibold).padding(.leading)
                Spacer()
            }.padding(.horizontal).frame(height: 60)
            
            
            
            VStack(alignment: .center,spacing: 5) {
                HStack {
                    Text("\(source ?? "")")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(2) // Allow a maximum of two lines
                        .frame(minWidth: 0, maxWidth: .infinity) // Expand to fill available space
                    
                    Image(systemName: Constants.Icons.arrowRight)
                        .foregroundColor(.gray)
                    
                    Text("\(destination ?? "")")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(2) // Allow a maximum of two lines
                        .frame(minWidth: 0, maxWidth: .infinity) // Expand to fill available space
                }
                Text("\(Helper().formatDateToMMM(date ?? "", dateFormat: Constants.Date.estimatedTimeformat))").foregroundColor(.gray).font(.subheadline)
            }.padding()
                .frame(maxHeight: 40)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Rectangle().frame(height: 3).foregroundColor(.gray.opacity(0.2))
            
            ScrollView {
                if let messages  =  vm.allMessages?.reversed() {
                    ForEach(messages.indices, id: \.self) { index in
                        MessageBubble(message: messages[index]).padding(.top, -10)
                    }
                }
                
            }.scrollIndicators(.hidden)
                .refreshable {
                    vm.apiCallForChat(mehtod: .recieveMessage)
                }
            
            
            }.onTapGesture {
                hideKeyboard()
            }
            
            
            Spacer()
            HStack {
                TextField("Type something ....", text: $messageTosend)
                    .padding().background {
                    Color.gray.opacity(0.2).cornerRadius(25)
                }.padding(.leading)
                    Button {
                        vm.message = messageTosend
                        messageTosend = ""
                        vm.apiCallForChat(mehtod: .sendMessage)
                        vm.apiCallForChat(mehtod: .recieveMessage)
                    } label: {
                        Image(systemName: "paperplane.circle.fill").font(.system(size: 45)).padding(.trailing, 10)
                    }
                    
                
            }.padding(.bottom)
            
        }.overlay(
            VStack {
                if vm.isLoading {
                    Spacer() // Push the ProgressView to the top
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                Spacer() // Push the following content to the bottom
                if vm.showToast {
                    CustomAlert(text: vm.toastMessage, dismiss: $vm.showToast)
                        .onAppear {
                            // Automatically hide the toast message after a delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    vm.showToast = false
                                }
                                
                            }
                        }
                        .animation(.easeInOut)
                }
            }
        ).onReceive(timer) { _ in
            vm.apiCallForChat(mehtod: .recieveMessage)
        }.onAppear {
            vm.apiCallForChat(mehtod: .recieveMessage)
            vm.allMessages?.sort { $0.updatedAt < $1.updatedAt }
        }.navigationBarBackButtonHidden(true)

    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(ChatViewModel())
    }
}
