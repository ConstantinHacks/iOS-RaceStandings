//
//  ViewController.swift
//  RxSwiftFun
//
//  Created by Constantin Koehler on 12/18/17.
//  Copyright © 2017 Constantin Koehler. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfStandings>?
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Standings"
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfStandings>(
            configureCell: { ds, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StandingsCellIdentifier", for: indexPath) as! StandingsCell
                cell.placeLabel?.text = String(item.place)
                cell.nameLabel?.text = item.racerDetails.firstName + " " + item.racerDetails.lastName
                cell.constructorLabel?.text = item.constructorName.name
                cell.pointsLabel?.text = String(item.points)
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


}

