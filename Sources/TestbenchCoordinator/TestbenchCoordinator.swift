//
//  TestbenchCoordinator.swift
//  
//
//  Created by Simon Schöpke on 13.06.21.
//

import Foundation
import MoodleAPI
import ArgumentParser
import Testbench
import SwiftPDF
import SwiftPDFFoundation

@main
struct TestbenchCoordinator: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Koordinieren und Testen von Einreichungen in Moodle.",
		subcommands: [Evaluate.self, Download.self, Run.self],
        defaultSubcommand: Evaluate.self)
}

struct TaskSelection: ParsableArguments {
	@Argument(help: "Moodle-Benutzername.")
	var username: String
	
	@Argument(help: "Moodle-Password.")
	var password: String
	
	@Argument(help: "ID der Praktikumsaufgabe.")
	var assignmentID: Int
}

struct Configuration: ParsableArguments {
	
	@Argument(help: "Pfad zur Konfigurationsdatei.")
	var config: String
	
	func validate() throws {
		if !FileManager.default.fileExists(atPath: config) {
			throw ValidationError("Es existiert keine Konfigurationsdatei am übergebenen Pfad.")
		}
	}
}

struct Evaluate: AsyncParsableCommand {
	
	@OptionGroup var taskSelection: TaskSelection
	
	@OptionGroup var configuration: Configuration
	
	@Argument(help: "Pfad in denen die Auswertungen gespeichert werden sollen.")
	var destination: String
	
	func run() async throws {
		let submissionUrl = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
		try FileManager.default.createDirectory(at: submissionUrl, withIntermediateDirectories: false)
		
		let pfadUrl = URL(fileURLWithPath: destination).appendingPathComponent("results")
		
		try? FileManager.default.removeItem(at: pfadUrl)
		
		try FileManager.default.createDirectory(at: pfadUrl, withIntermediateDirectories: false)
		
		let moodle = try await moodleLogin(name: taskSelection.username, password: taskSelection.password)

		let submissions = try await moodle.downloadSubmissions(forId: taskSelection.assignmentID, to: submissionUrl)
		
		let configUrl = URL(fileURLWithPath: configuration.config)

		let assignment = taskSelection.assignmentID
		
		try createFeedback(forSubmissions: submissions, assignmentID: assignment, config: configUrl) {
			URL(fileURLWithPath: "\(destination)/results/\($0.name)_result.pdf")
		}
		
		try FileManager.default.removeItem(at: submissionUrl)
	}
}

struct Run: AsyncParsableCommand {
	
	@OptionGroup var taskSelection: TaskSelection
    
	@OptionGroup var configuration: Configuration
    
    func run() async throws {
        let submissionUrl = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: submissionUrl, withIntermediateDirectories: false)
        
		let moodle = try await moodleLogin(name: taskSelection.username, password: taskSelection.password)

		let submissions = try await moodle.downloadSubmissions(forId: taskSelection.assignmentID, to: submissionUrl)
		
		let configUrl = URL(fileURLWithPath: configuration.config)

		let assignment = taskSelection.assignmentID
		
		try createFeedback(forSubmissions: submissions, assignmentID: assignment, config: configUrl) {
			return $0.path.appendingPathComponent("Auswertungsprotokoll.pdf")
		}
		
		if let submissionsURL = submissions.first?.path.deletingLastPathComponent() {
			try await moodle.uploadFeedback(forId: taskSelection.assignmentID, from: submissionsURL)
		}
        
        try FileManager.default.removeItem(at: submissionUrl)
    }
}

struct Download: AsyncParsableCommand {
    
	@OptionGroup var taskSelection: TaskSelection
    
    @Argument(help: "Pfad in denen die Einreichungen gespeichert werden sollen.")
    var destination: String
    
    func run() async throws {
        let pfadUrl = URL(fileURLWithPath: destination)
		let moodle = try await moodleLogin(name: taskSelection.username, password: taskSelection.password)
		let _ = try await moodle.downloadSubmissions(forId: taskSelection.assignmentID, to: pfadUrl)
    }
}

// MARK: - Private, globale Hilfsfunktionen

private func moodleLogin(name: String, password: String) async throws -> MoodleApplication {
	let session = MoodleSession()
	try await session.login(name: name, password: password)
	return MoodleApplication(session: session)
}

private func createFeedback(
	forSubmissions submissions: [MoodleSubmission],
	assignmentID: Int,
	config: URL,
	moodleSubmission: (MoodleSubmission) -> URL)
throws {
	
	let testbench = Testbench(config: config)
	
	for submission in submissions {
		let result = try testbench.performTests(submission: submission.path, assignment: assignmentID)
		let resultData = ResultData(name: submission.name, result: result)
        var document = Document { ResultTemplate(data: resultData) }
        let size = document.pageSize.size
        document.pageSize = .preferred(size)
        let data = document.createData()
		let writeDestination = moodleSubmission(submission)
		try FileManager.default.removeItem(at: submission.path)
		try FileManager.default.createDirectory(atPath: submission.path.path, withIntermediateDirectories: false)
		try data.write(to: writeDestination)
	}
}

