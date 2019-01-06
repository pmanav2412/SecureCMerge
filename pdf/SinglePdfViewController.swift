//
//  SinglePdfViewController.swift
//  pdf
//
//  Created by yana on 11/26/18.
//  Copyright © 2018 yana. All rights reserved.
//

import UIKit
import PDFKit

class SinglePdfViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let pdf = PDFDocument(url: url!)
        var object = PDFDocument()
        for i in 0..<(pdf?.pageCount)!{
            let page = pdf?.page(at: i)
           
            object.insert(page!, at: i)
        }
        //let mergedShare1 = getSharesPDF(share: "Share1121")
       //let mergedShare2 = getSharesPDF(share: "Share1222")
       //let string1 = mergedShare1.page(at: 1)?.string
       //let string2 = mergedShare2.page(at: 1)?.string
//       let byte1 = string1?.utf8
//        let byte2 = string2?.utf8
//        let buffer1 = [UInt8](byte1!)
//         let buffer2 = [UInt8](byte2!)
//        print("count should same",buffer1.count,buffer2.count)
//      print(buffer1)
//        print(buffer2)
        
//        for i in 0..<finalpdf1.pageCount{
//
//            var share1Data:String!
//            ////// create share 1
//
//            let b  = pdf.page(at: i)?.string
//            let byte = b?.utf8
//
//
//            var buffer = [UInt8](byte!)
//            var Share1 = [UInt8](byte!)
//            //let Share2 = [UInt8](byte1!)
//
//
//
//
//            for i in 0..<buffer.count{
//
//                let m = 5
//                let n = (m*1 + Int(buffer[i]))
//                let n1 = (m*2 + Int(buffer[i]))
//
//                let y1 = n%177
//                let y2 = n1%177
//                Share1[i] =  UInt8(y1)
//                //Share2[i] =  UInt8(y2)
//
//                var a = ((y1 * ((0-2)/(1-2))) + (y2 * ((0-1)/(2-1))))%177
//                if a<0{
//                    a = (a+177)%177
//                    buffer[i] = UInt8(a)
//                }
//                else
//                {
//                    a = (a%177)
//                    buffer[i] = UInt8(a)
//                }
//                //print(buffer[i])
//            }
//
//            if let result = String(bytes: buffer, encoding:String.Encoding.ascii) {
//                // print("final result ",result)
//                share1Data = result
//            }

    
        
       pdfView.document = object
        
        // Do any additional setup after loading the view.
    }
    func getSharesPDF(share: String) -> PDFDocument{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = "\(documentsPath)/Shares/\(share).pdf"
        let url21 = URL(fileURLWithPath: path)
        let pdf2123 = PDFDocument(url: url21)
        return pdf2123!
    }
    
    private func configureUI() {
        
        pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        //pdfView.autoScales = true
        
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pdfView.displayMode = .singlePageContinuous
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
//       let h = page?.characterBounds(at: 1)
//        print( page?.characterIndex(at: CGPoint(x:238.35,y:686.97)))
//        print(h?.origin.x)
//        print(h?.origin.y)
//        print(h,page?.attributedString)
//        page?.attributedString
