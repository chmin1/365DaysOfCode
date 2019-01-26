//
//  YearViewController.swift
//  YearOfCode
//
//  Created by Chavane Minto on 12/25/18.
//  Copyright © 2018 Chavane Minto. All rights reserved.
//

import UIKit
import CoreData

class YearViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var yearView: UICollectionView!
    
    var gradientColors: [UIColor] = []
    var selectedDays = Set<IndexPath>()
    let weeks = 73;
    let days = 5;
    var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    var year = NSManagedObject()
    
    
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
        yearView.allowsMultipleSelection = true;
        generateColors()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        let entitiy = NSEntityDescription.entity(forEntityName: "Years", in: context)
        year = NSManagedObject(entity: entitiy!, insertInto: context)
        year.setValue(selectedDays, forKey: "days")
        fetchDays()
    }
    
    func fetchDays() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Years")
        request.returnsObjectsAsFaults = false
        var date = 0;
        do {
            let results = try self.context.fetch(request) as! [NSManagedObject]
            for result in results {
                let resultDate = result.value(forKey: "date") as! Int
                if resultDate > date {
                    selectedDays = result.value(forKey: "days") as! Set<IndexPath>
                    date = resultDate
                }
            }
        } catch {
            print("failed to fetch...")
        }
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
        if selectedDays.contains(indexPath) {
            cell.backgroundColor = self.gradientColors[indexPath.section]
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = yearView.cellForItem(at: indexPath)
        cell!.backgroundColor = self.gradientColors[indexPath.section]
        if !selectedDays.contains(indexPath) {
            selectedDays.insert(indexPath)
            year.setValue(selectedDays, forKey: "days")
            year.setValue((indexPath.section * self.days) + indexPath.row + 1, forKey: "date")
            do {
               try context.save()
            } catch {
                print("failed to save...")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = yearView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
        selectedDays.remove(indexPath)
        year.setValue(selectedDays, forKey: "days")
        year.setValue((indexPath.section * self.days) + indexPath.row + 1, forKey: "date")
        do {
            try context.save()
        } catch {
            print("failed to save...")
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
