
import SwiftUI
import FamilyControls   // for familyActivityPicker


struct Home: View {
    @StateObject private var model = AppBlockerModel.shared
    @StateObject private var quoteVM = QuoteViewModel()
    @State private var isFocusing = false   // tracks if focus is on

    // Screen-time + streak simulation (backed by App Group defaults)
    @AppStorage("todayScreenTimeSeconds",
                store: UserDefaults(suiteName: "group.com.yourcompany.appblocker"))
    private var todaySeconds: Int = 0

    @AppStorage("focusStreakDays",
                store: UserDefaults(suiteName: "group.com.yourcompany.appblocker"))
    private var streakDays: Int = 2   // fake default for now

    // Helpers to format screen time
    private var hours: Int {
        todaySeconds / 3600
    }

    private var minutes: Int {
        (todaySeconds % 3600) / 60
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 32) {

                // MARK: - Quote / Consequences Banner
                VStack(alignment: .leading, spacing: 8) {
                    Text("Today’s reminder")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if quoteVM.isLoading {
                        ProgressView()
                            .scaleEffect(0.8)
                    } else {
                        Text(quoteVM.quoteText)
                            .font(.headline)
                            .multilineTextAlignment(.leading)

                        Text("— \(quoteVM.quoteAuthor)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )

                // MARK: - START / PAUSE FOCUS BUTTON
                Button {
                    isFocusing.toggle()
                    if isFocusing {
                        model.lockApps()      // block the selected apps
                    } else {
                        model.unlockApps()    // unblock them
                    }
                } label: {
                    Text(isFocusing ? "PAUSE FOCUS" : "START FOCUS")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color(.systemGray6))
                        .cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                        )
                }

                // MARK: - “Blocked Apps” + summary
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Blocked Apps")
                            .font(.subheadline)
                        Spacer()
                        Text("\(model.selectionToDiscourage.applicationTokens.count) selected")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

    
                }

                // MARK: - Metrics / progress section
                HStack(alignment: .center, spacing: 32) {

                    // Streak
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(streakDays) Day")
                            .font(.headline)
                        Text("Streak")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    // Screen-time circle
                    ZStack {
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: 120, height: 120)
                            .foregroundColor(.clear)
                            .background(
                                Circle()
                                    .fill(Color(.systemGray6))
                            )

                        VStack(spacing: 4) {
                            Text("\(hours) h")
                                .font(.headline)
                            Text("\(minutes) m")
                                .font(.subheadline)
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
            .navigationTitle("Focus")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AppSelectionView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .task {
                //load the quote when Home first appears
                await quoteVM.loadQuote()
            }
            .refreshable {
                //pull-to-refresh to get a new quote
                // this shit is not working 
                await quoteVM.loadQuote()
            }
        }
    }
}

#Preview {
    Home()
    
}
