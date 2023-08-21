//
//  FeedCell.swift
//  iOSAppTemplate
//
//  Created by apple on 09/08/23.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjextContext
    
    @Binding var postData : PostData
    @State private var showAddCaptionView: Bool = false
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack {
            // image + username
            HStack{
                Image("batman-icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text("Batman")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.leading, 8)
            
            KFImage(postData.downloadUrl)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            // action buttons
            HStack(spacing: 16){
                Button {
                    print("Likes on post")
                    self.isLiked.toggle()
                    PersistenceController.shared.updateLikesStatus(isLiked: isLiked, postData: postData, context: managedObjextContext)
                } label: {
                    Image(systemName: postData.isLiked ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundColor(postData.isLiked ? .red : .accentColor)
                }
                
                Button {
                    self.showAddCaptionView.toggle()
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }.sheet(isPresented: $showAddCaptionView) { AddCaptionView(postData:postData, presentedAsModal: $showAddCaptionView) }
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }

                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundColor(colorScheme == .light ? .black : .white)
            
            // likes label
            Text("23 likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth:  .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1 )
            
            // caption label
            HStack {
                Text("Batman ").fontWeight(.semibold) +
                Text(postData.caption!)
            }
            .frame(maxWidth:  .infinity, alignment: .leading)
            .font(.footnote)
            .padding(.leading, 10)
            .padding(.top, 1 )
            
            // timestamp
            Text(calculateTimeSince(date:  postData.date!))
                .frame(maxWidth:  .infinity, alignment: .leading)
                .font(.footnote)
                .padding(.leading, 10)
                .padding(.top, 1 )
                .foregroundColor(.gray)
        }
    }
}
