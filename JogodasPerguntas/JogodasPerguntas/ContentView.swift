import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.white,
                        Color(red: 0.95, green: 0.96, blue: 0.98)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    
                    // TOPO
                    VStack(alignment: .center, spacing: 12) {
                        
                        Text("JOGO DAS PERGUNTAS")
                            .font(.custom("GRIME SLIME", size: 34))
                            .foregroundColor(.black)
                            .shadow(color: .black.opacity(0.4), radius: 6, x: 0, y: 3)
                        
                        Text("Teste seus conhecimentos e evolua a cada pergunta.")
                            .font(.custom("GRIME SLIME", size: 15))
                            .foregroundColor(.black.opacity(0.95))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // IMAGEM
                    Image("Image")
                        .resizable()
                        .scaledToFit()
                    
                    Spacer()
                    
                    // BOTÃO
                    VStack(spacing: 12) {
                        
                        Text("Clique abaixo para iniciar")
                            .font(.custom("GRIME SLIME", size: 20))
                            .foregroundColor(.black.opacity(0.9))
                            .multilineTextAlignment(.center)
                        
                        //para ir para a proxima tela na hora do play
                        NavigationLink(destination: QuizEstrutura()) {
                            Image(systemName: "play.fill")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                                .frame(width: 70, height: 70)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(.horizontal)
                .padding(.top, 60)
            }
        }
    }
}

#Preview {
    ContentView()
}
