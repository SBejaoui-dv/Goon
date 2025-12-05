//import FirebaseFirestore
//
//struct FirestoreTest {
//
//    static func writeRandomNumber() {
//        let db = Firestore.firestore()
//
//        // Random test data
//        let testData: [String: Any] = [
//            "value": Int.random(in: 1...1000),
//            "timestamp": FieldValue.serverTimestamp()
//        ]
//
//        db.collection("test").addDocument(data: testData) { error in
//            if let error = error {
//                print("Failed to write test data:", error)
//            } else {
//                print("Working wrote random number to Firestore")
//            }
//        }
//    }
//}
//
