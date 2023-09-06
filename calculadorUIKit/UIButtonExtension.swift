//
//  UIButtonExtension.swift
//  calculadorUIKit
//
//  Created by NAHUM MARTINEZ on 2/9/23.
//

import UIKit

private  let orange = UIColor(red:254/255, green: 148/255, blue: 0/255, alpha: 1)
private  let gray = UIColor(red:192/255, green: 182/255, blue: 183/255, alpha: 1)
extension UIButton {
    
    
    //Hacer borde redondo
    
    func fontSize(_ size: CGFloat){
        titleLabel?.font = .systemFont(ofSize:size)
    }
    
    func round(){
        layer.cornerRadius = bounds.height / 2.5
        clipsToBounds = true
    }
    
    //Brillo del boton
    
    func shine(){
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) {(completion) in
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 1
            })
            
        }
    }
    
    
    // Boton de operacion
    
    func selectOperation(_ selected: Bool){
        backgroundColor = selected ? gray : orange
        setTitleColor(selected ? orange : .white, for: .normal)
    }
    
  
}
