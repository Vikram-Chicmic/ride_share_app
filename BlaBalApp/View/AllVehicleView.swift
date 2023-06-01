//
//  AllVehiclePage.swift
//  BlaBalApp
//
//  Created by ChicMic on 01/06/23.
//

import SwiftUI

struct AllVehicleView: View {
    @ObservedObject var vm: RegisterVehicleViewModel
    var body: some View {
        VStack {
            Text(String(vm.decodedData?.data.count ?? 0))
            List {
                    if let data = vm.decodedData?.data {
                        ForEach(data.indices, id: \.self) { index in
                            Text(data[index].vehicleBrand).padding(.vertical)
                        }
                    }
            }
        }.onAppear {
            vm.isRegistering = false
            vm.registerVehicle()
        }.onDisappear {
            vm.decodedData = nil
        }
    }
}

struct AllVehiclePage_Previews: PreviewProvider {
    static var previews: some View {
        AllVehicleView(vm: RegisterVehicleViewModel())
    }
}
