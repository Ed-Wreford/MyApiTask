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
    
    func getData() -> String {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, respomse, error) in
            if let data = data {
                if let response = self.parseJson(json: data) {
                    let names = response.results.map {
                        return $0.name
                    }
                    DispatchQueue.main.async {
                        self.artistsByLocation = names.joined(separator: ", ")
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
