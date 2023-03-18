//
//  Ai.swift
//  api-task
//
//  Created by Wildman, Leo (RCH) on 17/03/2023.
//

import Foundation

public var cooldown: Date? = nil

struct OpenAIResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
}

struct Choice: Codable {
    let text: String
    let index: Int
    let logprobs: Logprobs?
    let finish_reason: String
}

struct Logprobs: Codable {
    // If you need to access the logprobs field, you can define the struct fields here
}

struct Usage: Codable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}


func generateTextWithPrompt(prompt: String, model: String, apiKey: String) -> String? {
    let urlString = "https://api.openai.com/v1/completions"
    let temperature = 0.9
    let maxTokens = 150
    let topP = 1
    let frequencyPenalty = 0.39
    let presencePenalty = 0.18
    
    let parameters: [String: Any] = [
        "model": model,
        "prompt": prompt,
        "temperature": temperature,
        "max_tokens": maxTokens,
        "top_p": topP,
        "frequency_penalty": frequencyPenalty,
        "presence_penalty": presencePenalty
    ]
    
    let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
    
    var request = URLRequest(url: URL(string: urlString)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.httpBody = jsonData
    
    var generatedText: String?
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        defer { semaphore.signal() }
        
        guard let data = data, error == nil else {
            print("Error: \(error!)")
            return
        }
        
        do {
            let response = try JSONDecoder().decode(OpenAIResponse.self, from: data)
            generatedText = response.choices[0].text
        } catch {
            print("Error decoding response: \(error)")
        }
    }
    
    task.resume()
    semaphore.wait()
    
    return generatedText
}

func getai(quote:String) -> String{
    let prompt = "translate this kanye quote: \(quote) into Chinese."
    let apiKey = "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"
    let model = "text-davinci-003"
    
    if cooldown != nil{
        if cooldown!.addingTimeInterval(5) > Date.now {
            return ""
        }
    }
    
    cooldown = Date.now
    if let generatedText = generateTextWithPrompt(prompt: prompt, model: model, apiKey: apiKey) {
        return generatedText.removeNewLines()
                     } else {
            return "Error"
        }
}
                     
                     
extension String {
    func removeNewLines(_ delimiter: String = "") -> String {
        self.replacingOccurrences(of: "\n", with: delimiter)
    }
}
