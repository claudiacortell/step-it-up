import SwiftUI

struct ProfileHeaderView: View {
    let user: User

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color("medium-blue"), lineWidth: 15)
                .frame(width: 140, height: 140)
                .padding(.top, 20)

            Image(systemName: user.pfp)
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .padding(.top, 20)
        }
        .padding(.top,250)
    }
}

struct StatsSquare: View {
    let title: String
    let value: String

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("medium-green"))
            .frame(width: 115, height: 100)
            .overlay(
                VStack {
                    Text(value)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            )
    }
}

struct ProgressBarView: View {
    let progressText: String
    let numProgress: Double
    let progress: String

    var body: some View {
        VStack {
            Text(progressText)
                .font(.title2)
                .bold()
                .foregroundColor(Color("dark-blue"))
                .multilineTextAlignment(.center)
               

            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .foregroundColor(Color("dark-blue"))
                    .padding()
                    .frame(width: 155, height: 155)

                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(numProgress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color("light-blue"))
                    .rotationEffect(Angle(degrees: 270.0))
                    .padding()
                    .frame(width: 155, height: 155)

                Text(String(progress))
                    .font(.subheadline)
                    .bold()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
           
        }
    }
}

            
struct StatsCard: View {
    let title: String
    let value: String

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("light-green"))
            .frame(width: 350, height: 75)
            .overlay(
                HStack {
                    Text(title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("medium-blue"))

                    Text(value)
                        .font(.title2)
                        .foregroundColor(Color("medium-blue"))
                }
            )
    }
}

struct ProfileView: View {
    let user: User

    var body: some View {
        VStack {
            ProfileHeaderView(user: user)

            Text("Hi, \(user.name)")
                .font(.largeTitle)
                .padding(.top, 10)

            HStack(spacing: 30) {
                NavigationLink {
                    BaseView()
                } label: {
                    StatsSquare(title: "Total Friends", value: "\(user.friends?.count ?? 0)")
                }

                NavigationLink {
                    BaseView()
                } label: {
                    StatsSquare(title: "Total Groups", value: "\(user.groups?.count ?? 0)")
                }
            }
            .padding(.top, 10)

            Spacer(minLength: 20)

            NavigationLink {
                BaseView()
            } label: {
                ProgressBarView(progressText: "Progress towards your current goal: ", numProgress: Double(user.data.dailyStep)/Double(user.data.dailyStep), progress:"\(user.data.dailyStep) / \(user.data.dailyStep)")
                    .frame(width: 200, height: 200)
                        .padding(20.0)

            }

            Text("Your stats are looking good, keep it up!")
                .font(.headline)
                .padding(.top, 10)
                .foregroundColor(Color("dark-blue"))

            StatsCard(title: "Daily Steps", value: "\(user.data.dailyStep)")
            StatsCard(title: "Daily Distance (mi)", value: "\(user.data.dailyMileage)")
            StatsCard(title: "Weekly Steps", value: "\(user.data.weeklyStep)")
            StatsCard(title: "Weekly Distance (mi)", value: "\(user.data.weeklyMileage)")
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: currentUser)
    }
}
