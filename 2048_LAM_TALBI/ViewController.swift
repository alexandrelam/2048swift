//
//  ViewController.swift
//  2048_LAM_TALBI
//
//  Created by admin on 30/03/2021.
//

import FirebaseDatabase
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let database = Database.database().reference()
    
    @IBOutlet weak var grille2048: UICollectionView!;
    @IBOutlet weak var remplir: UIButton!;
    @IBOutlet weak var scoreAffich: UILabel!;
    
    
    var score = 0;
    var mess = "Votre score: "
    var resumed = false;

    var ini = true;
    var AsMoved = 0;
    var nombreLignes = 4;
    var nombreColonnes = 4;
    let espacementCellules = 10;
    var cellules: [[GameCell?]];
    
    required init?(coder aDecoder: NSCoder) {
        self.nombreLignes = 4
            self.nombreColonnes = 4
        self.score = 0;
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
        self.score = 0
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
    
    func boardIsEmpty() -> Bool{
        var res: Bool = true

        for i in 0..<nombreLignes {
            for j in 0..<nombreColonnes {
                if(cellules[i][j]!.valeur != 0){
                    res = false
                }                
            }
        }

        return res
    }

    func boardIsFull() -> Bool{
        var res: Bool = true

        for i in 0..<nombreLignes {
            for j in 0..<nombreColonnes {
                if(cellules[i][j]!.valeur == 0){
                    res = false
                }                
            }
        }

        return res
    }

    func moveCellIndirection(ligne: Int, colonne: Int, newLigne: Int, newColonne:Int){
        let incrementedLine = ligne + newLigne
        let incrementColonne = colonne + newColonne
        if(0 <= incrementedLine && incrementedLine < nombreLignes && 0 <= incrementColonne && incrementColonne < nombreColonnes){ 
            if(celluleIsEmpty(ligne: incrementedLine, colonne: incrementColonne) && cellules[ligne][colonne]!.valeur != 0){
                cellules[incrementedLine][incrementColonne]!.valeur = cellules[ligne][colonne]!.valeur 
                cellules[ligne][colonne]!.valeur = 0
                self.AsMoved += 1
            }else if(cellules[ligne][colonne]!.valeur == cellules[incrementedLine][incrementColonne]!.valeur && cellules[ligne][colonne]!.fusion == false && cellules[incrementedLine][incrementColonne]!.fusion == false && cellules[ligne][colonne]!.valeur != 0){
                cellules[incrementedLine][incrementColonne]!.valeur = cellules[ligne][colonne]!.valeur * 2
                self.score = self.score + cellules[incrementedLine][incrementColonne]!.valeur
                cellules[ligne][colonne]!.valeur = 0
                cellules[incrementedLine][incrementColonne]!.fusion = true
                self.AsMoved += 1
                
            }
            
            moveCellIndirection(ligne: incrementedLine, colonne: incrementColonne, newLigne: newLigne, newColonne: newColonne)
        }
        displayScore()
    }

    func resetFusion(){
        for i in 0..<nombreLignes{
            for j in 0..<nombreColonnes{
                cellules[i][j]!.fusion = false
            }
        }
    }

    func moveAllCells(newLigne: Int, newColonne:Int){
        checkWin();
                if(newLigne == 1){
                    for ligne in 0..<nombreLignes{
                        for colonne in 0..<nombreColonnes{
                            var tmpLigne = nombreLignes - ligne - 1
                            moveCellIndirection(ligne: tmpLigne, colonne: colonne, newLigne: newLigne, newColonne: newColonne)
                        }
                    }
                }else if(newLigne == -1){
                    for ligne in 0..<nombreLignes{
                        for colonne in 0..<nombreColonnes{
                            moveCellIndirection(ligne: ligne, colonne: colonne, newLigne: newLigne, newColonne: newColonne)
                        }       
                    }
                }else if(newColonne == 1){
                    for ligne in 0..<nombreLignes{
                        for colonne in 0..<nombreColonnes{
                            var tmpColonne = nombreColonnes - colonne - 1
                            moveCellIndirection(ligne: ligne, colonne: tmpColonne, newLigne: newLigne, newColonne: newColonne)
                        }
                    }
                }else{
                    for ligne in 0..<nombreLignes{
                        for colonne in 0..<nombreColonnes{
                            moveCellIndirection(ligne: ligne, colonne: colonne, newLigne: newLigne, newColonne: newColonne)
                        }
                    }
                }
                
        if(boardIsFull() == true && AsMoved == 0){
                mess += String(score)
                let alert = UIAlertController(title: "Vous avez perdu", message: mess, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Recommencer", comment: "On recommence"), style: .default, handler: { action in self.resetGame()}))
                self.present(alert, animated: true, completion: nil)
                mess = "Votre score : "
            }
        
        if(AsMoved > 0){
            fillNewRandom();
        }
        resetFusion();
        resetAsMoved();
        }
            
        
    
   

    
    func resetAsMoved(){
        self.AsMoved = 0
        
    }
    

    func celluleIsEmpty(ligne:Int, colonne:Int) -> Bool{
        if(cellules[ligne][colonne]!.valeur != 0){
            return false
        }else{
            return true
        }
    }

    func resetGame(){
        for i in 0..<nombreLignes{
            for j in 0..<nombreColonnes{
                cellules[i][j]!.valeur = 0
            }
        }
        self.score = 0
        ini = true
    }

    func fillNewRandom() -> Void{
        if(self.AsMoved > 0 || ini == true){
        var ligne: Int = Int.random(in: 0..<nombreColonnes)
        var colonne: Int = Int.random(in: 0..<nombreLignes)
        while( !celluleIsEmpty(ligne: ligne, colonne: colonne)){
            ligne = Int.random(in: 0..<nombreColonnes)
            colonne = Int.random(in: 0..<nombreLignes)
        }
        let rdn_value: Int = Int.random(in: 0...1)
        cellules[ligne][colonne]!.valeur = 2 + 2*rdn_value
        }
        
    }
    
    func isWin() -> Bool{
        let res = false
        for i in 0..<nombreLignes{
            for j in 0..<nombreColonnes{
                if(cellules[i][j]!.valeur == 2048){
                    return true
                }
            }
            
        }
        return res
    }
    
    func setResumed(){
        self.resumed = true
    }
    
    func checkWin(){
        if(isWin() == true && resumed == false){
            let alertwin = UIAlertController(title: "Vous avez gagné !", message: nil, preferredStyle: .alert)
            alertwin.addAction(UIAlertAction(title: NSLocalizedString("Recommencer", comment: "On recommence"), style: .default, handler: { action in self.resetGame()}))
            alertwin.addAction(UIAlertAction(title: NSLocalizedString("Continuer", comment: "Continuer"), style: .default, handler: {actions in self.setResumed() }))
            self.present(alertwin, animated: true, completion: nil)        }
    }

    @IBAction func rempli(sender: UIButton) {
        if(boardIsEmpty()){
            for i in 0...1{ 
                fillNewRandom()
            }
            ini = false;
            
        }
    }
    
    
    @objc func mouvement(sender:UISwipeGestureRecognizer){
        switch sender.direction {
            case .right:
                moveAllCells(newLigne: 0, newColonne: 1)
            case .left:
                moveAllCells(newLigne: 0, newColonne: -1)
            case .up:
                moveAllCells(newLigne: -1, newColonne: 0)
            case .down:
                 moveAllCells(newLigne: 1, newColonne: 0)
            default:
                break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        database.child("score").observeSingleEvent(of: .value, with : {snapshot in 
            guard let value = snapshot.value as? [String: Any] else {
                return
            }

            print("Value : \(value)")
        })

        // Do any additional setup after loading the view.
        grille2048.delegate = self
        grille2048.dataSource = self
        displayScore();
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
    }
    
    func displayScore(){
        self.scoreAffich.text = String(self.score) ;
    }

}

