////
////  SSS.swift
////  pdf
////
////  Created by yana on 11/29/18.
////  Copyright © 2018 yana. All rights reserved.
////
//
//import Foundation
//import PDFKit
//import CSSSS
//
//
//public class SSS {
//    var Pdf1 = PDFDocument(url: url)
//    var Pdf2 = PDFDocument(url: url1)
//    
//     func CreateShares()
//    {
//        //var a[]:Any!
//        for i in 0 ..< (Pdf1?.pageCount)!{
//            let page = Pdf1?.page(at: i)
//            var object = page?.attributedString
//            for i in 0 ... (object?.length)!{
//                //var shares[] = shareTextSSS(object,2,2)
//                for i in 0 ... 1 {
//                    var object = PDFDocument()
//                    
//                    
//                    
//                }
//                
//            }
//            
//        }
//    }
//    
//    func shareTextSSS(Object: String,N: Int,K: Int)
//    {
//        guard let randomByteString = generateRandomBytes(length: t * 128) else {
//            return nil
//        }
//        
//        let randomBytesPointer = randomByteString.utf8String
//        guard let sharesCPointer = CSSSS.wrapped_allocate_shares(Int32(n)) else {
//            return nil
//        }
//        
//        let error = CSSSS.wrapped_split(sharesCPointer, secret.utf8String, 0, Int32(t), Int32(n), false, nil, false, randomBytesPointer, randomByteString.characters.count)
//        
//        defer {
//            // Free memory
//            _ = CSSSS.wrapped_free_shares(sharesCPointer, Int32(n))
//        }
//        
//        if error.rawValue == 0 {
//            var i = 0
//            var shares = [String]()
//            while sharesCPointer[i] != nil {
//                let shareCPointer = sharesCPointer[i]!
//                
//                let share = String(cString: shareCPointer)
//                shares.append(share)
//                
//                i += 1
//            }
//            
//            return shares
//        }
//        
//        return nil
//     return nil
//    }
//    func shareImageSSS(Object: UIImage,N: Int,K: Int){
//        public func combine(shares: [String]) -> String? {
//            
//            let tempSize = maxDegree
//            
//            let resultCPointer = UnsafeMutablePointer<Int8>.allocate(capacity: tempSize)
//            
//            let error = CSSSS.wrapped_combine(resultCPointer, tempSize, arrayToPointer(shares), Int32(shares.count), false, false)
//            
//            if error.rawValue == 0 {
//                return String(cString: resultCPointer)
//            }
//            
//            return nil
//        }
//    }
//    
//}
