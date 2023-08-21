//
//  CustomBackgroundShape.swift
//  BlaBalApp
//
//  Created by ChicMic on 18/08/23.
//


import SwiftUI
import UIKit


class CustomShapeView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        
        // Define the shape's path
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.minY), controlPoint1: CGPoint(x: rect.minX, y: rect.maxY), controlPoint2: CGPoint(x: rect.minX, y: rect.midY))
        
        // Fill the shape
        UIColor.blue.setFill()
        path.fill()
    }
}

struct CustomShapeViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> CustomShapeView {
        return CustomShapeView()
    }
    
    func updateUIView(_ uiView: CustomShapeView, context: Context) {
        // Update the view if needed
    }
}
