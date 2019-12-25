//
//  Login.swift
//  IOSTest
//
//  Created by Sirak Zeray on 10/29/19.
//  Copyright © 2019 Sirak Zeray. All rights reserved.
//

import Foundation


class Login {
    
    //MARK: - Variables
    var loginModel : LoginModel
    fileprivate let url = "http://dev.datechnologies.co/Tests/scripts/login.php"
    var timeDiffrence : Int64?
    
    
    
    //MARK: - Functions
    
    /// Makes an http request to log user into datbase
    func logUserIn(completion : @escaping (Result < Bool , Error>) ->()) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

       let headers = [
         "content-type": "application/x-www-form-urlencoded",
         "cache-control": "no-cache",
         "postman-token": "52e0c9bc-38d9-6292-46f4-3f6dcc082d4a",
         "date": formatter.string(from: date)
       ]

        let postData = NSMutableData(data: "email=\(loginModel.email)".data(using: String.Encoding.utf8)!)
        postData.append("&password=\(loginModel.password)".data(using: String.Encoding.utf8)!)

       let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                               cachePolicy: .useProtocolCachePolicy,
                                           timeoutInterval: 10.0)
       request.httpMethod = "POST"
       request.allHTTPHeaderFields = headers
       request.httpBody = postData as Data
       
        

       let session = URLSession.shared
       let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
         if (error != nil) {
            completion(.failure(error!))
         } else {
           let res = response as? HTTPURLResponse
           let resDate =  res!.allHeaderFields["Date"]! as! String // Response Time
           var reqDate = request.allHTTPHeaderFields!["Date"]! // Request Time
            reqDate += " EST"
            
            self.getTimeDiffrence(reqDate: reqDate, resDate: resDate)
            
    
            if res?.statusCode == 200 {
                 completion(.success(true))
            } else {
                completion(.success(false))
            }
          
         }
       })

       dataTask.resume()
    }
    
    /// Takes in the request time and the response time and calculaes the diffrence in miliseconds
    fileprivate func getTimeDiffrence(reqDate : String , resDate : String){
        let reqFormatter = DateFormatter()
        reqFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        let predate = reqFormatter.date(from: reqDate)!
        
        let resFormat =  DateFormatter()
        resFormat.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        let postdate = resFormat.date(from: resDate.uppercased())!
        
        print("Here is ur Request date " , predate)
        print("Here is Response date"   , postdate)
        timeDiffrence =  predate.millisecondsSince1970 - postdate.millisecondsSince1970
    }
    

    
    
 
    
    //MARK: - Static  Functions

    /// A  Static Function that checks if the email is a valid email
    static func isEmailValid(email : String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /// A Static Function that checks if the password has atleast on upercase letter in it   *   A valid password is 'Test123'  *
    static func isPasswordValid(password : String) -> Bool{
         let passwordRegEx = ".*[A-Z]+.*"

         let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
         return passwordPred.evaluate(with: password)
     }
    
    //MARK: - Init
    init(model : LoginModel) {
        loginModel = model
    }
    
}


extension Date {
    /// Returns the milisecond of data since millisecondsSince1970
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }


}
