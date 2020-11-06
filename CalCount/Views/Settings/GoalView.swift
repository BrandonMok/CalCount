
import SwiftUI
import RealmSwift

struct GoalView: View {
    
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject

    private var weightGoalOptions = ["None", "Lose", "Maintain", "Gain"]
    private var waterGoalOptions = ["None", "Maintain", "Increase"]
    @State private var selectedWeightGoal = 0
    @State private var selectedWaterGoal = 0
    
    @State private var weightGoalSetSuccess = false
    @State private var waterGoalSetSuccess = false
    
    @State private var usrGoal: Goal?
    
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

                    // Weight
                    Button(action: {
                        if (usrGoal != nil) {
                            try! realmObj.realm.write({
                                usrGoal?.weightGoal = weightGoalOptions[selectedWeightGoal]
                            })
                        }
                        else {
                            let newGoal = Goal()
                            newGoal.user = status.currentUser
                            newGoal.weightGoal = weightGoalOptions[selectedWeightGoal]
                            newGoal.waterGoal = waterGoalOptions[0]
                            
                            usrGoal = newGoal
                            status.currentGoal = newGoal   // save it under while user is using app
                            
                            try! realmObj.realm.write({
                                realmObj.realm.add(newGoal)
                            })
                        }

                        weightGoalSetSuccess.toggle()
                    }, label: {
                        Text("Confirm")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20)
                    })
                    .padding()
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(15)
                    .alert(isPresented: $weightGoalSetSuccess, content: {
                        Alert(title: Text("Success"),
                              message: Text("Weight goal was set successfully!"),
                              dismissButton: .default(Text("OK")))
                    })
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
                    
                    // Water Intake
                    Button(action: {
                        if (usrGoal != nil) {
                            try! realmObj.realm.write({
                                usrGoal?.waterGoal = waterGoalOptions[selectedWaterGoal]
                            })
                        }
                        else {
                            let newGoal = Goal()
                            newGoal.user = status.currentUser
                            newGoal.weightGoal = weightGoalOptions[0]
                            newGoal.waterGoal = waterGoalOptions[selectedWaterGoal]
                            
                            usrGoal = newGoal
                            status.currentGoal = newGoal
                            
                            try! realmObj.realm.write({
                                realmObj.realm.add(newGoal)
                            })
                        }
                        
                        waterGoalSetSuccess.toggle()
                    }, label: {
                        Text("Confirm")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: 20)
                            .cornerRadius(15)

                    })
                    .padding()
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(15)
                    .alert(isPresented: $waterGoalSetSuccess, content: {
                        Alert(title: Text("Success"),
                              message: Text("Water goal was set successfully!"),
                              dismissButton: .default(Text("OK")))
                    })
                }
                
                Spacer()
                Spacer()
            }//Vstack
            .padding()
            
            
        }//ScrollView
        .onAppear(perform: {
            // Check if this user already has a goal obj set!
            let goalResults = realmObj.realm.objects(Goal.self)
            
            if goalResults.count > 0 {
                for goal in goalResults {
                    if goal.user!.username == status.currentUser.username {
                        usrGoal = goal
                        break
                    }
                }
                
                // Set pre-configured goal settings from a goal if it was set
                if let userGoal = usrGoal {
                    self.selectedWeightGoal = weightGoalOptions.firstIndex(of: "\(userGoal.weightGoal)")!
                    self.selectedWaterGoal = waterGoalOptions.firstIndex(of: "\(userGoal.waterGoal)")!
                }
            }
        })
    }//body
}//struct

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
