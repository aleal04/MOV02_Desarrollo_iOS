//
//  ContentView.swift
//  calculator
//
//  Created by Andrey Leal on 4/9/21.
//

import SwiftUI

enum botonCalculadora: String{
    case cero ,uno , dos, tres , cuatro, cinco, seis , siete , ocho , nueve
    case igual , sumar , restar , multiplicar , dividir
    case ac , masmenos , porcentaje , punto
    
    var nombreBotones:String{
        switch self {
        case .cero: return "0"
        case .uno: return "1"
        case .dos: return "2"
        case .tres: return "3"
        case .cuatro: return "4"
        case .cinco: return "5"
        case .seis: return "6"
        case .siete: return "7"
        case .ocho: return "8"
        case .nueve: return "9"
        case .punto: return "."
        case .sumar: return "+"
        case .restar: return "-"
        case .masmenos: return "+/-"
        case .ac: return "AC"
        case .dividir: return "/"
        case .multiplicar: return "X"
        case .porcentaje: return "%"
        case .igual: return "="
        default:
            return "AC"
        }
    }
    
    var backgroundColor :Color{
        switch self {
        case .cero , .uno , .dos , .tres , .cuatro , .cinco , .seis , .siete , .ocho , .nueve , .punto:
            return Color(.darkGray)
        case .masmenos , .porcentaje , .ac :
            return Color(.gray)
        default:
            return Color(.orange)
        }
    }
    
}

class EnvGlobal: ObservableObject{
    @Published var display = ""
    
    func mostrarTexto(calculadora: botonCalculadora){
        self.display = calculadora.nombreBotones
    }
}

struct ContentView: View {
    @EnvironmentObject var env: EnvGlobal
    
    
    let buttons: [[botonCalculadora]] = [
        [.ac , .masmenos , .porcentaje , .dividir],
        [.siete , .ocho , .nueve , .multiplicar],
        [.cuatro , .cinco , .seis , .restar],
        [.uno , .dos , .tres , .sumar],
        [.cero , .punto , .igual]
        
    ]
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            VStack (spacing:12){
                
                HStack{
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 70))
                }.padding()
                
                ForEach(buttons, id: \.self) { data in
                    HStack{
                        ForEach(data , id: \.self){ infoButton in
                            
                            BotonCalculadoraView(button: infoButton)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct BotonCalculadoraView:View{
    var button: botonCalculadora
    
    @EnvironmentObject var env: EnvGlobal
    
    var body: some View{
        Button(action: {
            self.env.mostrarTexto(calculadora: button)
        }){
            Text(button.nombreBotones)
                .font(.system(size: 32))
                .frame(
                    width: buttonWidth(button: button),
                    height:((UIScreen.main.bounds.width - 5 * 12) / 4) ,
                    alignment: .center
                )
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button: button))
        }
    }
    
    func buttonWidth(button: botonCalculadora) -> CGFloat{
        if button == .cero{
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(EnvGlobal())
    }
}
