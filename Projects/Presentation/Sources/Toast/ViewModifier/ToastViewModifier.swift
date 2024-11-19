//
//  ToastViewModifier.swift
//  Presentation
//
//  Created by 유현진 on 11/19/24.
//

import SwiftUI

struct ToastViewModifier: ViewModifier {
    @Binding var toast: ToastModel?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack(){
                    makeToastView()
                }.animation(.spring, value: toast)
                    .padding(.horizontal)
            }
    }
    
    @ViewBuilder func makeToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                URLToastView(url: toast.url)
                    .frame(height: 100)
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

extension View {
    func toastView(toast: Binding<ToastModel?>) -> some View {
        self.modifier(ToastViewModifier(toast: toast))
    }
}
