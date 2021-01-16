//
//  Login.swift
//  Tadak
//
//  Created by Kang Minsang on 2021/01/16.
//

import Foundation
import Firebase

class Login {
    
    static private var ref = Database.database().reference()
    
    //기존에 로그인 되어 있는지 여부 반환
    static func isAlreadyIn() -> Bool {
        print(Auth.auth().currentUser)
        return Auth.auth().currentUser != nil
    }
    //폰번호 전송 후 성공시
    static func ifSucceseSendingMessage (phoneNumber : String, completion: (() -> Void)?) -> Void {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, err) in
            if let error = err {
                return print(error)
            }
            
            UserDefaults.standard.set(verificationID,forKey: "authVerificationID")
            
            if let completion = completion {
                completion()
            }
        }
    }
    
    static func tryLogin(verificationCode : String,
                         completion : @escaping (_ isNewUser:Bool) -> Void) -> Void {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        else { return print("아직 유저디폴트에 값이 없습니다.") }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        var isNewUser = true
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error{
                print("로그인에 실패했습니다.")
                print(error.localizedDescription)
                return
            }
            let uid = ["uid":"\(Auth.auth().currentUser!.uid)"]
            let phoneNumebr = ["PhoneNumber":"\(String(describing: Auth.auth().currentUser!.phoneNumber))"]
            let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/uid" : uid,
                               "/users/\(Auth.auth().currentUser!.uid)/PhoneNumber" : phoneNumebr]

            self.ref.updateChildValues(childUpdate) { (error , databaseRef) in
                if let _ = error {
                    isNewUser = !isNewUser
                }
                DispatchQueue.main.async {
                    completion(isNewUser)
                }
            }
        }
    }
    
    static func ifInputNickNameUnique(nick: String, completion: @escaping (_ isErrorExite : Bool) -> Void ) -> Void {
        let nickname = ["nickname":"\(nick)"]
        let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/nickname" : nickname]
        let childUpdate2 = ["/nickname/\(nick)" : nickname]
        
        self.ref.updateChildValues(childUpdate) { (error, dataSnapshot) in
            if let _ = error{
                completion(true)
            } else{
                self.ref.updateChildValues(childUpdate2)
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
}
