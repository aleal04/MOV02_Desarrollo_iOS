//
//  ViewController.swift
//  Calculator
//
//  Created by Andrey Leal on 24/8/21.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var calculatorResults: UILabel!
    
    /*Numeros*/
    @IBOutlet weak var numCero: UIButton!
    @IBOutlet weak var numUno: UIButton!    
    @IBOutlet weak var numDos: UIButton!
    @IBOutlet weak var numTres: UIButton!
    @IBOutlet weak var numCuatro: UIButton!
    @IBOutlet weak var numCinco: UIButton!
    @IBOutlet weak var numSeis: UIButton!
    @IBOutlet weak var numSiete: UIButton!
    @IBOutlet weak var numOcho: UIButton!
    @IBOutlet weak var numNueve: UIButton!
    
    /*Operadores*/
    @IBOutlet weak var opeSumar: UIButton!
    @IBOutlet weak var opeRestar: UIButton!
    @IBOutlet weak var opeMultiplicar: UIButton!
    @IBOutlet weak var opeDividir: UIButton!
    @IBOutlet weak var opePorcentaje: UIButton!
    @IBOutlet weak var opeMasMenos: UIButton!
    @IBOutlet weak var opeLimpiar: UIButton!
    @IBOutlet weak var opeDecimal: UIButton!
    @IBOutlet weak var opeResultado: UIButton!
    
    /*Variables*/
    private var total: Double = 0
    private var temporal: Double = 0
    private var operando = false
    private var decimal = false
    private var operador: OperationType = .ningun
    
    /*Constantes*/
    private let kDecimalSeparador = Locale.current.decimalSeparator!
    private let kValMaximo = 13
    private let kTotal = "total"
    private enum OperationType {
        case ningun, sumar, restar, multiplicar, dividir, porcentaje
    }
    
    // Formateo de valores auxiliares
    private let FormateadorAuxiliares: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de valores que se imprimen en pantalla
    private let FormatImprimir: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // Formateo de valores totales
    private let FormateadorTotal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de valores por pantalla en formato científico
    private let FormateadorCientifico: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        limpiarPantalla()
        opeDecimal.setTitle(kDecimalSeparador, for: .normal)
        resultado()
    }
    
        
    @IBAction func opeLimpiarPush(_ sender: UIButton) {
        //Al presionar sobre el boton lmpiar, se limpia las variables y se setea el texto en pantalla en 0
        limpiarPantalla()
    }
    
    @IBAction func opePorcentajePush(_ sender: UIButton) {
        //Si hay alguna operacion por ejecutar, se ejecuta
        if operador != .porcentaje {
            resultado()
        }
        //Se cambia el operando a VERDADERO Y se asigna el operador PORCENTAJE a la variable operador
        operando = true
        operador = .porcentaje
        resultado()
    }
    
    @IBAction func opeDividirPush(_ sender: UIButton) {
        //Si hay alguna operacion por ejecutar, se ejecuta
        if operador != .ningun {
            resultado()
        }
        //Se cambia el operando a VERDADERO Y se asigna el operador DIVIDIR a la variable operador
        operando = true
        operador = .dividir
    }
    
    @IBAction func opeMultiplicarPush(_ sender: UIButton) {
        //Si hay alguna operacion por ejecutar, se ejecuta
        if operador != .ningun {
            resultado()
        }
        //Se cambia el operando a VERDADERO Y se asigna el operador MULTIPLICAR a la variable operador
        operando = true
        operador = .multiplicar
    }
    
    @IBAction func opeRestarPush(_ sender: UIButton) {
        //Si hay alguna operacion por ejecutar, se ejecuta
        if operador != .ningun {
            resultado()
        }
        //Se cambia el operando a VERDADERO Y se asigna el operador RESTAR a la variable operador
        operando = true
        operador = .restar
    }
    
    @IBAction func opeSumarPush(_ sender: UIButton) {
        //Si hay alguna operacion por ejecutar, se ejecuta
        if operador != .ningun {
            resultado()
        }
        //Se cambia el operando a VERDADERO Y se asigna el operador SUMAR a la variable operador
        operando = true
        operador = .sumar
    }
    
    @IBAction func opeResultadoPush(_ sender: UIButton) {
        //Se ejectua la operacion
        resultado()
    }
    
    @IBAction func opeMasMenosPush(_ sender: UIButton) {
        //Como se necesita cambiar el valor del numero, se multiplica x -1 para cambiar del mismo, ya sea para cambiarlo a positivo
        //o a negativo
        temporal = temporal * (-1)
        calculatorResults.text = FormatImprimir.string(from: NSNumber(value: temporal))
    }
    
    @IBAction func opeDecimalPush(_ sender: UIButton) {
        /*Se realizan las validaciones necesarias al presionar el boton decimal, ya sea por que no hay ningun numero en pantalla o
         en caso de que el numero en pantalla sea muy grande, o en otro caso, que el numero ya cuente con decimales*/
        let currentTemp = FormateadorAuxiliares.string(from: NSNumber(value: temporal))!
        if calculatorResults.text?.contains(kDecimalSeparador) ?? false || (!operando && currentTemp.count >= kValMaximo) {
            return
        }
        /*Si pasan las validaciones, al numero en pantalla se le asigna el valor decimal*/
        calculatorResults.text = calculatorResults.text! + kDecimalSeparador
        decimal = true
    }
    
    @IBAction func numberPush(_ sender: UIButton) {
        //Al presionar un numero, el texto de boton limpiar cambia a "C" de clear
        opeLimpiar.setTitle("C", for: .normal)
        
        //Se valida que el valor que se ingrese no este operando o no supere el limite maximo de numeros en pantalla
        var currentTemp = FormatImprimir.string(from: NSNumber(value: temporal))!
        if !operando && currentTemp.count >= kValMaximo {
            return
        }
        
        currentTemp = FormateadorAuxiliares.string(from: NSNumber(value: temporal))!
        
        /*Se valida si esta en proceso una operacion aritmetica, esto con el fin de no perder el valor numerica de la operacion*/
        if operando {
            total = total == 0 ? temporal : total
            calculatorResults.text = ""
            currentTemp = ""
            operando = false
        }
       
        /*Si la variable decimal es positiva, lo que estamos haciendo es agregar valores numericos a un numero preexistente
         y pasamos a falso la variable decimal*/
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparador)"
            decimal = false
        }
        
        //Se guardar el valor del numero presionado
        let number = sender.tag
        temporal = Double(currentTemp + String(number))!
        
        /*Se imprime en pantalla el numero presionado, concatenando dicho numero con otro valor o como valor inicial*/
        calculatorResults.text = FormatImprimir.string(from: NSNumber(value: temporal))
    }
    
    
    private func limpiarPantalla(){
        //Se limpiar el operador a ninguno para que no ejecute nignuna operacion
        operador = .ningun
        //Se cambiar el texto de limiar a "AC" de All Clear
        opeLimpiar.setTitle("AC", for: .normal)
        //Se limpian variables y se setea el texto en pantalla en 0
        if temporal != 0{
            temporal = 0
            calculatorResults.text = "0"
        }else{
            total = 0
        }
    }
    
    private func resultado(){
        switch operador
        {
        
        case .ningun:
            break
        case .sumar:
            total = total + temporal
            break
        case .restar:
            total = total - temporal
            break
        case .multiplicar:
            total = total * temporal
            break
        case .dividir:
            total = total / temporal
            break
        case .porcentaje:
            temporal = temporal / 100
            total = temporal
            break
        }
        
        if let currentTotal = FormateadorTotal.string(from: NSNumber(value: total)), currentTotal.count > kValMaximo {
            calculatorResults.text = FormateadorCientifico.string(from: NSNumber(value: total))
        } else {
            calculatorResults.text = FormatImprimir.string(from: NSNumber(value: total))
        }
        //Se setea la variable OPERADOR a ningun
        operador = .ningun
        UserDefaults.standard.set(total, forKey: kTotal)
    }

}

