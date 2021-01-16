//
//  User.swift
//  Tadak
//
//  Created by Kang Minsang on 2021/01/16.
//

import Foundation
import Firebase

class User {
    private var ref : DatabaseReference = Database.database().reference()
    
    func getNickNameAndThen (_ doNextStep : @escaping (_ nickNameToss:Dictionary<String,String>, _ nickName:String) -> Dictionary<String,String>) -> Void {
        var a : Dictionary<String,String> = [:]
        var b :Dictionary<String,String> = [:]
            ref.child("users")
                .child(Auth.auth().currentUser!.uid)
                .child("nickname")
                .observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                let children : NSEnumerator = snapshot.children
                for (child) in children {
                    let childSnapShot = child as? DataSnapshot
                    DispatchQueue.main.async {
                        b = doNextStep(a,childSnapShot?.value as? String ?? "")
                    }
                }
            }
        
    }
    
    func leaveGame () -> Void {
        
    }
}
