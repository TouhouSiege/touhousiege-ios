//
//  MarkdownView.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import SwiftUI

struct MarkdownView: View {
    @State private var showingSheet = false
    let vm = MarkdownViewModel()
    
    var body: some View {
        Text("MarkdownView")
        
        ButtonMainMenu(function: {
            showingSheet = true
        }, text: "Show Markdown")
        .sheet(isPresented: $showingSheet) {
            MarkdownPopup(attributedString: vm.attributedText(from: vm.markdownText()))
        }
    }
    
    struct MarkdownPopup: View {
        let attributedString: NSAttributedString
        @Environment(\.dismiss) private var dismiss // Applies to detailview
        
        var body: some View {
            VStack {
                AttributedTextView(attributedString: attributedString)
                    .padding()
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
    
    struct AttributedTextView: UIViewRepresentable {
        let attributedString: NSAttributedString
        
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            textView.isEditable = false
            textView.isScrollEnabled = true
            textView.adjustsFontForContentSizeCategory = true
            textView.textContainer.lineBreakMode = .byWordWrapping
            textView.textContainerInset = .zero
            textView.textContainer.lineFragmentPadding = 0
            textView.font = UIFont.preferredFont(forTextStyle: .body)
            textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            return textView
        }
        
        func updateUIView(_ uiView: UITextView, context: Context) {
            uiView.attributedText = attributedString
            uiView.setContentOffset(.zero, animated: false)
            uiView.sizeToFit()
        }
    }
}



#Preview {
    MarkdownView()
}
