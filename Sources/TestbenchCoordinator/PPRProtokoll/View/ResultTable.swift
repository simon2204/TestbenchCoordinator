import SwiftPDF
import Testbench

struct ResultTable: View {
	
	let result: ResultData
	
	private var entries: [TestResult.Entry] {
		result.entries
	}
	
	private var error: String? {
		result.error
	}
	
	private let grayBackgroundColor = Color(red: 0.98, green: 0.98, blue: 0.98)
	
	private let titleSize: Double = 13
	
	private let infoSize: Double = 10
	
	var body: some View {
		VStack(spacing: 0) {
			
			HorizontalDivider()
			
			tableHeader

			HorizontalDivider()
			
			if let error = error {
				errorRow(error)
				HorizontalDivider()
			}
			
			ForEach(entries) { entry in
				
				resultRow(entry)
				
				HorizontalDivider()
				
				if !entry.error.isEmpty {
					errorRow(entry.error)
					HorizontalDivider()
				}
			}
		}
	}
	
	var tableHeader: some View {
		TableRow {
			Text("Testfall")
				.fontSize(titleSize)
		} trailing: {
			Text("Status")
				.fontSize(titleSize)
		}
		.background {
			grayBackgroundColor
		}
	}
	
	func resultRow(_ entry: TestResult.Entry) -> some View {
		TableRow {
			Text(entry.info)
				.fontSize(infoSize)
		} trailing: {
			if entry.successful {
				AnyView(SuccessTag())
			} else {
				AnyView(FailureTag())
			}
		}
	}
	
	func errorRow(_ message: String) -> some View {
		TableRow {
			Text(message)
				.fontSize(infoSize)
		} trailing: {
			ErrorTag()
		}
		.background {
			grayBackgroundColor
		}
	}
}

struct TableRow<Leading, Trailing>: View where Leading: View, Trailing: View {
	
	private var leadingItem: Leading
	
	private var trailingItem: Trailing
	
	init(@ViewBuilder leading: () -> Leading, @ViewBuilder trailing: () -> Trailing) {
		self.leadingItem = leading()
		self.trailingItem = trailing()
	}
	
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				leadingItem
					.padding(16)
				Spacer()
				trailingItem
					.frame(width: 120, alignment: .leading)
			}
		}
	}
}
