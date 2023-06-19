//
//  CircleProgressView.swift
//  BlaBalApp
//
//  Created by ChicMic on 19/06/23.
//

import SwiftUI

/// progress bar view for showing
/// process or loading action
struct CircleProgressView: View {
    
    // MARK: - properties

    @EnvironmentObject var vm: LoginSignUpViewModel
    
    // MARK: - body
    
    var body: some View {
    
        // show progress view if inProgress in
        // baseViewModel is set to true
        if vm.isLoading {
            VStack {
                Spacer()
                ProgressView()
                    .frame(maxWidth: .infinity)
                Spacer()
            }
            .background(.gray.opacity(0.25))
        }
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressView()
            .environmentObject(LoginSignUpViewModel())
    }
}
