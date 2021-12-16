import SwiftPDF

struct ErrorTag: View {
	
	private let title = "Error"
	private let fontColor = Color(red: 0.77, green: 0.19, blue: 0.17)
	private let backgroundColor = Color(red: 0.99, green: 0.95, blue: 0.94)
	private let borderColor = Color(red: 0.97, green: 0.66, blue: 0.63)
	
	var body: some View {
		Tag(title: title,
			fontColor: fontColor,
			backgroundColor: backgroundColor,
			borderColor: borderColor)
	}
}
