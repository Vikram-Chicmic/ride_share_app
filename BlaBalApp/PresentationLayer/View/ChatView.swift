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
    @State var messageTosend = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: ChatViewModel
    var body: some View {
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
            Rectangle().frame(height: 3).foregroundColor(.gray.opacity(0.2))
            
            
            ScrollView {
                if let messages  =  vm.allMessages?.reversed() {
                    ForEach(messages.indices, id: \.self) { index in
                        MessageBubble(message: messages[index]).padding(.top, -10)
                    }
                }
                
            }//            .scrollIndicators(.hidden)
//                .refreshable {
//                    vm.apiCall(mehtod: .recieveMessage)
//                }
            
            
            
            
            
            Spacer()
            HStack {
                TextField("Type something ....", text: $messageTosend).padding().background {
                    Color.gray.opacity(0.2).cornerRadius(25)
                }.padding(.leading)
                Button {
                    vm.message = messageTosend
                    messageTosend = ""
                    vm.apiCall(mehtod: .sendMessage)
                    vm.apiCall(mehtod: .recieveMessage)
                } label: {
                    Image(systemName: "paperplane.circle.fill").font(.system(size: 45)).padding(.trailing, 10)
                }

            }.padding(.bottom)
            
        }.onAppear {
            vm.apiCall(mehtod: .recieveMessage)
            vm.allMessages?.sort { $0.updatedAt < $1.updatedAt }
        }.navigationBarBackButtonHidden(true)

    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(ChatViewModel())
    }
}
