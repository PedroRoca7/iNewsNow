//
//  UIViewController+Extension.swift
//  INewsNow
//
//  Created by Pedro Henrique on 05/03/24.
//

import UIKit
import SwiftUI

extension UIViewController {
    private struct SwiftUIViewControllerWrapper: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController,
                                    context: Self.Context) {}
    }
    
    var asSwiftUIView: some View {
        SwiftUIViewControllerWrapper(viewController: self)
    }
}

