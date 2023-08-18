//
//  PostCombineData.swift
//  iOSAppTemplate
//
//  Created by apple on 16/08/23.
//

import Foundation

struct PostCombineData: Identifiable {
    let id: UUID
    let downloadUrl: URL
    let caption: String
    let date: Date
}
