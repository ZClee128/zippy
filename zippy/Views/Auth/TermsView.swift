//
//  TermsView.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI

struct TermsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("User Agreement & Privacy Policy")
                            .font(.largeTitle)
                            .bold()
                            .padding(.bottom, 10)
                        
                        Text("1. Introduction")
                            .font(.headline)
                        Text("Welcome to Zippy! By accessing or using our mobile application, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our service.")
                            .font(.body)
                        
                        Text("2. User Content")
                            .font(.headline)
                        Text("You are solely responsible for the content (photos, videos, text) you post on Zippy. You retain ownership of your content, but grant Zippy a license to display and distribute it within the app.")
                            .font(.body)
                        
                        Text("3. Prohibited Conduct")
                            .font(.headline)
                        Text("You agree not to post any content that is illegal, offensive, threatening, libelous, defamatory, pornographic, or otherwise objectionable. We have a zero-tolerance policy for abuse, harassment, or hate speech.")
                            .font(.body)
                    }
                    
                    Group {
                        Text("4. Privacy Policy")
                            .font(.headline)
                        Text("We care about your privacy. We collect minimal data necessary to provide the service (e.g., email, username). We do not sell your personal data to third parties. Your location data and usage habits may be used to improve app experience.")
                            .font(.body)
                        
                        Text("5. Safety & Moderation")
                            .font(.headline)
                        Text("We strive to keep Zippy safe. Review inappropriate content and report users who violate our rules. We reserve the right to remove content and ban users at our discretion.")
                            .font(.body)
                        
                        Text("6. Changes to Terms")
                            .font(.headline)
                        Text("We may update these terms from time to time. Continued use of the app constitutes acceptance of any changes.")
                            .font(.body)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle(Text("Terms of Service"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView()
    }
}
