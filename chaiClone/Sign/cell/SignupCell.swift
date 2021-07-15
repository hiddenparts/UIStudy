//
//  SignupCell.swift
//  chaiClone
//
//  Created by sangsun on 2021/07/15.
//

import UIKit

enum SignUpCellType {
    case phone // 휴대폰번호
    case RRN // 주민등록번호(Resident Registration Number)
    case telecom // 통신사
    case name // 이름
}

class SignupCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var field: UITextField!
    
    var type: SignUpCellType?
    
    override func prepareForReuse() {
        title.text = ""
        field.text = ""
    }
    
    func update() {
        switch type! {
        case .phone:
            title.text = "휴대폰번호"
        case .RRN:
            title.text = "주민등록번호"
        case .telecom:
            title.text = "통신사"
        case .name:
            title.text = "이름"
        default:
            title.text = "UNKNOWN"
        }
    }
}
