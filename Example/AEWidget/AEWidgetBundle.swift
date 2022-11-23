//
//  AEWidgetBundle.swift
//  AEWidget
//
//  Created by Adam on 2022/11/22.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
struct AEWidgetBundle: WidgetBundle {
    var body: some Widget {
        AEWidget()
        AEWidgetLiveActivity()
    }
}
