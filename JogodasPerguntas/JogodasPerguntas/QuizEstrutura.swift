import SwiftUI

struct QuizEstrutura: View {
    
    
    @State private var acertos = 0
    @State private var irResultado = false
    @State private var resetarFluxo = false
    
    @State private var perguntaAtual = 0
    @State private var respostaSelecionada: Int? = nil
    
    @State private var respondeu = false
    
    // Temas escolhidos na tela anterior
    let temasSelecionados: Set<String>
    
    
    struct Question: Codable {
        let pergunta: String
        let alternativas: [String]
        let respostaCorreta: Int
        let tema: String
    }
    
    
    let perguntas: [Question] = carregarPerguntas()
    
    var perguntasFiltradas: [Question] {
        temasSelecionados.isEmpty
        ? perguntas
        : perguntas.filter { temasSelecionados.contains($0.tema) }
    }
    
    var body: some View {
        
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            if perguntasFiltradas.isEmpty {
                
                VStack(spacing: 16) {
                    Text("Nenhuma pergunta disponível")
                        .font(.headline)
                    
                    Text("Selecione um tema válido")
                        .foregroundColor(.secondary)
                }
                
            } else {
                
                VStack(spacing: 24) {
                    
                    // CONTADOR
                    Text("\(perguntaAtual + 1) de \(perguntasFiltradas.count)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    // PERGUNTA
                    Text(perguntasFiltradas[perguntaAtual].pergunta)
                        .font(.system(size: 20, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 8)
                    
                    // ALTERNATIVAS
                    VStack(spacing: 12) {
                        ForEach(0..<perguntasFiltradas[perguntaAtual].alternativas.count, id: \.self) { index in
                            
                            Button {
                                respostaSelecionada = index
                                
                                respondeu = true
                                
                            } label: {
                                HStack {
                                    Text(perguntasFiltradas[perguntaAtual].alternativas[index])
                                    Spacer()
                                }
                                .padding()
                                .background(corResposta(index: index))
                                .cornerRadius(14)
                                .shadow(color: .black.opacity(0.03), radius: 4)
                            }
                            .disabled(respondeu)
                        }
                    }
                    
                    Spacer()
                    
                    // BOTÃO PRÓXIMA
                    Button(action: proximaPergunta) {
                        Text("Próxima")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                // botão só ativa depois que respondeu
                                respondeu
                                ? Color.black
                                : Color.gray.opacity(0.3)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                    .disabled(!respondeu)
                }
                .padding()
            }
        }
        
        .navigationDestination(isPresented: $irResultado) {
            Resultado(
                acertos: acertos,
                total: perguntasFiltradas.count,
                encerrar: {
                    resetarFluxo = true
                }
            )
        }
        
        .navigationDestination(isPresented: $resetarFluxo) {
            Temas()
        }
    }
    
    func corResposta(index: Int) -> Color {
        if !respondeu {
            return respostaSelecionada == index
            ? Color.black.opacity(0.08)
            : Color.white
        }
        
        // depois de responder
        if index == respostaSelecionada {
            let pergunta = perguntasFiltradas[perguntaAtual]
            
            if index == pergunta.respostaCorreta {
                return Color.green.opacity(0.3) // acertou
            } else {
                return Color.red.opacity(0.3) // errou
            }
        }
        
        return Color.white
    }
    
    func proximaPergunta() {
        let pergunta = perguntasFiltradas[perguntaAtual]
        
        // valida acerto
        if respostaSelecionada == pergunta.respostaCorreta {
            acertos += 1
        }
        
        // avança ou finaliza
        if perguntaAtual < perguntasFiltradas.count - 1 {
            perguntaAtual += 1
            
            // reset de estado para próxima pergunta
            respostaSelecionada = nil
            respondeu = false
            
        } else {
            irResultado = true
        }
    }
    
    static func carregarPerguntas() -> [Question] {
        guard let url = Bundle.main.url(forResource: "perguntas", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let perguntas = try? JSONDecoder().decode([Question].self, from: data)
        else {
            print("Erro ao carregar perguntas")
            return []
        }
        
        return perguntas
    }
}

#Preview {
    QuizEstrutura(temasSelecionados: [])
}
