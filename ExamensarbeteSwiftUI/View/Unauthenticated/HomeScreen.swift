import SwiftUI
import Markdown
import Markdownosaur

struct HomeScreen: View {
    @State private var showingSheet = false
    
    let stringOne = ""
    let stringTwo = "....."
    let stringThree = "....."
    let stringFour = "kdaskdaksdk"
    
    var body: some View {
        ZStack {
            BackgroundMain()
            
            VStack {
                Button("SHOW MARKDOWN") {
                    showingSheet = true
                }
                .sheet(isPresented: $showingSheet) {
                    MarkdownPopup(attributedString: attributedText(from: markdownText()))
                }
            }
        }
    }
    
    /// Transforms markdown text to NSAttributedString
    private func attributedText(from markdown: String) -> NSAttributedString {
        let document = Document(parsing: markdown)
        var markdownosaur = Markdownosaur()
        return markdownosaur.attributedString(from: document)
    }

    /// Gets text from "test.md"
    private func markdownText() -> String {
        let url = Bundle.main.url(forResource: "test", withExtension: "md")!
        let data = try! Data(contentsOf: url)
        return String(data: data, encoding: .utf8)!
    }
    
    struct MarkdownPopup: View {
        let attributedString: NSAttributedString
        
        var body: some View {
            VStack {
                AttributedTextView(attributedString: attributedString)
                    .padding()
                Button("Close") {
                    // Add action to close the sheet
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

func checkForLetters(comment: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[A-Za-z ]*$", options: [])
    let boolCheck = regex.firstMatch(in: comment, options: [], range: NSMakeRange(0, comment.utf16.count)) != nil
    
    return boolCheck
}

#Preview {
    HomeScreen()
}
