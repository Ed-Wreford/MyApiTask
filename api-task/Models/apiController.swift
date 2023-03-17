//
//  apiController.swift
//  api-task
//
//  Created by Wildman, Leo (RCH) on 17/03/2023.
//

import Foundation

struct KanyeResponse:Codable {
    var quote: String
}

//To DO


class StateController: ObservableObject {
    
    @Published var quote:String = ""
    
    func getData(){
        let url = URL(string: "https://api.kanye.rest/")!
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let response = self.parseJson(json: data) {
                    DispatchQueue.main.async {
                        self.quote = response.quote
                    }
                }
            }
        }.resume()
    }

    func parseJson(json: Data) -> KanyeResponse? {
        let decoder = JSONDecoder()
        
        if let kanyeResponse = try? decoder.decode(KanyeResponse.self, from: json) {
            return kanyeResponse
        } else {
            print("Error decoding JSON")
            return nil
        }
    }
    
}
