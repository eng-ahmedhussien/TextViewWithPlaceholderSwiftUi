//
//  TextViewWithPlaceholder.swift
//  AlDwaaNewApp
//
//  Created by ahmed hussien on 16/08/2023.
//
import SwiftUI


struct TextViewWithPlaceholder: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            UITextViewWrapper(text: $text)
                .background(Color.theme.bgInput)
                .cornerRadius(25)
                .padding(.leading, -8)

            if $text.wrappedValue.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.theme.txtPlaceholder)
                    .padding(.leading, 18)
                    .padding(.top, 14)
            }
        }
    }
}

struct UITextViewWrapper: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.text = text
        textView.textColor = UIColor(Color.theme.primary)
        textView.backgroundColor = UIColor(Color.theme.bgInput)
        textView.layer.cornerRadius = 25

        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        if LocalizationManager.shared.currentLanguage == .arabic {
            textView.textAlignment = .right
        } else {
            textView.textAlignment = .left
        }
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: UITextViewWrapper

        init(_ parent: UITextViewWrapper) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}

struct ContentView_PreviewsTextsdkfljasl: PreviewProvider {
    static var previews: some View {
        TextViewWithPlaceholder(text: .constant(""), placeholder: "amar")
    }
}
