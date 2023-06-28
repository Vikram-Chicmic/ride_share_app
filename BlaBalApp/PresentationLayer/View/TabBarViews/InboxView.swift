//
//  InboxView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct InboxView: View {
    @State var message: String = ""
    @State var sendMsgArr: [String] = ["Hello", "How are you", "What are you doing"]
    @State var recievedMsgArr: [String] = ["HI", "I am fine", "Nothing"]
    var body: some View {
//        VStack {
//            HStack {
//                Text(Constants.Labels.inbox).font(.largeTitle).fontWeight(.semibold)
//                Spacer()}
//            Text(Constants.Texts.nomsg).padding(.vertical)
//            Spacer()
//        }.padding()
        
        
        VStack {
          
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                    ForEach(recievedMsgArr, id: \.self) { msg in
                        HStack{
                            Text(msg).padding().background(.cyan).cornerRadius(20)
                            Spacer()
                        }.padding(.horizontal)
                     
                    }
                    ForEach(sendMsgArr, id: \.self) { msg in
                        HStack{
                            Spacer()
                            Text(msg).padding().background(.blue).cornerRadius(20)
                            
                        }.padding(.horizontal)
                     
                    }
                }.frame(height: 620)
                
            }.scrollIndicators(.hidden)
            HStack {
                CustomTextfield(label: "", placeholder: "type message here", value: $message).padding(.bottom, 11)
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45)
                    .foregroundColor(.blue)
                    .background(.white)
                    .clipShape(Circle()).onTapGesture {
                        if !message.isEmpty {
                            sendMsgArr.append(message)
                        }
                   
                    message = ""
                }
            }
           
        }
        
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
