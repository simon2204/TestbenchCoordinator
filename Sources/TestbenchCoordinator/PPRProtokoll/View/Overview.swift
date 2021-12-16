import SwiftPDF

struct Overview: View {
	let name: String
	let creationDate: String
	let taskName: String
	let result: String
	
	private let fontSize = 10.0
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
	
			InfoLine {
				HStack {
					Text("Name:").fontSize(fontSize)
					Text(name).fontSize(fontSize)
				}
			} second: {
				HStack {
					Text("Erstellt:").fontSize(fontSize)
					Text(creationDate).fontSize(fontSize)
				}
			}
			
			InfoLine {
				HStack {
					Text("Praktikumsaufgabe:").fontSize(fontSize)
					Text(taskName).fontSize(fontSize)
				}
			} second: {
				HStack {
					Text("Erfolgreiche Testfälle:").fontSize(fontSize)
					Text(result).fontSize(fontSize)
				}
			}
		}
	}
}

private struct InfoLine<First, Second>: View where First: View, Second: View {
	let first: () -> First
	let second: () -> Second
	
	var body: some View {
		HStack {
			first()
			Spacer()
			second()
			Spacer(minLength: 0)
			Spacer(minLength: 0)
			Spacer(minLength: 0)
		}
	}
}
