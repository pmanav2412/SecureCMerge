//
//  ShareFileViewController.swift
//  pdf
//
//  Created by yana on 11/30/18.
//  Copyright © 2018 yana. All rights reserved.
//

import UIKit
import UIKit.UIGraphicsRendererSubclass
import PDFKit
import QuartzCore

weak var TextView: UITextView!
var a:String!



class ShareFileViewController: UIViewController {
    var s:String = ""
    var imgs:Any = []
    var content:String = ""
    var finalpdf1:PDFDocument!
    var finalpdf2:PDFDocument!
    
    @IBOutlet weak var Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        let pdf = PDFDocument(url: url!)
        let pdf1 = PDFDocument(url: url1!)
        /*
        let object = PDFDocument()
        let page = pdf?.page(at: 0)
        a = page?.string


        let bb = a! as NSString
        let cc = bb.data(using: String.Encoding.utf8.rawValue)
        let dd = cc! as NSData
        let length = dd.length
        var myArray = [UInt8](repeating: 0, count: length)
        dd.getBytes(&myArray, length: length)

        let byte = a?.utf8
        print("byte",(byte?.count)!)

        var f:UIImage!
        f = drawPDFfromURL(url: url)
        imageView.image = f

        
        */
        
        
        
        
        //////// try for rendering the pdf data
        /*
        let pageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)  // size of the page
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)  // rendering object
        let title = "School report\n"
        let text = String(repeating: (page?.string)!, count: (page?.string?.count)!)
        let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]
         let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        let formattedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
        let formattedText = NSAttributedString(string: text, attributes: textAttributes)
        formattedTitle.append(formattedText)
        let data = renderer.pdfData { ctx in
            ctx.beginPage()
            
            formattedTitle.draw(in: pageRect.insetBy(dx: 50, dy: 50))
        }  */
        
        
        createPdfShareD(pdf: pdf!, PdfNum: 1)
        createPdfShareD(pdf: pdf1!, PdfNum: 2)
        
        
        
        
        /*  use webService to merge all shares     */
        
        
        /* first get all the pdf files */
        let share11 =  getSharesPDF(share: "Share11")
         let share12 =  getSharesPDF(share: "Share12")
         let share21 =  getSharesPDF(share: "Share21")
         let share22 =  getSharesPDF(share: "Share22")
        print("Share11",share11.pageCount,share12.pageCount,share21.pageCount,share22.pageCount)
        
