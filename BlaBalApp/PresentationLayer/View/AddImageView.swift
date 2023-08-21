//
//  AddImageView.swift
//  BlaBalApp
//
//  Created by ChicMic on 15/06/23.
//

import SwiftUI

struct AddImageView: View {
    @StateObject var vm = AddImageViewModel()
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @EnvironmentObject var vmm: LoginSignUpViewModel
    @State var showImagePicker = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                if let image = vm.selectedImage {
                    VStack {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                } else {
                  
                    if let imageURLString = vmm.recievedData?.status.imageURL,
                       let imageURL = URL(string: imageURLString) {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle()).frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                
                            case .failure:
                                // Show placeholder while loading
                                Image(systemName: Constants.Icons.perosncircle)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                            case .success(let image):
                                // Show the loaded image
                                image
                                    .resizable()
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                       
                            @unknown default:
                                fatalError()
                            }
                        }
                    } else {
                        Image(systemName: Constants.Icons.perosncircle)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                }
                Button("Edit image") {
                    showImagePicker.toggle()
                }.sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $vm.selectedImage, showImagePicker: $showImagePicker)
                }
                
                Spacer()
                if vm.selectedImage != nil {
                    Button {
                        vm.uploadImage()
                    } label: {
                        Buttons(image: "", text: "Update", color: Constants.Colors.bluecolor)
                    }.padding()
                        .alert(isPresented: $vm.alert) {
                            vm.success ?  Alert(title: Text(Constants.Alert.success), message: Text(Constants.Errors.imageUploadSuccess), dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                                dismiss()
                            })) : Alert(title: Text(Constants.Alert.error), message: Text(Constants.Errors.errorUploadImage), dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                                dismiss()
                            }))
                        }
                }
          
            }.opacity(vm.isLoading ? 0.5 : 1.0).padding(.top).navigationTitle("Add Image")
            if vm.isLoading {
                ProgressView().progressViewStyle(.circular)
            }
        }
    }
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageView(vm: AddImageViewModel()).environmentObject(LoginSignUpViewModel())
    }
}
