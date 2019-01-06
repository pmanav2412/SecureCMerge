//
//  DocumentViewController.swift
//  pdf
//
//  Created by yana on 11/15/18.
//  Copyright © 2018 yana. All rights reserved.
//

import UIKit
import PDFKit
var url:URL!
var url1:URL!
var flag:Int?
var preLabel1:String!
var preLabel2:String!
var pdfView: PDFView!
class DocumentViewController: UIViewController {
    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var documentNameLabel1: UILabel!
 
    @IBOutlet weak var mergeBtn: UIButton!
    
    
    
    var document: UIDocument?
    
    //var SegueIdentifier: Int?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mergeBtn.isHidden = true
          self.navigationController?.isNavigationBarHidden = true
        if url != nil{
            documentNameLabel.text = url.lastPathComponent
        }
        if url1 != nil{
            documentNameLabel1.text = url1.lastPathComponent
        }
         var pdf = PDFDocument()
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
               
                
                if flag == 1
                {
                url = self.document?.presentedItemURL
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                    pdf = PDFDocument(url: url!)!
                    self.createPdfShare1(pdf: pdf, FileName: "Share11")
                    self.createPdfShare2(pdf: pdf, FileName: "Share12")
                    
                }
                else
                {
                url1 = self.document?.presentedItemURL
                      self.documentNameLabel1.text = self.document?.fileURL.lastPathComponent
                    pdf = PDFDocument(url: url1!)!
                    self.createPdfShare1(pdf: pdf, FileName: "Share21")
                    self.createPdfShare2(pdf: pdf, FileName: "Share22")
                }
                
                // Display the content of the document, e.g.:
                

            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
            
            
        })
        
        
    }
    
    
    
    
    /////////////////////////////
    
    private func configureUI() {
        
        pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
   
 
    @IBAction func SingleViewPdf(_ sender: UIButton){
        if url != nil {
            
            performSegue(withIdentifier: "Segue3", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: "Choose Pdf First", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default) { (action) in
                //
            }
            alert.addAction(action)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    
    
    @IBAction func ChoosePdf(_ sender: UIButton) {
        performSegue(withIdentifier: "Segue1", sender: self)
        //let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        // let VC2 = storyBoard.instantiateViewController(withIdentifier: "DocumentBrowserViewController") as! DocumentBrowserViewController
        
        buttonTag = sender.currentTitle
        //print("aa button nu name chhe bhai ",sender.currentTitle!)
    }
    
    
//    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if (segue.identifier == "Segue1") {
//            var VC2 : DocumentBrowserViewController = segue.destination as! DocumentBrowserViewController
//            VC2.buttonTag = sender.string
//
//        }
//        if (segue.identifier == "Segue1") {
//            var VC2 : DocumentBrowserViewController = segue.destination as! DocumentBrowserViewController
//            VC2.buttonTag = sender.string
//        }
//    }
    
    @IBAction func seeMerge(_ sender: Any) {
        if url != nil && url1 != nil{
            
            performSegue(withIdentifier: "Segue2", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: "Choose Both Pdf First", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default) { (action) in
                //
            }
            alert.addAction(action)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    @IBAction func SingleViewPdf1(_ sender: UIButton){
        if url1 != nil {
            
            performSegue(withIdentifier: "Segue4", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: "Choose Pdf First", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default) { (action) in
                //
            }
            alert.addAction(action)
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    
    
    //////////////////////////////////////   create share1 function
    
    func createPdfShare1(pdf: PDFDocument, FileName : String) {
        
        
        ///// 1. Create Print Formatter with input text.
        
       
        let render = UIPrintPageRenderer()
        print("pdfcount",pdf.pageCount)
        let pdfData = NSMutableData()
        for i in 0..<pdf.pageCount{
            
            var share1Data:String!
            ////// create share 1
            
            let b  = pdf.page(at: i)?.string
            let byte = b?.utf8
            
            
            var buffer = [UInt8](byte!)
            var Share1 = [UInt8](byte!)
            //let Share2 = [UInt8](byte1!)
            
            
            
            
            for i in 0..<buffer.count{
                
                let m = 5
                let n = (m*1 + Int(buffer[i]))
                let n1 = (m*2 + Int(buffer[i]))
                
                let y1 = n%127
                let y2 = n1%127
                Share1[i] =  UInt8(y1)
                //Share2[i] =  UInt8(y2)
                
                var a = ((y1 * ((0-2)/(1-2))) + (y2 * ((0-1)/(2-1))))%127
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
            
            if let result = String(bytes: Share1, encoding:String.Encoding.ascii) {
                // print("final result ",result)
                share1Data = result
            }
            
            
            ////////////
            
            
            let formatter = UIMarkupTextPrintFormatter(markupText: share1Data )
            
            
            ///// 2. Add formatter with pageRender
            
            
            render.addPrintFormatter(formatter, startingAtPageAt: i)
            
            
            ///// 3. Assign paperRect and printableRect
            
            let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
            let printable = page.insetBy(dx: 0, dy: 0)
            
            render.setValue(NSValue(cgRect: page), forKey: "paperRect")
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
        
        pdfData.write(toFile: "\(documentsPath)/Shares/\(FileName).pdf", atomically: true)
        
        print("saved success of 1")
        
    }
    
    
    
    
      //////////////////////////////////////   create share2 function
    
    
    func createPdfShare2(pdf: PDFDocument, FileName : String) {
        
        
        ///// 1. Create Print Formatter with input text.
        
        
        let render = UIPrintPageRenderer()
        print("pdfcount",pdf.pageCount)
        let pdfData = NSMutableData()
        for i in 0..<pdf.pageCount{
            
            var share1Data:String!
            ////// create share 1
            
            let b  = pdf.page(at: i)?.string
            let byte = b?.utf8
            
            
            var buffer = [UInt8](byte!)
            var Share1 = [UInt8](byte!)
            var Share2 = [UInt8](byte!)
            
            
            
            
            for i in 0..<buffer.count{
                
                let m = 5
                let n = (m*1 + Int(buffer[i]))
                let n1 = (m*2 + Int(buffer[i]))
                
                let y1 = n%127
                let y2 = n1%127
                Share1[i] =  UInt8(y1)
                Share2[i] =  UInt8(y2)
                
                var a = ((y1 * ((0-2)/(1-2))) + (y2 * ((0-1)/(2-1))))%127
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
            
            if let result = String(bytes: Share2, encoding:String.Encoding.ascii) {
                // print("final result ",result)
                share1Data = result
            }
            
            
            ////////////
            
            
            let formatter = UIMarkupTextPrintFormatter(markupText: share1Data )
            
            
            ///// 2. Add formatter with pageRender
            
            
            render.addPrintFormatter(formatter, startingAtPageAt: i)
            
            
            ///// 3. Assign paperRect and printableRect
            
            let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
            let printable = page.insetBy(dx: 0, dy: 0)
            
            render.setValue(NSValue(cgRect: page), forKey: "paperRect")
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
        
        pdfData.write(toFile: "\(documentsPath)/Shares/\(FileName).pdf", atomically: true)
        
        print("saved success of 1")
        
    }
    
    
}
