//
//  CustomShapeForImage.swift
//  BlaBalApp
//
//  Created by ChicMic on 09/08/23.
//

import Foundation
import SwiftUI
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
