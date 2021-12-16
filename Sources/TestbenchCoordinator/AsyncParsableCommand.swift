//
//  File.swift
//  
//
//  Created by Simon Schöpke on 03.12.21.
//

import ArgumentParser
import Foundation

final class ErrorReference {
	var error: Error?
	
	func getError() throws {
		if let error = error {
			throw error
		}
	}
}

protocol AsyncParsableCommand: ParsableCommand {
	func run() async throws
}

extension AsyncParsableCommand {
	func run() throws {
		
		let errorReference = ErrorReference()
		
		let runGroup = DispatchGroup()
		runGroup.enter()
		
		Task {
			do {
				try await run()
				runGroup.leave()
			} catch {
				errorReference.error = error
				runGroup.leave()
			}
		}
		runGroup.wait()
		
		try errorReference.getError()
	}
}
