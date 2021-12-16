import SwiftPDF

struct Title: View {
	let primary: String
	let secondary: String
	
	var body: some View {
		HStack(spacing: 16) {
			
			Text(primary)
				.fontSize(20)
			
			Text(secondary)
				.fontSize(16)
				.foregroundColor(.gray)
		}
	}
}
