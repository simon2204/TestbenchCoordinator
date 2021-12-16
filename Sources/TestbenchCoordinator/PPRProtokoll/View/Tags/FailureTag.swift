import SwiftPDF

struct FailureTag: View {
	
	private let title = "Fehlgeschlagen"
	private let fontColor = Color(red: 0.8, green: 0.44, blue: 0.16)
	private let backgroundColor = Color(red: 0.99, green: 0.97, blue: 0.91)
	private let borderColor = Color(red: 0.98, green: 0.84, blue: 0.60)
	
	var body: some View {
		Tag(title: title,
			fontColor: fontColor,
			backgroundColor: backgroundColor,
			borderColor: borderColor)
	}
}
