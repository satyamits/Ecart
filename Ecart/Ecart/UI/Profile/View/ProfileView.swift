//
//  ProfileView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//


import SwiftUI

struct ProfileView: View {
    // Sample data for the profile
    @State private var name: String = "Satyam Singh"
    @State private var email: String = "itsatyam04@gmail.com"
    @State private var profileImage: Image? = Image(systemName: "person.circle.fill")
    
    var body: some View {
        VStack {
            // Profile Header
            HStack {
                // Profile Picture
                profileImage?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 10)
                    .padding(.leading, 20)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.title)
                        .bold()
                    Text(email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(.top, 40)
            
            // Profile Options
            List {
                // Edit Profile
                Button(action: {
                    // Action for editing the profile
                    print("Edit Profile tapped")
                }) {
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                        Text("Edit Profile")
                    }
                }
                
                // Change Password
                Button(action: {
                    // Action for changing the password
                    print("Change Password tapped")
                }) {
                    HStack {
                        Image(systemName: "lock.circle.fill")
                        Text("Change Password")
                    }
                }
                
                // Notifications
                Button(action: {
                    // Action for managing notifications
                    print("Notifications tapped")
                }) {
                    HStack {
                        Image(systemName: "bell.circle.fill")
                        Text("Notifications")
                    }
                }
                
                // Logout
                Button(action: {
                    // Action for logging out
                    print("Logout tapped")
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            Spacer()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
