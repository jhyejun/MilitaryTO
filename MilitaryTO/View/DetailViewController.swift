//
//  DetailViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 29/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class DetailViewController<T: Military>: HJViewController {
    private var data: T?
    
    init(_ data: T?) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = "상세정보"
        self.data = data
        
        if let data = data as? Industry {
            setIndustry(data)
        } else if let data = data as? Professional {
            setProfessional(data)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setIndustry(_ data: Industry) {
        let nameLabel = UILabel().then {
            $0.text = data.name
            $0.textColor = .black
            $0.font = $0.font.withSize(20)
        }
        let kindLabel = UILabel().then {
            $0.text = data.kind
            $0.textColor = .black
            $0.font = $0.font.withSize(20)
        }
        let scaleLabel = UILabel().then {
            $0.text = data.scale
            $0.textColor = .black
            $0.font = $0.font.withSize(20)
        }
        let locationLabel = UILabel().then {
            $0.text = data.location
            $0.textColor = .black
            $0.font = $0.font.withSize(20)
        }
        
        let phoneNumberLabel = UILabel().then {
            $0.text = data.location
            $0.textColor = .black
            $0.font = $0.font.withSize(20)
        }
        
        //        case idx = "연번"
        //        case kind = "업종"
        //        case scale = "기업규모"
        //        case name = "업체명"
        //        case location = "소재지"
        //        case phoneNumber = "전화번호"
        //        case mainSubject = "주생산품목"
        //        case selectionYear = "선정년도"
        //        case totalTO = "배정인원(현역)-특성화고·마이스터고 졸업생 계"
        //        case beforeThreeConventionTO = "99년생 이전(3자 협약)"
        //        case beforeTwoConventionTO = "99년생 이전(2자 협약)"
        //        case threeConventionTO = "00년생 (3자 협약)"
        //        case isLimit = "배정제한여부"
        //        case region = "해당지방병무청"
        
    }
    
    func setProfessional(_ data: Professional) {
        
    }
}
