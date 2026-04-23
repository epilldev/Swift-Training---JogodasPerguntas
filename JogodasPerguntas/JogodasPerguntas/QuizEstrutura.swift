import SwiftUI

struct QuizEstrutura: View {
    
    struct Question {
        let pergunta: String
        let alternativas: [String]
        let respostaCorreta: Int
    }
    
    
    //vetorzinho com as perguntas
    let perguntas: [Question] = [
        Question(
            pergunta: "Swift é usado para qual plataforma?",
            alternativas: ["Android", "iOS", "Web", "Windows"],
            respostaCorreta: 1
        ),
        Question(
            pergunta: "Qual empresa criou o Swift?",
            alternativas: ["Google", "Apple", "Microsoft", "Amazon"],
            respostaCorreta: 1
        )
    ]
    
    @State private var perguntaAtual = 0
    @State private var respostaSelecionada: Int? = nil
    
    var body: some View {
        
        ZStack {
            // FUNDO PADRÃO IOS
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                // CONTADOR
                Text("\(perguntaAtual + 1) de \(perguntas.count)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                
                // PERGUNTA (CARD)
                Text(perguntas[perguntaAtual].pergunta)
                    .font(.system(size: 20, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                
                // ALTERNATIVAS
                VStack(spacing: 12) {
                    ForEach(0..<perguntas[perguntaAtual].alternativas.count, id: \.self) { index in
                        
                        Button(action: {
                            respostaSelecionada = index
                        }) {
                            HStack {
                                Text(perguntas[perguntaAtual].alternativas[index])
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            .padding()
                            .background(
                                respostaSelecionada == index
                                ? Color.black.opacity(0.08)
                                : Color.white
                            )
                            .cornerRadius(14)
                            .shadow(color: .black.opacity(0.03), radius: 4, x: 0, y: 2)
                        }
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
                            respostaSelecionada == nil
                            ? Color.gray.opacity(0.3)
                            : Color.black
                        )
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .disabled(respostaSelecionada == nil)
                
            }
            .padding()
        }
    }
    
    // LÓGICA DE AVANÇO
    func proximaPergunta() {
        if perguntaAtual < perguntas.count - 1 {
            perguntaAtual += 1
            respostaSelecionada = nil
        }
    }
}

#Preview {
    QuizEstrutura()
}
