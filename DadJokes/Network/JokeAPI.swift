//
//  JokeAPI.swift
//  DadJokes
//
//  Created by Ismail Elmaliki on 4/29/23.
//

import Foundation

/// Joke API to generate dad jokes.
final class JokeAPI {
	static let shared = JokeAPI()
	
	private var urlRequest: URLRequest
	
	private init() {
		/// Setup API URL
		urlRequest = URLRequest(url: URL(string: "https://icanhazdadjoke.com/")!)
		
		/// Add header field and value
		urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
	}
	
	/// Fetches a dad joke.
	///
	/// Either an error or a valid joke is returned.
	func getDadJoke() async -> Result<Joke, Error> {
		do {
			/// Perform network request using URLSession
			let response = try await URLSession.shared.data(for: urlRequest)
			
			/// Get `data` from API response
			let data = response.0
			
			/// Decode API response and map it to `Joke` model
			let decoder = JSONDecoder()
			let joke = try decoder.decode(Joke.self, from: data)
			
			/// Return joke
			return .success(joke)
		} catch {
			print("Dad Joke API error: \(String(describing: error))")
			return .failure(error)
		}
	}
	
}
