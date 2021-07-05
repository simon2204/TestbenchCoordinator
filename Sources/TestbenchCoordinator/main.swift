//
//  main.swift
//  
//
//  Created by Simon Schöpke on 13.06.21.
//

import Foundation
import TestbenchMoodleAPI
import TestbenchAPIUploader

let uploadURL = URL(string: "http://127.0.0.1:8080/api/upload")!

let fileURL1 = URL(fileURLWithPath: "/Users/Simon/Desktop/test1234.txt")
let fileURL2 = URL(fileURLWithPath: "/Users/Simon/Desktop/katze5432.txt")

let file1 = try File(url: fileURL1, contentType: .plainText)
let file2 = try File(url: fileURL2, contentType: .plainText)

var formData = FormData(name: "files[]")
formData.appendFile(file1)
formData.appendFile(file2)

let uploader = FormDataUploader(formData: formData, url: uploadURL)
uploader.upload()
