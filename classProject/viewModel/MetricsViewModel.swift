import Foundation
import SwiftUI

final class MetricsViewModel: ObservableObject {

    @Published var todayFocusSeconds: Int = 60 * 60 * 2 + 30 * 60   // 2h 30m
    

    let dailyGoalSeconds: Int = 60 * 60 * 3                          // 3h
    

    @Published var focusStreakDays: Int = 2
    

    @Published var sessionsToday: Int = 3
    

    @Published var weeklyHours: [Double] = [1.5, 2.0, 2.75, 3.0, 1.0, 0.5, 2.25]
    
    

    func simulateFocusBlock() {
        todayFocusSeconds += 15 * 60
        sessionsToday += 1
        
  
        if todayFocusSeconds >= dailyGoalSeconds && focusStreakDays < 3 {
            focusStreakDays += 1
        }
        
        if !weeklyHours.isEmpty {
            weeklyHours[weeklyHours.count - 1] += 0.25
        }
    }
    
 
    func reset() {
        todayFocusSeconds = 0
        sessionsToday = 0
        focusStreakDays = 0
        weeklyHours = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    }
    

    
    func formattedTime(from seconds: Int) -> (hours: Int, minutes: Int) {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        return (h, m)
    }
    
    var goalProgress: Double {
        guard dailyGoalSeconds > 0 else { return 0 }
        return min(Double(todayFocusSeconds) / Double(dailyGoalSeconds), 1.0)
    }
}

