
import SwiftUI
import RealmSwift

struct GoalView: View {
    
    @EnvironmentObject var status: LoggedInStatus
    
    private var weightGoalOptions = ["None", "Lose", "Maintain", "Gain"]
    private var waterGoalOptions = ["None", "Decrease", "Increase"]
    @State private var selectedWeightGoal = ""
    @State private var selectedWaterGoal = ""
    
    init() {
        // On init, want to preset the values for the pickers if user already chose one!
        let realm = try! Realm()
        
        let goalResults = realm.objects(Goal.self)
            .filter("user = %@", status.currentUser)
        
        if goalResults.count != 0 {
            let goal = goalResults.first!
            self.selectedWeightGoal = goal.weightGoal
            self.selectedWaterGoal = goal.waterGoal
        }
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                // MARK: - Title "Goals"
                VStack(alignment: .center, spacing: 40) {
                    Text("Goals")
                        .font(.largeTitle)
                        .foregroundColor(Color("PrimaryBlue"))
                        .bold()
                }
                .frame(maxWidth: .infinity)
                

                // MARK: - Weight
                VStack(alignment: .leading) {
                    Text("Weight")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Text("What is your weight goal?")
                        .font(.title2)
                    
                    VStack(alignment: .leading) {
                        Text("Lose - Losing weight will lower the daily caloric intake")
                            .font(.subheadline)
                        Text("Maintain - The daily caloric intake will remain as the default")
                            .font(.subheadline)
                        Text("Gain - Gaining weight will increase the daily caloric intake")
                            .font(.subheadline)
                    }

                    Picker(selection: $selectedWeightGoal, label: Text("Options")) {
                        ForEach(0..<weightGoalOptions.count) {
                            Text(self.weightGoalOptions[$0])
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                }
                
                // MARK: - Water Intake
                VStack(alignment: .leading) {
                    Text("Water Intake")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Text("What is your goal for water intake?")
                        .font(.title2)
                    
                    Picker(selection: $selectedWaterGoal, label: Text("Options")) {
                        ForEach(0..<waterGoalOptions.count) {
                            Text(self.waterGoalOptions[$0])
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                }
                
                Spacer()
                Spacer()
            }//Vstack
            .padding()
            
            
        }//ScrollView
    }//body
}//struct

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
