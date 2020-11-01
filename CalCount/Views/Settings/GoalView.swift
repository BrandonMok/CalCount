
import SwiftUI
import RealmSwift

struct GoalView: View {
    
//    @EnvironmentObject var status: LoggedInStatus
     @ObservedObject var status = LoggedInStatus()
    
    private var currentUser: User {
        self.status.currentUser
    }
    
    private var weightGoalOptions = ["None", "Lose", "Maintain", "Gain"]
    private var waterGoalOptions = ["None", "Decrease", "Increase"]
    @State private var selectedWeightGoal = ""
    @State private var selectedWaterGoal = ""
    
    @State private var weightGoalSetSuccess = false
    @State private var waterGoalSetSuccess = false
    
//    @State private var goalResuls: Results<Object> = Results<Object>()
    
    private var goalResults: Results<Goal>?
    
        
    init() {
        // On init, want to preset the values for the pickers if user already chose one!
        let realm = try! Realm()
//
//        let goalResults = realm.objects(Goal.self)
//            .filter("user = %@", currentUser)
//
        goalResults = realm.objects(Goal.self)
            .filter("user = %@", currentUser)
        
        guard let gr = goalResults else {return}
        
        if gr.count != 0 {
            let goal = gr.first!
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
                    
                    Button(action: {
                        // Open realm to try insert/update weight goal
                        let realm = try! Realm()
                        
                        do {
                            // get already set User goal obj if they had one already,
                            // else make a new Goal()
                            
                            
//                            realm.write {
//
//                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        
                        
                        weightGoalSetSuccess.toggle()
                    }, label: {
                        Text("Confirm")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: 20)
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
                    
                    
                    Button(action: {
                        // Open realm to try insert/update water goal
                        
                        
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
    }//body
}//struct

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
