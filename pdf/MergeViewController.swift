//
//  MergeViewController.swift
//  pdf
//
//  Created by yana on 11/16/18.
//  Copyright © 2018 yana. All rights reserved.
//

import UIKit
import PDFKit


class MergeViewController: UIViewController {
    var pdfView: PDFView!
    var document: UIDocument?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var object = PDFDocument.self
        let mergedShare1 = getPDF(share: "Share1121")
        let mergedShare2 = getPDF(share: "Share1222")
        print(mergedShare1.pageCount,mergedShare2.pageCount)
        PDFDicryption(pdf1: mergedShare1, pdf2: mergedShare2)
        
        configureUI()
        loadPDF()
        // Do any additional setup after loading the view.
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
    func PDFDicryption (pdf1:PDFDocument,pdf2: PDFDocument) {
        
        let render = UIPrintPageRenderer()
        let pdfData = NSMutableData()
        var pageData:String!
        for i in 0..<(pdf1.pageCount){
            var data1 = pdf1.page(at: i)?.string
            var data2 = pdf2.page(at: i)?.string
            let byte1 = data1?.utf8
            var buffer1 = [UInt8](byte1!)
            let byte2 = data2?.utf8
            var buffer2 = [UInt8](byte2!)
            var buffer = [UInt8](byte2!)
            for j in 0..<buffer1.count{
                
                var a = ( Int(buffer1[j]) * ((0-2)/(1-2)) ) + ( Int(buffer2[j]) * ((0-1)/(2-1)) )%127
                
                if a<0{
                    a = (a+127)%127
                    buffer[i] = UInt8(a)
                }
                else
                {
                    a = (a%127)
                    buffer[i] = UInt8(a)
                }
                //print(buffer[i])
            }
            
            if let result = String(bytes: buffer, encoding:String.Encoding.ascii) {
                // print("final result ",result)
                pageData = result
                
            }
            
            
            
            ////////////
            
            
            let formatter = UIMarkupTextPrintFormatter(markupText: pageData )
            
            
            ///// 2. Add formatter with pageRender
            
            
            render.addPrintFormatter(formatter, startingAtPageAt: i)
            
            
            ///// 3. Assign paperRect and printableRect
            
            let page1 = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
            let printable = page1.insetBy(dx: 0, dy: 0)
            
            render.setValue(NSValue(cgRect: page1), forKey: "paperRect")
            render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
            
            
            ///// 4. Create PDF context and draw
            
            let rect = CGRect.zero
            UIGraphicsBeginPDFContextToData(pdfData, rect, nil)
            
            for i in 1...render.numberOfPages
            {
                
                UIGraphicsBeginPDFPage();
                let bounds = UIGraphicsGetPDFContextBounds()
                render.drawPage(at: i - 1, in: bounds)
            }
            
            UIGraphicsEndPDFContext();
            
        }
        
        // 5. Save PDF file
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        pdfData.write(toFile: "\(documentsPath)/Shares/newDicrypted.pdf", atomically: true)
        
        print("saved success of D")
        return
    }
}

func getPDF(share: String) -> PDFDocument{
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let path = "\(documentsPath)/Shares/\(share).pdf"
    let url21 = URL(fileURLWithPath: path)
    let pdf2123 = PDFDocument(url: url21)
    return pdf2123!
}



//// CONVERTING PDF DATA TO BASE64 DATA /////////

func convertImageTobase64(PDF:PDFDocument) -> String? {
    var pdfData: Data?
    pdfData = PDF.dataRepresentation()
    return pdfData?.base64EncodedString()
}



private func loadPDF() {
    
    
    //let pdf = document1?.presentedItemURL
    let pdf1 = PDFDocument(url: url!)
    let pdf2 = PDFDocument(url: url1!)
    
    // print original Data
    let page = pdf1?.page(at: 1)
    let content = (page?.attributedString)!
    //print("Original Data",content)
    
    print("hahhaha",pdf2!)
    var object = PDFDocument()
    for i in 0..<(pdf1?.pageCount)!{
        let page = pdf1?.page(at: i)
        object.insert(page!, at: i)
    }
    let pageCount = pdf1?.pageCount
    for i in 0..<(pdf2?.pageCount)!{
        let page = pdf2?.page(at: i)
        object.insert(page!, at: (pageCount!+i))
    }
    pdfView.document = object


}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



        
        