        //// function for base64 data /////////
        for i in 1...2 {
        func convertImageTobase64(PDF:PDFDocument) -> String? {
            var pdfData: Data?
            pdfData = PDF.dataRepresentation()
            return pdfData?.base64EncodedString()
        }
            let base64String1:Any!
            let base64String2:Any!
            if i == 1 {
                base64String1 = convertImageTobase64(PDF: share11)
                base64String2 = convertImageTobase64(PDF: share21)
            }
            else
            {
                base64String1 = convertImageTobase64(PDF: share12)
                base64String2 = convertImageTobase64(PDF: share22)
            }
        
        let parameters = ["Parameters": [
            [
                "Name": "Files",
                "FileValues": [
                    [
                        "Name": "share11.pdf",
                        "Data": base64String1
                    ],
                    [
                        "Name": "share11.pdf",
                        "Data": base64String2
                    ]
                ]
            ]
            ]] as [String : Any]
        
        let url1 = URL(string: "https://v2.convertapi.com/convert/pdf/to/merge?Secret=sS3J2KC9owALSYXw")!
        
        
        var request1 = URLRequest(url: url1)
        request1.httpMethod = "POST"
        request1.addValue("application/json", forHTTPHeaderField: "content-Type")
        
        // insert json data to the request
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request1.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request1){(data,response,error) in
            print("response",response!)
            //print("data",data!)
            if let response = response{
                print(response)
                //print(data!)
            }
            if let data = data{
                do{
                    // let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : AnyObject]
                    
                    if  let files  = json["Files"] as? [[String : AnyObject]]
                    {
                        if i == 1{
                        self.saveBase64StringToPDF1(files[0]["FileData"] as! String)
                        }
                        else
                        {
                         self.saveBase64StringToPDF2(files[0]["FileData"] as! String)
                        }
                    }
                    
                    
                }
                catch{
                    
                }
                
            }
            
            
            }.resume()
        }// end of loop for two time
        
       finalpdf1 = getSharesPDF(share: "newDicrypted1")
       finalpdf2 = getSharesPDF(share: "newDicrypted2")
       
        print("hohoohjo=======",finalpdf1.pageCount,finalpdf2.pageCount)
        configureUI()
        loadPDF()
        
    }
    
    
    
   /* Functiuon for save web response as pdf */
    
    
    func saveBase64StringToPDF1(_ base64String: String) {
        //let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        //var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
        guard
            var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last,
            let convertedData = Data(base64Encoded: base64String)
            else {
                //handle error when getting documents URL
                return
        }
        
        //name your file however you prefer
        documentsURL.appendPathComponent("/Shares/Share1121.pdf")
        
        do {
            try convertedData.write(to: documentsURL)
            let request = URLRequest(url: documentsURL)
            DispatchQueue.main.async
                {
                    //self.webkitView.load(request)
                    //self.webkitView.frame = self.view.frame
            }
            
        } catch {
            //handle write error here
        }
        
        //if you want to get a quick output of where your
        //file was saved from the simulator on your machine
        //just print the documentsURL and go there in Finder
        print(documentsURL)
        let mypdf = PDFDocument(url: documentsURL)
        print("mypdf", ( mypdf?.pageCount)!)
    }
    
    
    
    func saveBase64StringToPDF2(_ base64String: String) {
        //let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        //var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
        guard
            var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last,
            let convertedData = Data(base64Encoded: base64String)
            else {
                //handle error when getting documents URL
                return
        }
        
        //name your file however you prefer
        documentsURL.appendPathComponent("/Shares/Share1222.pdf")
        
        do {
            try convertedData.write(to: documentsURL)
            let request = URLRequest(url: documentsURL)
            DispatchQueue.main.async
                {
                    //self.webkitView.load(request)
                    //self.webkitView.frame = self.view.frame
            }
            
        } catch {
            //handle write error here
        }
        
        //if you want to get a quick output of where your
        //file was saved from the simulator on your machine
        //just print the documentsURL and go there in Finder
        print(documentsURL)
    }
    
    private func loadPDF() {
        
        
        //let pdf = document1?.presentedItemURL
//        finalpdf1 = PDFDocument(url: url!)
//        finalpdf2 = PDFDocument(url: url1!)
        
        // print original Data
        let page = finalpdf1?.page(at: 1)
        //let content = (page?.attributedString)!
        //print("Original Data",content)
        
        
        var object = PDFDocument()
        for i in 0..<(finalpdf1?.pageCount)!{
            let page = finalpdf1?.page(at: i)
            object.insert(page!, at: i)
        }
        let pageCount = finalpdf1?.pageCount
        for i in 0..<(finalpdf2?.pageCount)!{
            let page = finalpdf2?.page(at: i)
            object.insert(page!, at: (pageCount!+i))
        }
        pdfView.document = object
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /* function to get shares as pdf documents  */
    
    func getSharesPDF(share: String) -> PDFDocument{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = "\(documentsPath)/Shares/\(share).pdf"
        let url21 = URL(fileURLWithPath: path)
        let pdf2123 = PDFDocument(url: url21)
        return pdf2123!
    }
    
    
    func createPdfShareD(pdf: PDFDocument, PdfNum: Int) {
    
       
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
            
            if let result = String(bytes: buffer, encoding:String.Encoding.ascii) {
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
        
        pdfData.write(toFile: "\(documentsPath)/Shares/newDicrypted\(PdfNum).pdf", atomically: true)
        
        print("saved success of D")
        
    }
    
    
//////////////// get image of the pdf
    
    
    @IBOutlet weak var imageView: UIImageView!
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
        }
        
        return img
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
        pdfView.canZoomIn()
    }
    
    

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


