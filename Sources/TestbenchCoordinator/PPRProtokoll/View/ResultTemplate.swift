import SwiftPDF

struct ResultTemplate: View {
	
	var data: ResultData
	
	private let leadingPadding = 30.0
	
	var body: some View {
		VStack(alignment: .leading, spacing: 30) {
			
			Title(primary: "Auswertungsprotokoll", secondary: "PPR Testbench")
				.padding(.leading, leadingPadding)

			HorizontalDivider(title: "Übersicht")

			Overview(
				name: data.name,
				creationDate: data.creationDate,
				taskName: data.assignmentName,
				result: data.score
			)
				.padding(.leading, leadingPadding)

			HorizontalDivider(title: "Auswertung")
			
			ResultTable(result: data)

			Spacer(minLength: 0)
		}
		.padding(.top, 30)
	}
}
