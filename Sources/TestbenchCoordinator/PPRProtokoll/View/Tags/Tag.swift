import SwiftPDF

struct Tag: View {
	
	let title: String
	let fontColor: Color
	let backgroundColor: Color
	let borderColor: Color
	
	var body: some View {
		Text(title.uppercased())
			.foregroundColor(fontColor)
			.padding(.vertical, 4)
			.padding(.horizontal, 2)
			.background {
				TagBackground(
					backgroundColor: backgroundColor,
					borderColor: borderColor)
			}
			.padding(1)
	}
}

private struct TagBackground: View {
	let backgroundColor: Color
	let borderColor: Color
	
	private let cornerRadius = 2.0
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: cornerRadius)
				.fill(backgroundColor)
			RoundedRectangle(cornerRadius: cornerRadius)
				.stroke(borderColor)
		}
	}
}
