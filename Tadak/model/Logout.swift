//
//  Logout.swift
//  Tadak
//
//  Created by Kang Minsang on 2021/01/16.
//

import Foundation
import Firebase

class Logout {
    static func tryLogout() -> Void{
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("로그아웃을 할 수 없습니다.", signOutError)
        }
    }
}
