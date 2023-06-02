//
//  AnimatedImage.swift
//  BlaBalApp
//
//  Created by ChicMic on 02/06/23.
//

import SwiftUI


struct ContentView1: View {
    @State private var offset: CGSize = .zero
    @State private var isMovingRight: Bool = true
    
    var body: some View {
        Image("car")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .offset(offset)
            .onAppear {
                animate()
            }
    }
    
    private func animate() {
        let animationDuration: TimeInterval = 0.5 // Duration for each leg of the movement
        let totalDistance: CGFloat = 300 // Total distance to move
        
        withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
            self.offset.width = isMovingRight ? totalDistance : -totalDistance
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            self.isMovingRight.toggle()
            self.offset.width = 0.0
            animate()
        }
    }
}



struct AnimatedImage: View {
    @State private var imageIndex: Int = 0
    let imageNames: [String]

    var body: some View {
        Group {
            Image(imageNames[imageIndex])
                .resizable()
                .scaledToFit()
        }
        .onAppear {
            animate()
        }
    }

    private func animate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.025) {
            withAnimation {
                if self.imageIndex < self.imageNames.count - 1 {
                    self.imageIndex += 1
                } else {
                    self.imageIndex = 0
                }
                animate()
            }
        }
    }
}




struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
