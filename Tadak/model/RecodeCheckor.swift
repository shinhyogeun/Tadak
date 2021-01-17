//
//  RecodeCheckor.swift
//  Tadak
//
//  Created by Kang Minsang on 2021/01/17.
//

import Foundation
import Firebase

class RecodeCheckor {
    private var user : User = User()
    private var ref : DatabaseReference = Database.database().reference()
    
//    func recodeCompareAndUpdate() -> Void {
//        ref.child("ranking")
//            .child(GameList.name)
//            .child(GameContents.name)
//            .queryOrdered(byChild: "/RECODE")
//            .queryLimited(toFirst: 50)
//            .observeSingleEvent(of: DataEventType.value) { (snapShot,key) in
//                var empty : Array<NSDictionary> = []
//                let children : NSEnumerator = snapShot.children
//                for child in children {
//                    let childSnapShot = child as? DataSnapshot
//                    let childPost : NSDictionary = (childSnapShot?.value as? NSDictionary)!
//                    empty.append(childPost)
//                }
//                print(empty)
//            }
//        }
}
