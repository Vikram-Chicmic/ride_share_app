//
//  AllVehiclePage.swift
//  BlaBalApp
//
//  Created by ChicMic on 01/06/23.
//

import SwiftUI

struct AllVehicleView: View {
    @StateObject var vm = RegisterVehicleViewModel()
    var body: some View {
        VStack {
            
            List {
                if let data = vm.decodedVehicleData?.data {
                    ForEach(data.indices, id: \.self) { index in
                        HStack {
                            Image("car2").resizable().frame(width: 80, height: 80).padding(.trailing)
                            Spacer()
                            Text(data[index].vehicleBrand)
                            Spacer()
                            Spacer()
                        }
                    }
                } else { }
            }.listStyle(.plain)
            
           
            
            
//            List {
//                    if let data = vm.decodedData?.data {
//                        ForEach(data.indices, id: \.self) { index in
//
//                            HStack{
//                                Image("car").resizable().frame(width: 100, height: 100)
//                                Text(data[index].vehicleBrand).padding(.vertical)
//                            }
//
//                        }
//                    }
//            }
        }.navigationTitle("Your Vehicles")
            .onAppear {
            vm.isRegistering = false
            vm.registerVehicle()
        }.onDisappear {

        }
    }
}

struct AllVehiclePage_Previews: PreviewProvider {
    static var previews: some View {
        AllVehicleView(vm: RegisterVehicleViewModel())
    }
}
