//
//  ErrorWrapper.swift
//  icu001
//
//  Created by Hanjun Kang on 7/1/23.
//

import Foundation

struct ErrorWrapper: Identifiable {
    internal init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }

    let id: UUID
    let error: Error
    let guidance: String


}
