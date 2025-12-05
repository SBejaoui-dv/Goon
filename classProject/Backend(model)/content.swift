//import SwiftUI
//import FamilyControls   // for familyActivityPicker
//
//
//struct CView: View {
//    @StateObject private var model = AppBlockerModel.shared
//    @State private var isLocked = false
//    @State private var isPickerPresented = false
//    @State private var showAdd = false
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Text(isLocked ? "🔒 Locked" : "🔓 Unlocked")
//                    .font(.system(size: 60))
//                    .foregroundColor(isLocked ? .red : .green)
//                
//                
//                Button("Choose Apps") {
//                    isPickerPresented = true
//                }
//                .familyActivityPicker(
//                    isPresented: $isPickerPresented,
//                    selection: $model.selectionToDiscourage
//                )
//                
//                
//                Button(isLocked ? "Unlock" : "Lock") {
//                    if isLocked {
//                        model.unlockApps()
//                    } else {
//                        model.lockApps()
//                    }
//                    isLocked.toggle()
//                }
//                .padding()
//                .background(isLocked ? Color.green : Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//            .padding()
//            .navigationTitle("App Blocker")
//            
//        }
//     
//    }
//}
//
//#Preview {
//    CView()
//}
//
//

