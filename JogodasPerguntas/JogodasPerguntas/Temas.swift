//
//  Temas.swift
//  JogodasPerguntas
//
//  Created by Oliveira, Felipe Joaquim de on 23/04/26.
//

import SwiftUI

struct Temas: View {
    
    let temas = ["Futebol", "História", "Ciência", "Tecnologia", "Geografia"]
    
    @State private var temasSelecionados: Set<String> = []
    @State private var alertPerguntas: Bool = false
    @State private var habilitadoPerguntas: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Escolha os temas")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                ForEach(temas, id: \.self) { tema in
                    
                    Toggle(isOn: Binding(
                        get: {
                            temasSelecionados.contains(tema)
                        },
                        set: { value in
                            if value {
                                temasSelecionados.insert(tema)
                            } else {
                                temasSelecionados.remove(tema)
                            }
                        }
                    )) {
                        Text(tema)
                    }
                    .tint(Color.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.05), radius: 4)
                }
            }
            
            Spacer()
            
           
            Button {
                if temasSelecionados.isEmpty {
                    alertPerguntas = true
                } else {
                    habilitadoPerguntas = true
                }
            } label: {
                Text("Iniciar")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 200)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(14)
            }
            .navigationDestination(isPresented: $habilitadoPerguntas) {
                //(parâmetro da nova tela) : (variável da tela atual)
                QuizEstrutura(temasSelecionados: temasSelecionados)
            }
            
            .alert("Selecione um tema", isPresented: $alertPerguntas) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Escolha pelo menos um tema para iniciar o jogo.")
            }
            
            
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    Temas()
}
