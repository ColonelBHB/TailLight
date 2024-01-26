//
//  ContentView.swift
//  Tail-Opacity
//
//  Created by Patrick Vogel on 1/22/24.
//

import SwiftUI

struct CapsuleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30))
            .bold()
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}
struct ContentView: View {
    @State private var rightTurnOn = false
    @State private var leftTurnOn = false
    @State private var running = false
    @State private var brake = false
    @State private var opacityAmount = 1.0
    
    func tailImage(Light: String, OverlayImage: String, Side: Double) -> some View {
        Image(Light)
            .scaleEffect(x: Side, y: 1.0)
            .overlay(
                Image(OverlayImage)
                    .scaleEffect(x: Side, y: 1.0)
                    .opacity(opacityAmount)
                    .animation(
                        .easeInOut(duration: 0.75)
                        .repeatForever(autoreverses: false),
                        value: opacityAmount
                    )
            )
            .onAppear {
                opacityAmount = 0
            }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button ("Brake") {
                    brake.toggle()
                }
                .modifier(CapsuleText())
                Button ("Running Lights") {
                    running.toggle()
                    opacityAmount = 1.0
                }
                .modifier(CapsuleText())
            }
            HStack {
                Button ("Left Turn Signal") {
                        leftTurnOn.toggle()
                        rightTurnOn = false
                        opacityAmount = 1.0
                }
                .modifier(CapsuleText())
                Button ("Right Turn Signal") {
                        rightTurnOn.toggle()
                        leftTurnOn = false
                        opacityAmount = 1.0
                }
                .modifier(CapsuleText())
            }
            
            HStack {
                if leftTurnOn {
                    if running {
                        tailImage(Light: "Tail-Run", OverlayImage: "Tail-Brake", Side: -1.0)
                    } else {
                        tailImage(Light: "Tail", OverlayImage: "Tail-Brake", Side: -1.0)
                    }
                } else {
                    if running && !brake {
                        Image("Tail-Run")
                            .scaleEffect(x: -1.0, y: 1.0)
                    } else if brake {
                        Image("Tail-Brake")
                            .scaleEffect(x: -1.0, y: 1.0)
                    } else {
                        Image("Tail")
                            .scaleEffect(x: -1.0, y: 1.0)
                    }
                }
                
                if rightTurnOn {
                    if running {
                        tailImage(Light: "Tail-Run", OverlayImage: "Tail-Brake", Side: 1.0)
                    } else {
                        tailImage(Light: "Tail", OverlayImage: "Tail-Brake", Side: 1.0)
                    }
                } else {
                    if running && !brake {
                        Image("Tail-Run")
                            .scaleEffect(x: 1.0, y: 1.0)
                    } else if brake {
                        Image("Tail-Brake")
                            .scaleEffect(x: 1.0, y: 1.0)
                    } else {
                        Image("Tail")
                            .scaleEffect(x: 1.0, y: 1.0)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
