//
//  SearchView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct SearchView: View {
    @State var isPublishView = false
    @State var showAlert = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("carpoolIcon").resizable().frame(width: 50,height: 50).scaledToFit()
                Text("Car Pool").font(.title2).fontWeight(.semibold).padding(.leading)
                Spacer()
            }.padding(.horizontal)
            
                    Rectangle().frame(height: 3).foregroundColor(.gray.opacity(0.2))
            ScrollView {
                LocationView(isPublishView: $isPublishView, isComingFromPublishedView: .constant(false), showAlert: $showAlert)
                Spacer()
                if showAlert {
                    CustomAlert(text: Constants.Alert.emptyfield, dismiss:$showAlert)
                }

            }
                }
            .onTapGesture {
                self.hideKeyboard()
            }

        

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
