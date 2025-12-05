

import SwiftUI
import FirebaseAuth
import Firebase


struct setting: View {
    // View model you already have
       @StateObject private var authVM = AuthenticationView()
       
       // Simple persistent settings for the demo
       @AppStorage("dailyGoalMinutes") private var dailyGoalMinutes: Int = 180   // 3h
       @AppStorage("defaultSessionMinutes") private var defaultSessionMinutes: Int = 25
       @AppStorage("shareWithFriends") private var shareWithFriends: Bool = true
       @AppStorage("weeklySummary") private var weeklySummary: Bool = true
       @AppStorage("useSystemAppearance") private var useSystemAppearance: Bool = true
       
       @State private var showLogoutAlert = false
       
       var body: some View {
           NavigationStack {
               List {
                   // MARK: - Account
                   Section("Account") {
                       HStack {
                           Image(systemName: "person.circle.fill")
                               .font(.title2)
                               .foregroundColor(.blue)
                           VStack(alignment: .leading) {
                               Text(Auth.auth().currentUser?.displayName ?? "Signed in")
                                   .font(.body.bold())
                               Text(Auth.auth().currentUser?.email ?? "Google account")
                                   .font(.caption)
                                   .foregroundColor(.secondary)
                           }
                       }
                       
                       Button(role: .destructive) {
                           showLogoutAlert = true
                       } label: {
                           HStack {
                               Image(systemName: "rectangle.portrait.and.arrow.right")
                               Text("Sign out")
                           }
                       }
                   }
                   
                   // MARK: - Focus & Blocking
                   Section("Focus & Blocking") {
                       NavigationLink {
                           // This should be your FamilyActivityPicker screen
                           AppSelectionView()   // <- replace with your actual name
                       } label: {
                           HStack {
                               Image(systemName: "app.badge.checkmark")
                               Text("Choose apps to block")
                           }
                       }
                       
                       NavigationLink {
                           DailyGoalPickerView(dailyGoalMinutes: $dailyGoalMinutes)
                       } label: {
                           HStack {
                               Image(systemName: "target")
                               Text("Daily focus goal")
                               Spacer()
                               Text("\(dailyGoalMinutes / 60) h \(dailyGoalMinutes % 60) m")
                                   .foregroundColor(.secondary)
                                   .font(.subheadline)
                           }
                       }
                       
                       NavigationLink {
                           DefaultSessionPickerView(defaultMinutes: $defaultSessionMinutes)
                       } label: {
                           HStack {
                               Image(systemName: "timer")
                               Text("Default focus session")
                               Spacer()
                               Text("\(defaultSessionMinutes) min")
                                   .foregroundColor(.secondary)
                                   .font(.subheadline)
                           }
                       }
                   }
                   
//                   // MARK: - Metrics & Sharing
//                   Section("Metrics & Sharing") {
//                       Toggle(isOn: $shareWithFriends) {
//                           HStack {
//                               Image(systemName: "person.3.fill")
//                               Text("Share stats in leaderboard")
//                           }
//                       }
//                       
//                       Toggle(isOn: $weeklySummary) {
//                           HStack {
//                               Image(systemName: "bell.badge")
//                               Text("Weekly usage summary")
//                           }
//                       }
//                   }
                   
                   // MARK: - App
                   Section("App") {
                       Toggle(isOn: $useSystemAppearance) {
                           HStack {
                               Image(systemName: "moon.circle")
                               Text("Use system appearance")
                           }
                       }
                       
                       NavigationLink {
                           PrivacyInfoView()
                       } label: {
                           HStack {
                               Image(systemName: "lock.shield")
                               Text("Privacy & data")
                           }
                       }
                       
                       NavigationLink {
                           AboutView()
                       } label: {
                           HStack {
                               Image(systemName: "info.circle")
                               Text("About")
                           }
                       }
                   }
               }
               .navigationTitle("Settings")
               .listStyle(.insetGrouped)
               .alert("Sign out?", isPresented: $showLogoutAlert) {
                   Button("Cancel", role: .cancel) { }
                   Button("Sign out", role: .destructive) {
                       Task {
                           do {
                               try await authVM.logout()
                           } catch {
                               print("Logout failed:", error)
                           }
                       }
                   }
               } message: {
                   Text("You’ll be returned to the login screen.")
               }
           }
       }
}



struct DailyGoalPickerView: View {
    @Binding var dailyGoalMinutes: Int
    let options = [60, 90, 120, 180, 240] // 1h, 1.5h, 2h, 3h, 4h
    
    var body: some View {
        List {
            Section {
                ForEach(options, id: \.self) { minutes in
                    Button {
                        dailyGoalMinutes = minutes
                    } label: {
                        HStack {
                            Text("\(minutes / 60) h \(minutes % 60) m")
                            Spacer()
                            if minutes == dailyGoalMinutes {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Daily Focus Goal")
    }
}

struct DefaultSessionPickerView: View {
    @Binding var defaultMinutes: Int
    let options = [15, 25, 45, 60]
    
    var body: some View {
        List {
            Section {
                ForEach(options, id: \.self) { minutes in
                    Button {
                        defaultMinutes = minutes
                    } label: {
                        HStack {
                            Text("\(minutes) minutes")
                            Spacer()
                            if minutes == defaultMinutes {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Focus Session Length")
    }
}

struct PrivacyInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Privacy & Data")
                    .font(.title2.bold())
                Text("""
                This prototype app demonstrates how Screen Time controls and usage \
                *could* be visualized. In a production build, we would explain:
                • What data is read from Screen Time
                • How long data is stored on device
                • How leaderboard sharing works
                """)
            }
            .padding()
        }
        .navigationTitle("Privacy & Data")
    }
}

struct AboutView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("App")
                    Spacer()
                    Text("Focus Tracker")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0 (prototype)")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Developer")
                    Spacer()
                    Text("Sebastian Bejaoui")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Course")
                    Spacer()
                    Text("CSE 335 – class project")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("About")
    }
}






#Preview {
    setting()
}

