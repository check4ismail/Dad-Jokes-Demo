//
//  JokeView.swift
//  DadJokes
//
//  Created by Ismail Elmaliki on 4/29/23.
//

import SwiftUI

/// Joke View to display dad jokes.
///
/// Tapping anywhere on the screen will generate a random dad joke.
struct JokeView: View {
	@State var joke: String = ""
	
	var body: some View {
		VStack {
			Button {
				/// Button tap action - generate new dad joke
				generateJoke()
			} label: {
				Text(joke)
					.foregroundColor(.black)
					.font(.system(size: 20))
					.padding()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
		}
		.onAppear {
			/// Generate dad jokes when displaying for the first time
			generateJoke()
		}
	}
	
	/// Generates dad jokes by calling JokeAPI asynchronously.
	private func generateJoke() {
		Task {
			let result = await JokeAPI.shared.getDadJoke()
			
			/// Verify result is dad joke and **not** an error
			if let newJoke = try? result.get() {
				/// Update UI to display new dad joke.
				joke = newJoke.joke
			}
		}
	}
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}
