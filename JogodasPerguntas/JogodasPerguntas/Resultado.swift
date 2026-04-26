import SwiftUI

struct Resultado: View {
    
    @State private var resetarFluxo: Bool = false
    let acertos: Int
    let total: Int
    
    let encerrar: () -> Void
    
    
    var percentual: Double {
        total == 0 ? 0 : Double(acertos) / Double(total)
    }
    
    var mensagem: String {
        switch percentual {
        case 1:
            return "Perfeito! "
        case 0.7...:
            return "Muito bom! "
        case 0.4...:
            return "Bom esforço "
        default:
            return "Tente novamente "
        }
    }
    
    var body: some View {
        
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Text("Resultado")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(acertos) de \(total)")
                    .font(.system(size: 42, weight: .bold))
                
                Text(mensagem)
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button {
                    encerrar()
                } label: {
                    Text("Jogar novamente")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(14)
                }
                
            }
            .padding()
        }
        
        .navigationBarBackButtonHidden(true)
        .interactiveDismissDisabled(true)
    }
}

#Preview {
    Resultado(
        acertos: 3,
        total: 5,
        encerrar: { }
    )
}
