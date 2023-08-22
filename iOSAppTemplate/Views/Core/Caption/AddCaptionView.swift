//
//  AddCaptionView.swift
//  iOSAppTemplate
//
//  Created by apple on 14/08/23.
//

import SwiftUI

struct AddCaptionView: View {
    @Environment(\.managedObjectContext) var managedObjextContext
    @Environment(\.dismiss) var dismiss
    var postData: FetchedResults<PostData>.Element
    @ObservedObject private var caption = Caption()
    @Binding var presentedAsModal: Bool

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Batman ").fontWeight(.semibold) +
                    Text(caption.captionText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .padding(.leading, 10)
                .padding(.top, 1 )
            
                Spacer()
            
                TextField("Add Caption", text: $caption.captionText)
                    .padding(.all, 10)
            }
            .navigationTitle("Add/Update Caption")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Add")
                        PersistenceController.shared.updateCaption(caption: caption.captionText, postData: postData, context: managedObjextContext)
                        dismiss()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
