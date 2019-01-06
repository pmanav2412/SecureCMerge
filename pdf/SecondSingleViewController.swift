//
//  SecondSingleViewController.swift
//  pdf
//
//  Created by yana on 11/27/18.
//  Copyright © 2018 yana. All rights reserved.
//

import UIKit
import PDFKit

class SecondSingleViewController: UIViewController {
    var s:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let pdf = PDFDocument(url: url1!)
        var object = PDFDocument()
        let page = pdf?.page(at: 0)
        let a = page?.string
        let byte = a?.utf8
        var buffer = [UInt8](byte!)
        for i in 0 ..< buffer.count{
            buffer[i] = buffer[i]+1
        }
       
        //print("this is buffer",buffer)
        if let result = String(bytes: buffer, encoding:String.Encoding.ascii) {
            
            s = result
        }
        //print(s)
        
       
        
        for i in 0..<(pdf?.pageCount)!{
            let page = pdf?.page(at: i)
            object.insert(page!, at: i)

        pdfView.document = object
        
       
            
        //////////////////////////////////////////////////
        
        // webservices
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
                        "Name1": "pdf1",
                        "Data1": base64String1,
                        "Name2": "pdf2",
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
        
        
        let urlR = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        //  let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        //  create post request //
        
        let urlRe = URL(string: "https://v2.convertapi.com/convert/pdf/to/merge?Secret=sS3J2KC9owALSYXw")!
         
        ///////////////////////////////////////\
        var request1 = URLRequest(url: urlR)
        request1.httpMethod = "POST"
        request1.addValue("application/json", forHTTPHeaderField: "content-Type")
        
        // insert json data to the request
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter1, options: []) else {return}
        var request2 = URLRequest(url: urlRe)
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
                    //print("data in base64=============================================================",json!)
                    
                }
                
            }
            
            
            //            if let responseJSON = responseJSON as? [String: Any] {
            //                print("please avi ja ====== ",responseJSON)
            //            }
            }.resume()
        
        // Do any additional setup after loading the view.
    }
    
   
    }
    
    private func configureUI() {
        
        pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
         pdfView.autoScales = true
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
        pdfView.displayMode = .singlePageContinuous

        // Do any additional setup after loading the view.
    }
        
    
        func GoBack(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Segue5", sender: self)
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
