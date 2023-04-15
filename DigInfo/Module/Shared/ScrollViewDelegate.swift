//
//  ScrollViewDelegate.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 09/04/23.
//

import SwiftUI

class ScrollViewDelegate: NSObject, UIScrollViewDelegate {
    @Binding var isNavBarHidden: Bool
    
    init(isNavBarHidden: Binding<Bool>) {
        self._isNavBarHidden = isNavBarHidden
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        withAnimation {
            self.isNavBarHidden = true
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.isNavBarHidden = false
            }
        }
    }
}
