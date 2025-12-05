

import SwiftUI



struct metrics: View {
    @StateObject private var viewModel = MetricsViewModel()
        
        private let weekDays = ["M", "T", "W", "T", "F", "S", "S"]
        
        var body: some View {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // Today summary
                        todaySummary
                        
                        //  KPI cards
                        kpiRow
                        
                        // Weekly chart
                        weeklyChartSection
                        
                        // M Simulation controls (for demo only)
                        simulationControls
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                }
                .navigationTitle("Report")
            }
        }
        
        // MARK: - Subviews
        
        private var todaySummary: some View {
            let (h, m) = viewModel.formattedTime(from: viewModel.todayFocusSeconds)
            
            return HStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Today’s Focus")
                        .font(.title2.bold())
                    Text("Total time apps were blocked")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    ProgressView(value: viewModel.goalProgress) {
                        Text("Daily goal")
                            .font(.subheadline.bold())
                    } currentValueLabel: {
                        Text("\(Int(viewModel.goalProgress * 100))%")
                            .font(.subheadline.monospacedDigit())
                    }
                    .tint(.blue)
                    .padding(.top, 8)
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                        .frame(width: 110, height: 110)
                    
                    Circle()
                        .trim(from: 0, to: viewModel.goalProgress)
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 110, height: 110)
                    
                    VStack(spacing: 2) {
                        Text("\(h)")
                            .font(.title.bold())
                        Text("h")
                            .font(.caption2)
                        Text("\(m)")
                            .font(.title3.bold())
                        Text("m")
                            .font(.caption2)
                    }
                    .font(.system(.body, design: .rounded))
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 4, y: 3)
            )
        }
        
        private var kpiRow: some View {
            HStack(spacing: 12) {
                kpiCard(
                    title: "Focus streak",
                    value: "\(viewModel.focusStreakDays)",
                    subtitle: "days in a row"
                )
                
                kpiCard(
                    title: "Sessions today",
                    value: "\(viewModel.sessionsToday)",
                    subtitle: "focus sessions"
                )
            }
        }
        
        private func kpiCard(title: String, value: String, subtitle: String) -> some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.title2.bold())
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 3, y: 2)
            )
        }
        
        private var weeklyChartSection: some View {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("This week")
                        .font(.headline)
                    Spacer()
                    Text("Hours focused")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                GeometryReader { geo in
                    let maxHeight: CGFloat = 140
                    let maxValue = max(viewModel.weeklyHours.max() ?? 1, 1)
                    let barWidth = geo.size.width / CGFloat(viewModel.weeklyHours.count * 2)
                    
                    HStack(alignment: .bottom, spacing: barWidth) {
                        ForEach(viewModel.weeklyHours.indices, id: \.self) { index in
                            let value = viewModel.weeklyHours[index]
                            let height = CGFloat(value / maxValue) * maxHeight
                            
                            VStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.blue.opacity(0.8))
                                    .frame(width: barWidth, height: height)
                                
                                Text(weekDays[index])
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: maxHeight, alignment: .bottom)
                }
                .frame(height: 160)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 4, y: 3)
            )
        }
        
        private var simulationControls: some View {
            VStack(spacing: 12) {
                Text("Simulation")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("These buttons don’t talk to Screen Time – Here to demonstrate functionality.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Button {
                        viewModel.simulateFocusBlock()
                    } label: {
                        Text("+15 min focused")
                            .font(.subheadline.bold())
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(role: .destructive) {
                        viewModel.reset()
                    } label: {
                        Text("Reset")
                            .font(.subheadline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 3, y: 2)
            )
        }
}





#Preview {
    metrics()
}

