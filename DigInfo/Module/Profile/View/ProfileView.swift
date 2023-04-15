//
//  ProfileView.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 09/04/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            photoView.frame(width: 300, height: 300).clipShape(Capsule()).padding(.bottom, 5)
            Text("Dhimas Putera Pangestu").font(.custom("Hoefler Text", size: 28)).multilineTextAlignment(.center).padding(.bottom, 5)
            Text("Mobile App Developer - Dicoding Academy").font(.custom("Hoefler Text", size: 18)).multilineTextAlignment(.center).padding(.bottom, 5)
            Text("dhimasputera@gmail.com").font(.custom("Hoefler Text", size: 16))
        }.navigationBarTitle(Text("Profile"),
                             displayMode: .automatic)
    }
}

extension ProfileView{
    var photoView: some View {
        Image("me")
            .resizable()
            .scaledToFit()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
