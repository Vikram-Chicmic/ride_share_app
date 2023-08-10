import SwiftUI



@main
struct BlaBalAppApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
               GoogleMapsProvider.configure()
           }
    @StateObject var vm = LoginSignUpViewModel.shared
    @StateObject var vehicleVm = RegisterVehicleViewModel.shared
    @StateObject var mapVm = MapAndRidesViewModel.shared
    @StateObject var sessionManager = SessionManager.shared
    @StateObject var baseAPiManager = BaseApiManager.shared
    @StateObject var chatVm = ChatViewModel.shared
    
    @State private var isSplashPresented = true // Add a state variable to control the splash screen
    
    var body: some Scene {
        WindowGroup {
                    SplashScreen() // Show the splash screen
            .environmentObject(vm)
            .environmentObject(vehicleVm)
            .environmentObject(mapVm)
            .environmentObject(sessionManager)
            .environmentObject(baseAPiManager)
            .environmentObject(chatVm)
        }
    }
}
