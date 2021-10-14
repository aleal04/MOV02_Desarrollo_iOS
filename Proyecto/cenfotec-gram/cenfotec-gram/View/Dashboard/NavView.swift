//
//  NavView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 13/9/21.
//

import SwiftUI

struct NavView: View {
    
    var colWidth: CGFloat
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(colWidth)),
            GridItem(.fixed(colWidth)),
            GridItem(.fixed(colWidth)),
        ]) {
            Spacer()
            
            Text("Cenfotec-gram")
                
        }
    }
}
