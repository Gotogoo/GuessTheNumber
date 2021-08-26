//
//  ContentView.swift
//  GuessNumberGame
//
//  Created by Facheng Liang on 2021/7/29.
//

import SwiftUI

struct ContentView: View {
  let viewModel: GameViewModel
  @State var isGameStart: Bool = true
  @State var inputValue: String = ""
  @State var showingAlert: Bool = false
  @State var isSuccess: Bool = false
  @State var isInputValideError: Bool = false
  @State var gameResult: [GameResult] = []
  
  var body: some View {
    VStack {
      Spacer()
      if isGameStart {
        Button(
          action: setUpGameStart,
          label: {
            Text("game start")
          }
        )
      } else {
        VStack {
          Spacer()
          List {
            ForEach(gameResult, id: \.self) { result in
              HStack {
                Spacer()
                Text(result.submitValue)
                Text(result.checkResult.message)
                Spacer()
              }
            }
          }
          .frame(width: 200, height: 300, alignment: .center)
          HStack {
            Spacer()
            TextField("", text: $inputValue)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(
              action: submit,
              label: {
                Text("submit")
              }
            )
            .alert(isPresented: $showingAlert) {
              Alert(
                title: Text(isSuccess
                              ? "Congratulate"
                              : isInputValideError
                              ? "input Error"
                              : "Game failure"),
                message: Text(isSuccess
                                ? ""
                                : isInputValideError
                                ? "Please enter the correct data format."
                                : "make persistent efforts!"),
                dismissButton: .cancel()
              )
            }
            Spacer()
          }
          Spacer()
        }
      }
      
      Spacer()
    }
  }
  
  private func setUpGameStart() {
    viewModel.start()
    isGameStart = false
  }
  private func submit() {
    gameResult = viewModel.submit(input: inputValue)
    inputValue = ""
    
    gameResult.forEach { item in
      if item.checkResult.message == "4A0B" {
        showingAlert = true
        isSuccess = true
      }
      
      if item.checkResult.message == "running out" {
        showingAlert = true
      }
      
      if item.checkResult.message == "invalid input" {
        showingAlert = true
        isInputValideError = true
      }
    }
  }
}
