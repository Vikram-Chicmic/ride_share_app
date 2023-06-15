//
//  AddImageView.swift
//  BlaBalApp
//
//  Created by ChicMic on 15/06/23.
//

import SwiftUI

struct AddImageView: View {
    @StateObject var vm = AddImageViewModel()
    @State var showImagePicker = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            if let image = vm.selectedImage {
                VStack {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                }

            } else {
                Image(systemName: Constants.Icons.perosncircle).resizable().frame(width: 150, height: 150).foregroundColor(.gray)
                    .clipShape(Circle())
            }
            
            Button("Edit image") {
                showImagePicker.toggle()
            }.sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $vm.selectedImage, showImagePicker: $showImagePicker)
            }
            
            Spacer()
            Button {
                vm.uploadImage()
            } label: {
                Buttons(image: "", text: "Update", color: Constants.Colors.bluecolor)
            }.padding()
                .alert(isPresented: $vm.alert) {
                    
                    vm.success ?  Alert(title: Text("Success"), message: Text("Image Uploaded Successfully"), dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                        dismiss()
                    })) : Alert(title: Text(Constants.Alert.error), message: Text("Error while uploaing Image, try after sometime"), dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                        dismiss()
                    }))
                }
        }.padding(.top).navigationTitle("Add Image")
    }
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageView(vm: AddImageViewModel())
    }
}
