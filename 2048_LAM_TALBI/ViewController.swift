//
//  ViewController.swift
//  2048_LAM_TALBI
//
//  Created by admin on 30/03/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var grille2048: UICollectionView!;
    @IBOutlet weak var remplir: UIButton!;
    
    var nombreLignes = 4;
    var nombreColonnes = 4;
    let espacementCellules = 10;
    var cellules: [[GameCell?]];
    
    required init?(coder aDecoder: NSCoder) {
        self.nombreLignes = 4
            self.nombreColonnes = 4
            cellules = [[]]
            cellules = ([[GameCell?]](repeating: [], count: nombreLignes))
            for j in 1...nombreLignes {
                let ligne = [GameCell?](repeating: nil, count: nombreColonnes)
                cellules[j-1] = ligne
                
            }
        
            super.init(coder: aDecoder)
    }
    
    init?(coder aDecoder: NSCoder, nombreLignes: Int, nombreColonnes:Int) { self.nombreLignes = nombreLignes
        self.nombreColonnes = nombreColonnes
        cellules = [[]]
        cellules = ([[GameCell?]](repeating: [], count: nombreLignes))
        for j in 1...nombreLignes {
            let ligne = [GameCell?](repeating: nil, count: nombreColonnes)
            cellules[j-1] = ligne
            
        }
    
        super.init(coder: aDecoder)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellules[indexPath.section][indexPath.row]!.dessineCellule()
        return cellules[indexPath.section][indexPath.row]!
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nombreLignes
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:0, height:CGFloat(espacementCellules))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: (grille2048.frame.width - CGFloat(espacementCellules*(nombreColonnes+2))) / CGFloat(nombreColonnes), height: (grille2048.frame.height - CGFloat(espacementCellules*(nombreLignes+2))) / CGFloat(nombreColonnes));
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return nombreLignes
    }
    @IBAction func rempli(sender: UIButton) {
        for i in 0..<nombreLignes {
            for j in 0..<nombreColonnes {
                cellules[i][j]!.valeur = Int(pow(2, Double(j+i*j)))
                
                                
            }
        }
    }
    
    @objc func mouvement(sender:UISwipeGestureRecognizer){
        switch sender.direction {
            case UISwipeGestureRecognizer.right:
                print("Droite")
            case UISwipeGestureRecognizer.left:
                print("Gauche")
            case UISwipeGestureRecognizer.up:
                print("Haut")
            case UISwipeGestureRecognizer.down:
                print("Bas")
            default:
                break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        grille2048.delegate = self
        grille2048.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(espacementCellules), bottom: 0, right: CGFloat(espacementCellules))
        layout.minimumLineSpacing = CGFloat(2)
        grille2048.setCollectionViewLayout(layout, animated: false)
        for i in 0...3{
            for j in 0...3{
                cellules[i][j] = grille2048.dequeueReusableCell(withReuseIdentifier: "cell2048", for:
                    NSIndexPath(row: i, section: j) as IndexPath) as? GameCell
            }
            
        }
        grille2048.backgroundColor = UIColor.gray
        let detectionMouvementR:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(self.mouvement))
        detectionMouvementR.direction = .right
        view.addGestureRecognizer(detectionMouvementR)
        let detectionMouvementL:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(self.mouvement))
        detectionMouvementL.direction = .left
        view.addGestureRecognizer(detectionMouvementL)
        let detectionMouvementH:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(self.mouvement))
        detectionMouvementH.direction = .up
        view.addGestureRecognizer(detectionMouvementH)
        let detectionMouvementB:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:
        #selector(self.mouvement))
        detectionMouvementB.direction = .down
        view.addGestureRecognizer(detectionMouvementB)
        //tesst
    }
    


}

