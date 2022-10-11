//
//  SplashView.swift
//  BS23Task
//
//  Created by Romana on 11/10/22.
//

import SwiftUI

enum AnimationState{
    case normal
    case compress
    case expand
}

struct SplashView: View {
    @State private var animationState: AnimationState = .normal
    @State private var done: Bool = false
      
      func calculate() -> Double {
          switch animationState {
              case .compress:
                  return 0.5
              case .expand:
                  return 10.0
              case .normal:
                  return 0.8
          }
      }
      
        var body: some View {
            ZStack{

                HomeView().scaleEffect(done ? 1: 0.95)
                
                VStack{
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(calculate())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .opacity(done ? 0 : 1)
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.spring()){
                        animationState = .compress
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation(.spring()){
                                animationState = .expand
                                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0, initialVelocity: 0))
                                {
                                    done = true
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
