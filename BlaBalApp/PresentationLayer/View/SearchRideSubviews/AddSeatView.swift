//
//  AddSeatView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct AddSeatView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var seat: Int
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @State var temp: Int
    @Binding var isPublishView: Bool
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: Constants.Icons.cross).font(.title2).foregroundColor(Constants.Colors.bluecolor)
            }
                Spacer()
                Button {
                    seat = temp
                    dismiss()
                }label: {
                    Text(Constants.Buttons.done).font(.title2)
                }
            }.padding(.bottom)
            Text(isPublishView ? Constants.Header.publishSeats : Constants.Header.seats).font(.largeTitle).fontWeight(.semibold).padding(.trailing, 50)
            HStack {
                Image(systemName: Constants.Icons.minuscircle).font(.largeTitle).foregroundColor(temp == 1 ? .gray : Constants.Colors.bluecolor).disabled(temp<1).onTapGesture {
                    if temp>1 {
                        temp-=1
                    }
                }
                Spacer()
                Text("\(temp)").font(.largeTitle).bold()
                Spacer()
                Image(systemName: Constants.Icons.pluscircle).font(.largeTitle).foregroundColor(temp==8 ? .gray : Constants.Colors.bluecolor).onTapGesture {
                    if temp<8 {
                        temp+=1
                    }
                }
            }.padding()
            Spacer()
        }.onAppear {
            temp = seat
        }.padding()
    }
}

struct AddSeatView_Previews: PreviewProvider {
    static var previews: some View {
        AddSeatView( seat: .constant(1), temp: 1, isPublishView: .constant(false))
    }
}
