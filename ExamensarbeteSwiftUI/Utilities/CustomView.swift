//
//  ViewControllerVM.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-04-24.
//

import SwiftUI

struct CustomView: View {
    @ObservedObject var viewModel: CustomViewModel
    
    init(viewModel: CustomViewModel) {
        self.viewModel = viewModel
        }
    
    var body: some View {
        VStack {
            
        }
    }
}
