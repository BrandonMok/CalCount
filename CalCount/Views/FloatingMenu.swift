

import SwiftUI

struct FloatingMenu: View {
    
    //https://www.youtube.com/watch?v=QCvP-iFfbAg
    @State var showMenuItems = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showMenuItems {
                MenuItem(icon: "camera.fill")
            }

            Button(action: {
                // TODO - show items (add food, add water icons)
                showMenuItems.toggle()
                

            }, label: {
                Image(systemName: showMenuItems ? "xmark" : "plus")
                .font(.system(.title))
                .frame(width: 80, height: 80)
                .foregroundColor(Color.white)
            })
            .background(Color("PrimaryBlue"))
            .cornerRadius(38.5)
            .padding(.bottom, 20)
            .shadow(color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3)
                
        }//vstack
    }//body
}//struct

struct MenuItem: View {
    var icon: String
    
    var body: some View {
        ZStack {
            // OR do a btn with rounded corners?
            Button(action: {}, label: {
                Image(systemName: icon)
                    .padding()

            })
            .padding(8)
            .background(Color("PrimaryBlue"))   // change color to somethign darker
            .cornerRadius(50)
            
            
            
//            Button(action: {
//                print("button clicked~")
//
//            }, label: {
//                ZStack {
//                    Circle()
//                        .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
//                        .frame(width: 55, height: 55)
//                        Image(systemName: icon)
//                }
//            })
            
        }
    }
}

struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu()
    }
}
