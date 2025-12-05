

import SwiftUI



struct leaderboard: View {
    struct Friend: Identifiable {
            let id = UUID()
            let rank: Int
            let name: String
            let time: String
            let isMe: Bool
        }
        
        // Toggle this based on whether the user finished setup
        let hasConfiguredLeaderboard: Bool = false
        
        private let friends: [Friend] = [
            .init(rank: 1, name: "Liam Edwards",       time: "1h", isMe: false),
            .init(rank: 2, name: "Eric Nance",         time: "1h", isMe: false),
            .init(rank: 3, name: "Me",                 time: "2h", isMe: true),
            .init(rank: 4, name: "Michael Maduka",     time: "1h", isMe: false),
            .init(rank: 5, name: "Carmen Bejaoui",     time: "1h", isMe: false)
        ]
        
        var body: some View {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 16) {
                        
                        // Top “The concentrated one” card
                        VStack(spacing: 12) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.black.opacity(0.7))
                            
                            VStack(spacing: 4) {
                                Text("The concentrated one")
                                    .font(.headline)
                                
                                Text("see your friends Screen Time")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        
                        // “Find friends on Gooner” card
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color(.systemGray5))
                                    .frame(width: 36, height: 36)
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Find friends on Gooner")
                                    .font(.subheadline.weight(.semibold))
                                Text("Add friends to compare your time")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        
                        // Friends list (blurred preview if not configured)
                        ZStack {
                            VStack(spacing: 12) {
                                ForEach(friends) { friend in
                                    HStack {
                                        // Avatar / rank
                                        if friend.isMe {
                                            ZStack {
                                                Circle()
                                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                                    .frame(width: 32, height: 32)
                                                Text("\(friend.rank)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                        } else {
                                            Circle()
                                                .fill(Color(.systemGray5))
                                                .frame(width: 32, height: 32)
                                        }
                                        
                                        // Name
                                        Text(friend.name)
                                            .font(.body)
                                            .foregroundColor(.primary)
                                        
                                        Spacer()
                                        
                                        // Time
                                        Text(friend.time)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            // Blur + disable interactions if not configured yet
                            .blur(radius: hasConfiguredLeaderboard ? 0 : 1.2)
                            .allowsHitTesting(hasConfiguredLeaderboard)
                            .opacity(hasConfiguredLeaderboard ? 1 : 0.8)
                            
                            if !hasConfiguredLeaderboard {
                                VStack {
                                    Text("Preview of your leaderboard")
                                        .font(.subheadline.weight(.semibold))
                                    Text("Set up your account to see real friends and screen time.")
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                                .padding(.top, 8)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            }
                        }
                        .padding(.top, 8)
                        
                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
                .navigationTitle("Leaderboard")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if hasConfiguredLeaderboard {
                            Button {
                                // TODO: present "Add friends" flow
                            } label: {
                                Text("+ Add friends")
                                    .font(.subheadline.weight(.semibold))
                            }
                            
                        }
                    }
                }
            }
        }
}





#Preview {
    leaderboard()
}

