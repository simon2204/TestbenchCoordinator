import Foundation
import Testbench

struct ResultData {
	
	private let result: TestResult
	
	let name: String
	
	init(name: String, result: TestResult) {
		self.name = name
		self.result = result
	}
	
	var assignmentName: String {
		result.assignmentName
	}
	
	var creationDate: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .long
		dateFormatter.timeStyle = .short
		return dateFormatter.string(from: result.date)
	}
	
	var score: String {
		let scoreFormatter = NumberFormatter()
		let percentage = Double(result.successCount) / Double(result.totalTestcases)
		scoreFormatter.numberStyle = .percent
		scoreFormatter.maximumFractionDigits = 2
		scoreFormatter.minimumFractionDigits = 0
		let nsPercentage = NSNumber(value: percentage)
		let formattedPercentage = scoreFormatter.string(from: nsPercentage) ?? ""
		return "\(result.successCount)/\(result.totalTestcases) (\(formattedPercentage))"
	}
	
	var entries: [TestResult.Entry] {
		result.entries
	}
	
	var error: String? {
		result.errorMsg
	}
}
