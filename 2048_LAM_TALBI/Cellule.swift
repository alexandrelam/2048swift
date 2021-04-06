//
//  Cellule.swift
//  2048_LAM_TALBI
//
//  Created by admin on 30/03/2021.
//

import Foundation
import UIKit

class GameCell: UICollectionViewCell {
    var valeur = 0 {
        didSet{
            dessineCellule();
        }
    }
    var implique = false;
    var texte: UILabel! = nil;
    
    override init(frame: CGRect){
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    func dessineCellule() {
        if texte == nil {
            texte = UILabel(frame: CGRect(x:0, y:0,width:self.bounds.size.width,height:self.bounds.size.height))
            texte.numberOfLines = 1
            texte.textAlignment = .center
            texte.textColor = UIColor.white
        }
        switch valeur {
        case let x where x == 2:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xeee4da)
        case let x where x == 4:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xecdfc7)
        case let x where x == 8:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xf3b179)
        case let x where x == 16:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xf59563)
        case let x where x == 32:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xfc7e59)
        case let x where x == 64:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xfe5c31)
        case let x where x == 128:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xecce71)
        case let x where x == 256:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xffcc4c)
        case let x where x == 512:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xecc750)
        case let x where x == 1024:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xecc440)
        case let x where x == 2048:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0xecc501)
        case let x where x > 2048:
            texte.text = "\(x)"
            self.backgroundColor = UIColorFromHex(rgbValue: 0x5ea0df) 
        case default:
            texte.text = ""
            self.backgroundColor = UIColor.darkGray
            
        }

        self.contentView.addSubview(texte) }
    
}
