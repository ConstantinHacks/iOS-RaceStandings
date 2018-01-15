//
//  RacerStandingsViewController.swift
//  RxSwiftFun
//
//  Created by Constantin Koehler on 12/18/17.
//  Copyright © 2017 Constantin Koehler. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class RacerStandingsViewController: UIViewController, UIViewControllerPreviewingDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfStandings>?
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
 
        if( traitCollection.forceTouchCapability == .available){
            registerForPreviewing(with: self, sourceView: view)
        }
        
        collectionView.rx.itemSelected
            .debug("Collection View Cell Selected")
            .subscribe(onNext: { indexPath in
                let cell = self.collectionView.cellForItem(at: indexPath) as? StandingsCell
                
                if let racerInfo = cell?.racerInfo{
                    self.segueToDriverDetails(racerInfo: racerInfo)
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    func segueToDriverDetails(racerInfo: Racer){
        let destination = RacerDetailsViewController(nibName: "RacerDetails", bundle: Bundle.main)
        destination.racer = racerInfo
        self.show(destination, sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.dataSource = nil
        
        navigationController?.navigationBar.topItem?.title = "Standings (\(Year.selectedYear))"
        
        collectionView.allowsSelection = true
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfStandings>(
            configureCell: { ds, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StandingsCellIdentifier", for: indexPath) as! StandingsCell
                cell.placeLabel?.text = String(item.place)
                cell.nameLabel?.text = item.racerDetails.firstName + " " + item.racerDetails.lastName
                cell.constructorLabel?.text = item.constructorName.name
                cell.pointsLabel?.text = String(item.points)
                cell.racerInfo = item.racerDetails
        
                return cell
        })
        
        NetworkManager.getStandings(){ standings in
            let sections = [SectionOfStandings(header: "First Section", items: standings)]
            Observable.just(sections)
                .bind(to: self.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: self.disposeBag)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView?.indexPathForItem(at: location) else { return nil }
        
        guard let cell = collectionView?.cellForItem(at: indexPath) as? StandingsCell else { return nil }
        
        let racerDetailVC = RacerDetailsViewController(nibName: "RacerDetails", bundle: Bundle.main)
        
        let racerInfo = cell.racerInfo
        
        racerDetailVC.racer = racerInfo
        
        racerDetailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return racerDetailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit,sender: self)
    }
    
}



extension RacerStandingsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50);
    }
}

