import SwiftPDF

struct SuccessTag: View {
	
	private let title = "Erfolgreich"
	private let fontColor = Color(red: 0.31, green: 0.6, blue: 0.18)
	private let backgroundColor = Color(red: 0.97, green: 1, blue: 0.93)
	private let borderColor = Color(red: 0.75, green: 0.91, blue: 0.6)
	
	var body: some View {
		Tag(title: title,
			fontColor: fontColor,
			backgroundColor: backgroundColor,
			borderColor: borderColor)
	}
}
