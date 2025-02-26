//
//  MakdownViewModel.swift
//  ExamensarbeteSwiftUI
//
//  Created by Michihide Sugito on 2025-02-26.
//

import Foundation
import Markdown

class MarkdownViewModel {
    
    /// Transforms markdown text to NSAttributedString
    func attributedText(from markdown: String) -> NSAttributedString {
        let document = Document(parsing: markdown)
        var markdownosaur = Markdownosaur()
        return markdownosaur.attributedString(from: document)
    }
    
    /// Gets text from "test.md"
    func markdownText() -> String {
        let url = Bundle.main.url(forResource: "test", withExtension: "md")!
        let data = try! Data(contentsOf: url)
        return String(data: data, encoding: .utf8)!
    }
}

