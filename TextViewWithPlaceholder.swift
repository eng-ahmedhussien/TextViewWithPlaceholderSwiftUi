//
//  TextViewWithPlaceholder.swift
//  AlDwaaNewApp
//
//  Created by Eslam ALi on 16/08/2023.
//

import SwiftUI
import UIKit


struct TextViewWithPlaceholder: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font =  UIFont.preferredFont(forTextStyle: .body)
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.text = text.isEmpty ? placeholder : text
        textView.textColor = text.isEmpty ? UIColor(Color.theme.txtPlaceholder) : UIColor(Color.theme.primary)
        textView.backgroundColor =  UIColor(Color.theme.bgInput)
        textView.layer.cornerRadius = 25
        
        textView.contentInset = UIEdgeInsets(top: 10, left: -10, bottom: 10, right: -10)
    
        if LocalizationManager.shared.currentLanguage == .arabic {
            textView.textAlignment = .right
        }else{
            textView.textAlignment = .left
        }
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if text.isEmpty {
            uiView.text = placeholder
            uiView.textColor = UIColor(Color.theme.txtPlaceholder)
            if LocalizationManager.shared.currentLanguage == .arabic {
                uiView.contentInset = UIEdgeInsets(top: 10, left: -10, bottom: 10, right: 10)
            }else{
                uiView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: -10)
            }
        } else {
          
            uiView.text = text
            uiView.textColor = UIColor(Color.theme.primary)
            
            if LocalizationManager.shared.currentLanguage == .arabic {
                uiView.contentInset = UIEdgeInsets(top: 10, left: -10, bottom: 10, right: 8)
            }else{
                uiView.contentInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: -10)
            }
           
          
        }
        

    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextViewWithPlaceholder

        init(_ parent: TextViewWithPlaceholder) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
    
    
}
