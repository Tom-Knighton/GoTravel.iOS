//
//  Accessibility+GoTravel.swifts
//  GoTravel
//
//  Created by Tom Knighton on 10/12/2023.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    func accessibilityHidden() -> some View {
        self.accessibilityHidden(true)
    }
}
