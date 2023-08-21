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

struct ImageViewMainContent: View {
    @State private var imageLoadFailed = false
    @State var addImageViewNavigate: Bool = false
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
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
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
                                    case .success(let image):
                                        // Show the loaded image
                                        image
                                            .resizable()
                                            .rotationEffect(Angle(degrees: -20))
                                            .clipShape(ImageShape(imageSize: size - (size/10)))
                                            .frame(width: size - (size/10), height: size - (size/10))
                                    case .failure:
                                        // Show placeholder for failed image load
                                        Image(systemName: Constants.Icons.perosncircle)
                                            .resizable()
                                            .rotationEffect(Angle(degrees: -20))
                                            .clipShape(ImageShape(imageSize: size - (size/10)))
                                            .frame(width: size - (size/10), height: size - (size/10))
                                            .foregroundColor(.white)
                                    @unknown default:
                                        fatalError("")
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


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
