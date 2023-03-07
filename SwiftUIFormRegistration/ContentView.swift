//
//  ContentView.swift
//  SwiftUIFormRegistration
//
//  Created by Arthur Soares on 06/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var userRegistrationViewModel = UserRegistrationViewModel()
    
    var body: some View {
        VStack {
            Text("Crie uma conta")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
        
            FormField(isSecureField: false, fieldValue: $userRegistrationViewModel.username, fieldName: "Usuário")
            RequirementText(texto: "Seu usuário deve ter no mínimo 4 carácteres", icone: userRegistrationViewModel.isUsernameLengthValid ? "checkmark.square" : "xmark.square", corIcone: userRegistrationViewModel.isUsernameLengthValid ? .green : Color(red: 251/255, green: 128/255, blue: 128/255))
                .padding(.vertical, 5)
                .padding(.bottom)
                .animation(.linear, value: userRegistrationViewModel.isUsernameLengthValid)
            
            
            FormField(isSecureField: true, fieldValue: $userRegistrationViewModel.password, fieldName: "Senha")
            Group {
                RequirementText(texto: "Sua senha deve ter no mínimo 8 carácteres", icone: userRegistrationViewModel.isPasswordLengthValid ? "lock.open" : "lock", corIcone: userRegistrationViewModel.isPasswordLengthValid ? .green : Color(red: 251/255, green: 128/255, blue: 128/255))
                    .animation(.linear, value: userRegistrationViewModel.isPasswordLengthValid)
                RequirementText(texto: "Sua senha deve ter no mínimo uma letra maiúscula", icone: userRegistrationViewModel.isPasswordCapitalLetter ? "lock.open" : "lock", corIcone: userRegistrationViewModel.isPasswordCapitalLetter ? .green : Color(red: 251/255, green: 128/255, blue: 128/255))
                    .animation(.linear, value: userRegistrationViewModel.isPasswordCapitalLetter)
                    .padding(.bottom)
            }
            .padding(.vertical,5)
    

            
            FormField(isSecureField: true, fieldValue: $userRegistrationViewModel.passwordConfirm, fieldName: "Confirme sua senha")
            RequirementText(texto: "A confirmação da senha deve ser igual a senha criada", icone: userRegistrationViewModel.isPasswordConfirmValid ? "lock.open" : "lock" , corIcone: userRegistrationViewModel.isPasswordConfirmValid ? .green : Color(red: 251/255, green: 128/255, blue: 128/255))
                .padding(.vertical,5)
                .padding(.bottom, 50)
                       
            Button(action: {
                
            }, label: {
                Text("Criar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            .padding(.bottom, 50)
            
            HStack{
                Text("Você já tem uma conta?")
                    .fontWeight(.heavy)
                Text("Entrar")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
            }
            
            Spacer()
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RequirementText: View {
    var texto: String
    var icone: String
    var corIcone: Color
    
    var body: some View {
        HStack {
            Image(systemName: icone)
                .foregroundColor(corIcone)
            Text(texto)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct FormField: View {
    var isSecureField: Bool
    @Binding var fieldValue: String
    var fieldName: String
    
    var body: some View {
        if isSecureField {
            SecureField(fieldName, text: $fieldValue)
                .padding(.horizontal)
        } else {
            TextField(fieldName, text: $fieldValue)
                .padding(.horizontal)
        }
        Divider()
            .frame(height: 1)
            .background(Color(red: 240/255, green: 240/255, blue: 240/255))
            .padding(.horizontal)
    }
}
