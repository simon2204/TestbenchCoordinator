import SwiftPDF

struct HorizontalDivider: View {
	
	var title: String? = nil
	
	var thickness: Double = 1
	
	private let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)
	
	var body: some View {
		HStack {
			if let title = title {
				lightGray
					.frame(width: 50, height: thickness)
				Text(title)
			}
			
			lightGray
				.frame(height: thickness)
		}
	}
}
