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
    @State private var output = ""
    
    func go(){
        output = getData()
    }
    
    var body: some View {
        VStack{
            Text("Title")
            TextEditor(text: $output)
                .disabled(true)
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
