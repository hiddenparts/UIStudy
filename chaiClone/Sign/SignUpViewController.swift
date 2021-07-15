//
//  SignUpViewController.swift
//  chaiClone
//
//  Created by sangsun on 2021/07/10.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellTypes: [SignUpCellType] = [.phone]
    
    var borderView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // transparent navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .interactive
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width - 30, height: 90)
        collectionView.collectionViewLayout = layout
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func keyboardDidShow() {
        self.collectionView.scrollToItem(at: [0, cellTypes.count - 1],
                                         at: .bottom,
                                         animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let firstCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) {
            borderView.isUserInteractionEnabled = false
            borderView.frame = firstCell.frame
            borderView.layer.cornerRadius = 30
            borderView.layer.borderWidth = 3
            borderView.layer.borderColor = UIColor.black.cgColor
            
            collectionView.addSubview(borderView)
        }
    }
    
    func moveBorderView(frame: CGRect) {
        UIView.animate(withDuration: 0.3) {
            self.borderView.frame = frame
        }
    }
    
    func moveBorderViewToFirst() {
        if let firstCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) {
            moveBorderView(frame: firstCell.frame)
        }
    }
    
}

extension SignUpViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignupCell.identifier, for: indexPath) as! SignupCell
        
        cell.contentView.layer.cornerRadius = 30
        cell.type = cellTypes[indexPath.item]
        
        cell.field.delegate = self
        cell.update()
        
        cell.field.becomeFirstResponder()
        
        return cell
    }
    
}

extension SignUpViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            moveBorderView(frame: cell.frame)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
        return view
    }
}

extension SignUpViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // 콜렉션뷰 헤더 조절
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 셀이 추가되는 시간을 조절하고 싶은데..
        collectionView.performBatchUpdates {
            switch cellTypes.count {
            case 1:
                cellTypes.insert(.RRN, at: 0)
            case 2:
                cellTypes.insert(.telecom, at: 0)
            case 3:
                cellTypes.insert(.name, at: 0)
            default:
                break
            }
            self.collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
        } completion: { complete in
            self.moveBorderViewToFirst()
        }
        return true
    }
}
