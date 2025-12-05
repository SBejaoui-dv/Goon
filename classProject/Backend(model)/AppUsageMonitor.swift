import DeviceActivity
import Foundation
import FamilyControls

class AppUsageMonitor: DeviceActivityMonitor {
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Temporary "ake usage increment for testing only:
        let defaults = UserDefaults(suiteName: "group.com.yourcompany.appblocker")
        let current = defaults?.integer(forKey: "todayScreenTimeSeconds") ?? 0
        defaults?.set(current + 30 * 60, forKey: "todayScreenTimeSeconds")
    }
}

