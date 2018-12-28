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
    let weeks = 52;
    let days = 7;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = yearView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = flowLayout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 7;
        let interItemSpacingTotal = flowLayout.minimumLineSpacing * (cellsPerLine - 1)
        let width = yearView.frame.size.width / cellsPerLine - interItemSpacingTotal/cellsPerLine;
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
        flowLayout.itemSize = CGSize(width: width, height: width)

        yearView.delegate = self;
        yearView.dataSource = self;
        generateColors()
    }
    
    func generateColors() {
        for i in 0..<13 {
            let progress = CGFloat(13-i)
            let newRed = CGFloat((progress/13.0) * 255.0 + CGFloat(i)/13.0 * 165.0) / 255.0
            let newGreen = CGFloat((progress/13.0) * 115.0 + CGFloat(i)/13.0 * 31.0) / 255.0
            let newBlue = CGFloat((progress/13.0) * 8.0 + CGFloat(i)/13.0 * 255.0) / 255.0
            self.gradientColors.append(UIColor(red: newRed,
                                               green: newGreen,
                                               blue: newBlue,
                                               alpha: 1.0))
        }
        
        for i in 0..<13 {
            let progress = CGFloat(13-i)
            let newRed = CGFloat((progress/13.0) * 165.0 + CGFloat(i)/13.0 * 99.0) / 255.0
            let newGreen = CGFloat((progress/13.0) * 31.0 + CGFloat(i)/13.0 * 255.0) / 255.0
            let newBlue = CGFloat((progress/13.0) * 255.0 + CGFloat(i)/13.0 * 172.0) / 255.0
            self.gradientColors.append(UIColor(red: newRed,
                                               green: newGreen,
                                               blue: newBlue,
                                               alpha: 1.0))
        }
        
        for i in 0..<13 {
            let progress = CGFloat(13-i)
            let newRed = CGFloat((progress/13.0) * 99.0 + CGFloat(i)/13.0 * 5.0) / 255.0
            let newGreen = CGFloat((progress/13.0) * 255.0 + CGFloat(i)/13.0 * 134.0) / 255.0
            let newBlue = CGFloat((progress/13.0) * 172.0 + CGFloat(i)/13.0 * 255.0) / 255.0
            self.gradientColors.append(UIColor(red: newRed,
                                               green: newGreen,
                                               blue: newBlue,
                                               alpha: 1.0))
        }
        
        for i in 0..<13 {
            let progress = CGFloat(13-i)
            let newRed = CGFloat((progress/13.0) * 5.0 + CGFloat(i)/13.0 * 255.0) / 255.0
            let newGreen = CGFloat((progress/13.0) * 134.0 + CGFloat(i)/13.0 * 143.0) / 255.0
            let newBlue = CGFloat((progress/13.0) * 255.0 + CGFloat(i)/13.0 * 212.0) / 255.0
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
        let cell = yearView.dequeueReusableCell(withReuseIdentifier: "yearCell", for: indexPath)
        cell.backgroundColor = self.gradientColors[indexPath.section]
        return cell
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
