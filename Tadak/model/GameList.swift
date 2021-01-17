//
//  GameList.swift
//  Tadak
//
//  Created by Kang Minsang on 2021/01/17.
//

import Foundation
import Firebase

class GameList {
    static private var ref : DatabaseReference = Database.database().reference()
    static var name : String = "Empty"
    static var body : [String] = []
    
    static func getGameListAndThen (pressedButtonText:String, completion: @escaping () -> Void) -> Void {
        self.name = pressedButtonText
        self.makeBodyEmpty()
        ref.child("gametitle")
            .child(pressedButtonText)
            .observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let children : NSEnumerator = snapshot.children
            for (child) in children {
                let childSnapShot = child as? DataSnapshot
                if let data = (childSnapShot?.value as? String) {
                    self.body.append(data)
                }
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    static private func makeBodyEmpty () -> Void {
        self.body = []
    }
    
}
