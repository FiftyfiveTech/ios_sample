//
//  SerachView.swift
//  iOSAppTemplate
//
//  Created by apple on 18/08/23.
//

import SwiftUI

struct SerachView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("This screen shows localiztion example")
                    .font(.title3)
                Text("Overview")
                Text("Localization is the process of translating and adapting your app into multiple languages and regions. Localize your app to provide access for users who speak a variety of languages, and who download from different App Store territories. First, internationalize your code with APIs that automatically format and translate strings correctly for the language and region. Then add support for content that includes plural nouns and verbs by following language plural rules to increase the accuracy of your translations.")
                Spacer()
            }
            .padding(.leading)
            .frame(alignment: .leading)
        }
        .navigationTitle("Overview")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SerachView_Previews: PreviewProvider {
    static var previews: some View {
        SerachView()
    }
}
