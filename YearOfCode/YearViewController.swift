//
//  YearViewController.swift
//  YearOfCode
//
//  Created by Chavane Minto on 12/25/18.
//  Copyright © 2018 Chavane Minto. All rights reserved.
//

import UIKit

class YearViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var yearView: UICollectionView!
    
    var gradientColors: [UIColor] = []
    var selectedDays = Set<IndexPath>()
    let weeks = 73;
    let days = 5;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = yearView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = flowLayout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = CGFloat(self.days);
        let interItemSpacingTotal = flowLayout.minimumLineSpacing * (cellsPerLine - 1)
        let width = yearView.frame.size.width / cellsPerLine - interItemSpacingTotal/cellsPerLine;
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
        flowLayout.itemSize = CGSize(width: width, height: width)

        yearView.delegate = self;
        yearView.dataSource = self;
        generateColors()
    }
    
    func generateColors() {
        for i in 0..<18 {
            let progress = CGFloat(18-i)
            let newRed = CGFloat((progress/18.0) * 255.0 + CGFloat(i)/18.0 * 165.0) / 255.0
            let newGreen = CGFloat((progress/18.0) * 115.0 + CGFloat(i)/18.0 * 31.0) / 255.0
            let newBlue = CGFloat((progress/18.0) * 8.0 + CGFloat(i)/18.0 * 255.0) / 255.0
            self.gradientColors.append(UIColor(red: newRed,
                                               green: newGreen,
                                               blue: newBlue,
                                               alpha: 1.0))
        }
        
        for i in 0..<18 {
            let progress = CGFloat(18-i)
            let newRed = CGFloat((progress/18.0) * 165.0 + CGFloat(i)/18.0 * 99.0) / 255.0
            let newGreen = CGFloat((progress/18.0) * 31.0 + CGFloat(i)/18.0 * 255.0) / 255.0
            let newBlue = CGFloat((progress/18.0) * 255.0 + CGFloat(i)/18.0 * 172.0) / 255.0
            self.gradientColors.append(UIColor(red: newRed,
                                               green: newGreen,
                                               blue: newBlue,
                                               alpha: 1.0))
        }
        
        for i in 0..<18 {
            let progress = CGFloat(18-i)
            let newRed = CGFloat((progress/18.0) * 99.0 + CGFloat(i)/18.0 * 5.0) / 255.0
            let newGreen = CGFloat((progress/18.0) * 255.0 + CGFloat(i)/18.0 * 184.0) / 255.0
            let newBlue = CGFloat((progress/18.0) * 172.0 + CGFloat(i)/18.0 * 255.0) / 255.0
            self.gradientColors.append(UIColor(red: newRed,
                                               green: newGreen,
                                               blue: newBlue,
                                               alpha: 1.0))
        }
        
        for i in 0...18 {
            let progress = CGFloat(18-i)
            let newRed = CGFloat((progress/18.0) * 5.0 + CGFloat(i)/18.0 * 255.0) / 255.0
            let newGreen = CGFloat((progress/18.0) * 184.0 + CGFloat(i)/18.0 * 143.0) / 255.0
            let newBlue = CGFloat((progress/18.0) * 255.0 + CGFloat(i)/18.0 * 212.0) / 255.0
            self.gradientColors.append(UIColor(red: newRed,
                                               green: newGreen,
                                               blue: newBlue,
                                               alpha: 1.0))
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.weeks;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = yearView.dequeueReusableCell(withReuseIdentifier: "yearCell", for: indexPath) as! yearCell
        cell.layer.borderWidth = 2.5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.dayLabel.text = "Day \((indexPath.section * self.days) + indexPath.row + 1)"
        if cell.isSelected {
            cell.backgroundColor = self.gradientColors[indexPath.section]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = yearView.cellForItem(at: indexPath)
        if cell!.isSelected {
            cell!.backgroundColor = self.gradientColors[indexPath.section]
        } else {
            cell!.backgroundColor = UIColor.white
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
