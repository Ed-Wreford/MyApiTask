//
//  ContentView.swift
//  api-task
//
//  Created by Wildman, Leo (RCH) on 17/03/2023.
//

import SwiftUI

let etonBlue = Color("etonBlue")
let niceBlack = Color("niceBlack")
let uv = Color("uv")
let plum = Color("plum")


struct ContentView: View {
    @State private var output = "Kanye Quote"
    @StateObject private var state = StateController()
    
    func go(){
        state.getData()
        output = "Original: \(state.quote)\n\nAi Response: \(getai(quote:state.quote))"
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Ye")
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 5.0)
                    .foregroundColor(niceBlack)
                Spacer()
            }
            
            VStack{
                TextEditor(text: $output)
                    .font(.caption)
            }
            .frame(minWidth: 0, maxWidth: 250)
            .disabled(true)
            .foregroundColor(etonBlue)
            .shadow(radius: 10)
            .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(niceBlack, lineWidth: 5)
                    )
            
            
            Spacer()
            Button(action: {
                go()
            }) {
                HStack {
                    Image(systemName: "target")
                    Text("Go!")
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [uv, plum]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
