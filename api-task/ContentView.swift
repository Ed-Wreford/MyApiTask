//
//  ContentView.swift
//  api-task
//
//  Created by Wildman, Leo (RCH) on 17/03/2023.
//

import SwiftUI

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
                    Image(systemName: "highlighter")
                    Text("Go!")
                }
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .frame(maxWidth: .infinity)
                .padding()
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
