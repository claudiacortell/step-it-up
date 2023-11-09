import SwiftUI

struct ProfileView: View {
    let userName = "Roaree the Lion"
    let numberOfSteps = 5000
    let numberOfFriends = 100
    let numberOfCompetitions = 3
    let distanceWalked = 10.53
    let flightsClimbed = 5

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color("medium-blue"), lineWidth: 15)
                    .frame(width: 150, height: 150)
                    .padding(.top, 20)
                Circle()
                    .fill(Color("light-gray"))
                    .frame(width: 140, height: 140)
                    .clipShape(Circle())
                    .padding(.top, 20)
            }.padding(.top, 30)

            Text("Hi, \(userName)")
                .font(.largeTitle)
                .padding(.top, 10)

            HStack(spacing:30) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("medium-green"))
                    .frame(width: 115, height: 100)
                    .overlay(
                        VStack {
                            Text(String(numberOfFriends))
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Text("Total Friends")
                                .font(.headline)
                                .foregroundColor(.white)
                                
                        }
                    )

                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("medium-green"))
                    .frame(width: 115, height: 100)
                    .overlay(
                        VStack {
                            
                            Text(String(numberOfCompetitions))
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Text("Active Competitions")
                                .font(.headline)
                                .foregroundColor(.white)
                               
                        }
                    )
            }
            .padding(.top, 10)
            Spacer(minLength: 20)
           
            ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("dark-blue"))
                .frame(height: 440)
                .overlay(
                    VStack(spacing:20) {
                        Text("Your stats are looking good, keep it up!")
                            .font(.title)
                            .foregroundColor(.white)
                            
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("light-blue"))
                            .frame(width: 350, height: 75)
                            .overlay(
                                HStack {
                                    Text("Steps:")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                        
                                    Text(String(numberOfSteps))
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                       
                                }
                            )
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("light-blue"))
                            .frame(width: 350, height: 75)
                            .overlay(
                                HStack {
                                    Text("Distance Walked (mi):")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(String(distanceWalked))
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                       
                                }
                            )
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("light-blue"))
                            .frame(width: 350, height: 75)
                            .overlay(
                                HStack {
                                    Text("Flights Climbed:")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(String(flightsClimbed))
                                        .font(.title2)
                                        .foregroundColor(.white)
                                    
                                       
                                }
                            )
                        }
                    )
                    }
                

            Spacer()
        }.padding(.top,10)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("light-blue"), Color("light-green")]), startPoint: .top, endPoint: .bottom)
            )
    }

}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
