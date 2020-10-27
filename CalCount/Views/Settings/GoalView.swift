
import SwiftUI
import RealmSwift

struct GoalView: View {
    
    @State private var currentGoals = ""
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .center, spacing: 40) {
                Text("Goals")
                    .font(.largeTitle)
                    .foregroundColor(Color("PrimaryBlue"))
                    .bold()
                
                Text("Current goal(s):")
                    .font(.title)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            
            

            // Weight goal
            VStack(alignment: .leading) {
                Text("Weight")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text("What is your goal with your weight?")
                    .font(.title2)
                
                // Picker?
            }
            
            VStack(alignment: .leading) {
                Text("Water Intake")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text("What is your goal for water intake?")
                    .font(.title2)
                
                // Picker?
            }
            
        }//Vstack
        .padding()
    }//body
}//struct

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
