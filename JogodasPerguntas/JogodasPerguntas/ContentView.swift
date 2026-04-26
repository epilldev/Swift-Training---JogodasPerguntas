import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            
            //gradiente leve do branco ao gelo
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
                        
                        Text("Escolha seu tema preferido e teste seus conhecimentos. Evolua a cada pergunta.")
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
                    NavigationLink(destination: Temas()) {
                        Text("INICIAR O JOGO")
                            .font(.custom("GRIME SLIME", size: 18))
                            .foregroundColor(.white)
                            .frame(width: 200)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    
                    Text("© Felipe Joaquim")
                        .font(.caption2)
                        .foregroundColor(.gray)
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
