//
//  ImageView.swift
//  BlaBalApp
//
//  Created by ChicMic on 23/05/23.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        ImageViewMainContent(size: 120)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}

struct ImageViewMainContent: View {
    @State private var imageLoadFailed = false
    @State var addImageViewNavigate: Bool = false
    @EnvironmentObject var vm: LoginSignUpViewModel
    var size: CGFloat
    var body: some View {
            VStack {
                    StrokeShape(size: size)
                        .fill(.cyan)
                        .frame(width: size, height: size).overlay(alignment: .center) {
                        
                          

                            if let imageURLString = vm.recievedData?.status.imageURL,
                               let imageURL = URL(string: imageURLString) {
                                AsyncImage(url: imageURL) { phase in
                                    switch phase {
                                    case .empty:
                                        // Show placeholder while loading
                                        Image(systemName: Constants.Icons.perosncircle)
                                            .resizable()
                                            .rotationEffect(Angle(degrees: -20))
                                            .clipShape(ImageShape(imageSize: size - (size/10)))
                                            .frame(width: size - (size/10), height: size - (size/10))
                                            .foregroundColor(.white)
                                    case .success(let image):
                                        // Show the loaded image
                                        image
                                            .resizable()
                                            .rotationEffect(Angle(degrees: -20))
                                            .clipShape(ImageShape(imageSize: size - (size/10)))
                                            .frame(width: size - (size/10), height: size - (size/10))
                                    case .failure(_):
                                        // Show placeholder for failed image load
                                        Image(systemName: Constants.Icons.perosncircle)
                                            .resizable()
                                            .rotationEffect(Angle(degrees: -20))
                                            .clipShape(ImageShape(imageSize: size - (size/10)))
                                            .frame(width: size - (size/10), height: size - (size/10))
                                            .foregroundColor(.white)
                                    }
                                }
                            } else {
                                Image(systemName: Constants.Icons.perosncircle)
                                    .resizable()
                                    .rotationEffect(Angle(degrees: -20))
                                    .clipShape(ImageShape(imageSize: size - (size/10)))
                                    .frame(width: size - (size/10), height: size - (size/10))
                                    .foregroundColor(.white)
                            }

                            
                            
                        }
                        
                        .rotationEffect(Angle(degrees: 20))
                    .overlay(alignment: .bottomTrailing) {
                        
                        Button {
                            addImageViewNavigate.toggle()
                        } label: {
                            Circle().fill(Color(red: 0.94, green: 0.55, blue: 0.55)).frame(width: size/5, height: size/5).overlay {
                                Image(systemName: Constants.Icons.pencil).font(.system(size: size/10)).foregroundColor(.white)
                        }
                        
                       
                        }.padding(.trailing, size/10).padding(.bottom, -(size/33))
                    }
            }.navigationDestination(isPresented: $addImageViewNavigate) {
                AddImageView()
            }

    }
}


struct StrokeShape: Shape {
    
    var size: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = size/2
        let center = CGPoint(x: radius, y: radius)
        
        let center2 = CGPoint(x: size - (size * 0.09), y: size - (size * 0.2))
        let radius2 = radius / 4.1
        
        path.addArc(center: center, radius: radius, startAngle: .degrees(58.4), endAngle: .degrees(15), clockwise: false)
        
        path.addArc(center: center2, radius: radius2, startAngle: .degrees(296), endAngle: .degrees(137), clockwise: true)
        
        return path
        
    }
    
    
}

struct ImageShape: Shape {
    
    var imageSize: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = imageSize / 2
        let center = CGPoint(x: radius, y: radius)
        
        
        let center2 = CGPoint(x: imageSize - (imageSize * 0.09), y: imageSize - (imageSize * 0.2))
        let radius2 = radius / 3.5
        
        path.addArc(center: center, radius: radius, startAngle: .degrees(53.4), endAngle: .degrees(20), clockwise: false)
        
        path.addArc(center: center2, radius: radius2, startAngle: .degrees(296), endAngle: .degrees(137), clockwise: true)
        
        return path
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.showImagePicker = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.showImagePicker = false
        }
    }
}
