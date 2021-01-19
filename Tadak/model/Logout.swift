//
//  Logout.swift
//  Tadak
//
//  Created by Kang Minsang on 2021/01/16.
//

import Foundation
import Firebase

class Logout {
    static private var ref = Database.database().reference()
    
    static func tryLogout() -> Void{
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("로그아웃을 할 수 없습니다.", signOutError)
        }
    }
    
    static func deleteUser(nickName: String) -> Void {
        ref.child("users").child(Auth.auth().currentUser!.uid).child("PhoneNumber").removeValue()
        ref.child("users").child(Auth.auth().currentUser!.uid).child("nickname").removeValue()
        ref.child("users").child(Auth.auth().currentUser!.uid).child("uid").removeValue()
        
        ref.child("nickname").child(nickName).removeValue()
        print("remove nickname success")
        
        Logout.tryLogout()
        print("DELETE COMPLETE")
    }
}
