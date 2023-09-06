//
//  ViewController.swift
//  calculadorUIKit
//
//  Created by NAHUM MARTINEZ on 2/9/23.
//

import UIKit
import Toast

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var backgroundView: UIView!
    

    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorBg: UIButton!
    @IBOutlet weak var operatoresult: UIButton!
    @IBOutlet weak var operatorAddition: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    @IBOutlet weak var operatorSubtraction: UIButton!
    @IBOutlet weak var whitespace: UIButton!
    
    
    
    
    // MARK: -Variables
    
    private var total:Double = 0
    private var temporalValue: Double = 0 // Valor    que se mosrtrara en el label de las operaciones
    private var operating = false //Indicara la seleccion de un operador
    private var decimal = false //Indicar si el valor es decimal
    private var operation:OperationType = .none // Operacion actual
    private var isBackgroundBlack = false
   
    
    
    //MARK: -Enums  y constantes
    
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kMaxValue:Double = 999999999
    private let kMinValue: Double = 0.00000001
   
    
    private enum OperationType {
        case none, addition, subtraction, multiplication, division
    }
    
    
    
    private let printFormatter:NumberFormatter = {
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
    
    
    
    
    private let auxFormatter:NumberFormatter = {
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

    
    //MARK: - VIEWDIDLOAD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //UI
        
      
        
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        whitespace.round()
        
        operatorAC.round()
        operatoresult.round()
        operatorBg.round()
        
        operatorAddition.round()
        operatorSubtraction.round()
        operatorMultiplication.round()
        operatorDivision.round()
        
        
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        resultLabel.textColor = UIColor.black
        
        
       
      
        
        result()
    }

   // MARK: -Button Action
    
    @IBAction func operatorAcAction(_ sender: UIButton) {
        
        clear()
        
        sender.shine()
        
    }
    
    @IBAction func operatorResultAction(_ sender: UIButton) {
        
        result()
        
        sender.shine()
    }
    
    
    @IBAction func operatorAdditionAction(_ sender: UIButton) {
        
        
        if operation != .none {
            result()
        }
        
        operating = true
        operation = .addition
        
        
        
        sender.selectOperation(true)
        sender.shine()
    }
    
    
    @IBAction func operatorSubtractionAction(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }
        operating = true
        operation = .subtraction
        
        sender.selectOperation(true)
        sender.shine()
    }
    
    
    
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }
        operating = true
        operation = .multiplication
        
        sender.selectOperation(true)
        sender.shine()
    }
    
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        
        if operation != .none {
            result()
        }
        operating = true
        operation = .division
        
        sender.selectOperation(true)
        sender.shine()
    }
    
    
    @IBAction func operatorBgAction(_ sender: UIButton) {
        
        
        updateBgProperties()
        
        isBackgroundBlack = !isBackgroundBlack
        
        sender.shine()
    }
    
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        
        let currentTempValue = auxFormatter.string(from: NSNumber(value: temporalValue))!
        
        if !operating && currentTempValue.count >= kMaxLength {
            return
        }
        
        resultLabel.text = resultLabel.text! + kDecimalSeparator
        
        decimal = true
        selectOperation()
        sender.shine()
    }
    
    
    
    @IBAction func numberAction(_ sender: UIButton) {
        
        
        
        operatorAC.setTitle("C", for: .normal)
        
        var currentTempValue = auxFormatter.string(from: NSNumber(value: temporalValue))!
        
        if !operating && currentTempValue.count >= kMaxLength {
            return
        }
        
        //Se ha seleccionado una operacion
        
        if operating {
            total = total == 0 ? temporalValue  : total
            
            resultLabel.text = ""
            currentTempValue = ""
            operating = false
        }
        
        //Se ha seleccionado decimales
        
        if decimal {
            currentTempValue = "\(currentTempValue)\(kDecimalSeparator)"
            decimal = false
        }
        
        
        let number  = sender.tag
        
        temporalValue = Double(currentTempValue + String(number))!
        
        
        
        
        
        resultLabel.text = printFormatter.string(from: NSNumber(value: temporalValue) )
        
        
        
        
        selectOperation()
        sender.shine()
        
    }
    
    
    
    
    //Para limpiar la pantalla de las operaciones
    
    
    private func clear(){
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        
        if temporalValue != 0 {
            temporalValue = 0
            resultLabel.text = "0"
        }else {
            total = 0
            result()
        }
    }
    
    
    //Obtenemos el resultado final de la operacion
    
    private func result(){
        switch operation {
        case .none:
            
            break
        case .addition:
            
            total = total + temporalValue
            
            break
        case .subtraction:
            total = total - temporalValue
            break
        case .multiplication:
            total = total * temporalValue
            
            break
        case .division:
            
            total = total / temporalValue
            
            if temporalValue  == 0 {
                resultLabel.text  = "Error"
                toastMessage()
                return
            }
            
            break
        }
        
        
        //Formateo del numero
        
        if total <= kMaxValue || total >= kMinValue {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        operation = .none
        
        selectOperation()
        
        
    }
    
    private func selectOperation(){
        if !operating {
            operatorAddition.selectOperation(false)
            operatorSubtraction.selectOperation(false)
            operatorMultiplication.selectOperation(false)
            operatorDivision.selectOperation(false)

        }else {
            switch operation {
                
            case .none:
                operatorAddition.selectOperation(false)
                operatorSubtraction.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .addition:
                operatorAddition.selectOperation(true)
                operatorSubtraction.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .subtraction:
                operatorAddition.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(false)
                operatorSubtraction.selectOperation(true)
                break
            case .multiplication:
                operatorAddition.selectOperation(false)
                operatorSubtraction.selectOperation(false)
                operatorDivision.selectOperation(false)
                operatorMultiplication.selectOperation(true)
                break
            case .division:
                operatorAddition.selectOperation(false)
                operatorSubtraction.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(true)
                break
            }
        }
    }
    
    func toastMessage(){
        var style = ToastStyle()
        
        style.backgroundColor = .orange
        style.messageColor = .white
        style.messageFont = UIFont.systemFont(ofSize: 16)
        style.cornerRadius =  12
        style.verticalPadding = 20.0
        view.makeToast("No fue posible realizar la operación", duration: 3.0, position: .bottom, style: style)
    }
    
    func updateBgProperties(){
        
        switch isBackgroundBlack {
        case true:
            
            backgroundView.backgroundColor = UIColor.black
            resultLabel.textColor =  UIColor.white
            operatorBg.setTitle("W", for: .normal)
            
        case false:
            
            backgroundView.backgroundColor = UIColor.white
            resultLabel.textColor =  UIColor.black
            operatorBg.setTitle("B", for: .normal)
            
        }
    }
}

