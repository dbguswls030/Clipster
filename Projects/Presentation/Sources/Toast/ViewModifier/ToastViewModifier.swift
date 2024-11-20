//
//  ToastViewModifier.swift
//  Presentation
//
//  Created by 유현진 on 11/19/24.
//

import SwiftUI

struct ToastViewModifier: ViewModifier {
    @Binding var toast: ToastModel?
    @Binding var isPresentSaveURL: Bool
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack(){
                    makeCreateClipURLToastView()
                }
                .animation(.spring, value: toast)
                .padding(.horizontal)
            }
            .onChange(of: toast) { value in
                showToast()
            }
            
    }
    
    @ViewBuilder func makeCreateClipURLToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                URLToastView(url: toast.url){
                    dismissToast()
                } saveButonAction: {
                    showSaveURL()
                }
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
    
    private func showSaveURL(){
        isPresentSaveURL = true
    }
}

extension View {
    func toastView(toast: Binding<ToastModel?>, isPresentSaveURL: Binding<Bool>) -> some View {
        self.modifier(ToastViewModifier(toast: toast, isPresentSaveURL: isPresentSaveURL))
    }
}
