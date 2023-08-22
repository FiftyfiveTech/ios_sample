//
//  FeedView.swift
//  iOSAppTemplate
//
//  Created by apple on 09/08/23.
//

import SwiftUI
import CoreData

struct FeedView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObject
    @FetchRequest(sortDescriptors: [SortDescriptor(\PostData.date, order: SortOrder.reverse)]) var postData: FetchedResults<PostData>
    @ObservedObject var postImageVM = PostImageViewModel()
    @State private var items: [PostData] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(postData, id: \.self) { post in
                        FeedCell(postData: Binding(get: { post }, set: { _ in
                            // Update the caption in the CoreData model here
                            // You'll need to figure out how to update the caption in your data model
                        }))
                    }
                }
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(colorScheme == .light ? "Instagram-logo" : "InstagramLogoWhite")
                        .resizable()
                        .frame(width: 100, height: 32)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            }
        }
        .onAppear {
            if postData.isEmpty {
                postImageVM.getPostImagesData(context: managedObject)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
