import SwiftUI

struct EditRide: View {
    @State private var navigateToLocationUpdate = false
    @State private var navigateToPriceUpdate = false
    @State private var navigateToDateUpdate = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: MapAndRidesViewModel
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    var options: [Helper.Option] {
        [
            Helper.Option(title: "Itinerary details", destination: AnyView(LocationUpdate()), isPresented: $navigateToLocationUpdate),
            Helper.Option(title: "Price and Seats", destination: AnyView(UpdatePriceAndSeats()), isPresented: $navigateToPriceUpdate),
            Helper.Option(title: "Date and Vehicle", destination: AnyView(DateAndVehicleUpdate()), isPresented: $navigateToDateUpdate)
        ]
    }
    var body: some View {
        VStack {
            ForEach(options, id: \.title) { option in
                Helper().optionButton(for: option).foregroundColor(.black)
                Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.1)).padding(.horizontal)
            }
            Spacer()
        }
        .onAppear {
            if vm.isUpdatedSuccess {
                dismiss()
            }
        }
        .navigationTitle("Update Ride")
    }
}

struct EditRide_Previews: PreviewProvider {
    static var previews: some View {
        EditRide().environmentObject(RegisterVehicleViewModel())
    }
}
