import SwiftUI
import FamilyControls

struct AppSelectionView: View {
    @ObservedObject var blocker = AppBlockerModel.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text("Choose Activities")
                .font(.largeTitle)
                .bold()

            FamilyActivityPicker(selection: $blocker.selectionToDiscourage)

            Button("Save") {
                blocker.saveSelectionToStorage()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}


#Preview {
    AppSelectionView()
    
}
