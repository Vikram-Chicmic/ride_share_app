//
//  MessageBubble.swift
//  BlaBalApp
//
//  Created by ChicMic on 13/07/23.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message

    @State var showTime = false
    var sent: Bool { message.senderID != LoginSignUpViewModel.shared.recievedData?.status.data?.id }
    var body: some View {
        VStack(alignment: sent ? .trailing : .leading ) {
            HStack {
                    Text(message.content).foregroundColor(sent ? .white : .black)
            }.onTapGesture {
                withAnimation {
                    showTime.toggle()
                }
               
            }
            .padding()
            .frame( alignment: sent ? .trailing : .leading)
            .background(sent ? Constants.Colors.bluecolor : .gray.opacity(0.2)).cornerRadius(20)
            if showTime {
                  
                Text(Helper().formatDate(message.updatedAt)!).font(.caption).foregroundColor(.gray).onAppear {
                    dismissAfterDelay()
                }
                    .padding(sent ? .trailing : .leading)
            }
                
           
        }.frame(maxWidth: .infinity, alignment: sent ? .trailing : .leading).padding([.top, sent ? .trailing : .leading])
    }
    
    func dismissAfterDelay(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                showTime = false
            }
     
        }
    }
    
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: 1, content: " at fsdffasfsadfasfdasfasdfasfasdfasdfdfasfasdfafasfasdfasdfsadfasdfadsafasfasfsafasfdssfasdfadsfasfadsfadsfadsfadsfadsfassdf dfadsf df dfdsfdfasf d dfasfasdf dsfdf Chicmic.", senderID: 12, receiverID: 22, createdAt: "2023-06-23T06:31:44.279Z", updatedAt: "2023-06-23T06:31:44.279Z", chatID: 455))
    }
}
