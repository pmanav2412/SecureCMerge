//
//  WebServiceViewController.swift
//  pdf
//
//  Created by yana on 11/29/18.
//  Copyright © 2018 yana. All rights reserved.
//

import UIKit
import PDFKit
import WebKit

class WebServiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var pdf1 = PDFDocument(url: url)
        var pdf2 = PDFDocument(url: url1)
        var urlb = url.baseURL
        var url1b = url1.baseURL
        //// function for base64 data /////////
        
        func convertImageTobase64(PDF:PDFDocument) -> String? {
            var pdfData: Data?
            pdfData = PDF.dataRepresentation()
            return pdfData?.base64EncodedString()
        }
        let base64String1 = convertImageTobase64(PDF: (pdf1)!)
        let base64String2 = convertImageTobase64(PDF: (pdf2)!)

        
        let parameter1 =
            [
                "Name":
                    [ "name1": urlb,
                      "name2": url1b
                ],
                
                "FileValues":
                    [
                        "Name1": "pdf2",
                        "Data1": base64String1,
                        "Name2": "pdf1",
                        "Data2": base64String2,
                ]
                ] as [String : Any]
        
        
        
        //// json data in other way ///////////////
        
        //            let parameter1 = [
        //                            "file1":
        //                            [
        //                            "Name1": "HW2_2018.pdf",
        //                            "Data1": base64String1
        //                            ],
        //                          "file2":
        //                            [
        //                            "Name1": "Requirement Document for Health Care Analytics.pdf",
        //                            "Data1": base64String2
        //                            ]
        //                        ]
        
        
        
        //  let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        //  create post request //
        let urlR = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        /*
         let url1 = URL(string: "https://v2.convertapi.com/convert/pdf/to/merge?Secret=sS3J2KC9owALSYXw")!
         
         */
        var request1 = URLRequest(url: urlR)
        request1.httpMethod = "POST"
        request1.addValue("application/json", forHTTPHeaderField: "content-Type")
        
        // insert json data to the request
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter1, options: []) else {return}
        request1.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request1){(data,response,error) in
            //print("response",response!)
            //print("data",data!)
            if let response = response{
                //print(response)
                //print(data!)
            }
            if let data = data{
                do{
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    print("data in base64=============================================================",json!)
                    
                }
                
            }
            
            
            //            if let responseJSON = responseJSON as? [String: Any] {
            //                print("please avi ja ====== ",responseJSON)
            //            }
            }.resume()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
