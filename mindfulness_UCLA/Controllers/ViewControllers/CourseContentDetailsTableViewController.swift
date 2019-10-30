//
//  CourseContentDetailsTableViewController.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/12/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import UIKit
import SafariServices
import PDFKit
import WebKit

class CourseContentDetailsTableViewController: UITableViewController {

    // MARK: Properties
    
    var webView: WKWebView!
    
    // title string
    var detailTitle: String?
    // array that holds the valid checked string tuples used to present the overview details
    var validOverviewOrderedContentStrings: [ (String, String) ]?
    // arrays to hold string tuples that are checked for valid content
    var validVideoStrings: [ (String, String) ]?
    var validVideosListStrings: [ (String, String) ]?
    var validReadingStrings: [ (String, String) ]?
    var validReadingsListStrings: [ (String, String) ]?
    // strings to display the text only about the practice sheets
    var validPracticeStrings: [ (String, String) ]?
    // strings to display the active practice sheets to use with PDFKit
    var validPracticeSheetsStrings: [ (String, String) ]?
    var validSupplementalMaterialsStrings: [ (String, String) ]?
    

    // MARK: - ViewController Lifecycle Functions
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the tableView for self sizing cells
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        if let detailTitle = detailTitle {
            
            title = detailTitle
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        tableView.reloadData()
//    }
  
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // here we will store the total number of rows
        var totalRows = 0
        
        // if valid overview content, then we loop through the array of arrays
        if let validOverviewOrderedContentStrings = validOverviewOrderedContentStrings {
            
            totalRows = validOverviewOrderedContentStrings.count
            
            // if valid videos content, then we loop through the array of arrays
            if let validVideosListStrings = validVideosListStrings {
                // set totalRows to individual tuple arrays count
                totalRows += validVideosListStrings.count
            }
        }
        // if valid videos content
        if let validVideosListStrings = validVideosListStrings {
            // set totalRows to individual tuple arrays count
            totalRows = validVideosListStrings.count
        }
        // if valid readings content
        if let validReadingsListStrings = validReadingsListStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validReadingsListStrings.count
        }
        // if valid practice strings content
        if let validPracticeStrings = validPracticeStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validPracticeStrings.count
        }
        // if valid practice sheets content
        if let validPracticeSheetsStrings = validPracticeSheetsStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validPracticeSheetsStrings.count
        }
        // if valid supplemental materials content
        if let validSupplementalMaterialsStrings = validSupplementalMaterialsStrings {
            // set totalRows to individual tuple arrays count
            totalRows =  validSupplementalMaterialsStrings.count
        }
        // in case the error case where ther are no valid rows to display in the tableView
        if totalRows == 0 {
            // handle the empty array error case
            print("ERROR: totalRows == 0 in CourseContentDetailsTableViewController.swift -> tableView(numberOfRowsInSection:) - line 98.")
        }
        return totalRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseContentDetailCell", for: indexPath) as? CourseContentDetailTableViewCell else {
            
            return UITableViewCell()
        }
        
        // set the CourseContentDetailTableViewCellDelegate
        cell.delegate = self
        
        // if valid overview content, then we loop through the array of arrays
        if let validOverviewOrderedContentStrings = validOverviewOrderedContentStrings {
            cell.isLinkActive = false
            cell.isPDFFile = false
            cell.tupleStrings = validOverviewOrderedContentStrings[indexPath.row]
        }
        // if valid videos content
        if let validVideosListStrings = validVideosListStrings {
            cell.isLinkActive = true
            cell.isPDFFile = false
            cell.tupleStrings = validVideosListStrings[indexPath.row]
        }
        // if valid readings content
        if let validReadingsListStrings = validReadingsListStrings {
            cell.isLinkActive = true
            cell.isPDFFile = false
            cell.tupleStrings = validReadingsListStrings[indexPath.row]
        }
        // if valid practice strings content
        if let validPracticeStrings = validPracticeStrings {
            cell.isLinkActive = false
            cell.isPDFFile = false
            cell.tupleStrings = validPracticeStrings[indexPath.row]
        }
        // if valid practice sheets content
        if let validPracticeSheetsStrings = validPracticeSheetsStrings {
            cell.isLinkActive = false
            cell.isPDFFile = true
            cell.tupleStrings = validPracticeSheetsStrings[indexPath.row]
        }
        // if valid supplemental materials content arrays
        if let validSupplementalMaterialsStrings = validSupplementalMaterialsStrings {
            cell.isLinkActive = true
            cell.isPDFFile = false
            cell.tupleStrings = validSupplementalMaterialsStrings[indexPath.row]
        }
        
        return cell
    }
}


extension CourseContentDetailsTableViewController:
                                        CourseContentDetailsTableViewCellDelegate, WKUIDelegate {
    
    // MARK: CourseContentDetailsTableViewCellDelegate functions
    
    // function to dismiss all subviews created in PDF viewing mode
    @objc func removeSubviews(sender: UIButton) {
        
        if let viewWithTag100 = self.view.viewWithTag(100) {
            viewWithTag100.removeFromSuperview()
        }else{
            print("couldn't remove webView with tag 100")
        }
        if let viewWithTag200 = self.view.viewWithTag(200) {
            viewWithTag200.removeFromSuperview()
        }else{
            print("couldn't remove shareFooterView with tag 200")
        }
        if let viewWithTag300 = self.view.viewWithTag(300) {
            viewWithTag300.removeFromSuperview()
        }else{
            print("couldn't remove dismissButton with tag 300")
        }
    }
    
    // function to create and display the pdf action sheet from screen bottom
    @objc func bringUpPDFActionSheet() {
        
    }
    
    func openWebViewButtonTapped(cell: CourseContentDetailTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            
            print("ERROR: nil value found for indexPath in CourseContentDetailsTableViewController.swift -> openWebViewButtonTapped(cell:) - line 172.")
            return
        }
        
        var tupleStrings = ("","")
        
        if let vidListStrings = validVideosListStrings {
            tupleStrings = vidListStrings[indexPath.row]
        }
        
        if let readingsListStrings = validReadingsListStrings {
            tupleStrings = readingsListStrings[indexPath.row]
        }
        
        if let sheetsListStrings = validPracticeSheetsStrings {
            tupleStrings = sheetsListStrings[indexPath.row]
        }
        
        if let materialsListStrings = validSupplementalMaterialsStrings {
            tupleStrings = materialsListStrings[indexPath.row]
        }
        // open the web page via safari services
        if let isLinkActive = cell.isLinkActive {
            
            if isLinkActive {
                
                let urlString = tupleStrings.1
                
                if let url = URL(string: urlString) {
                    
                    let safariVC = SFSafariViewController(url: url)
                    
                    safariVC.delegate = self
                    
                    self.present(safariVC, animated: true)
                }
            }
        }
        // open the .pdf file with PDFKit's PDFView object
        if let isPDFFile = cell.isPDFFile {
            
            if isPDFFile {
                
                let pdfFilePath = tupleStrings.1
                
                if let pdfToOpen = Bundle.main.url(forResource: pdfFilePath, withExtension: "pdf", subdirectory: nil, localization: nil) {
                    
                    do {
                        let data = try Data(contentsOf: pdfToOpen)
                        // create and configure WKWebView
                        let webConfiguration = WKWebViewConfiguration()
                        webView = WKWebView(frame: CGRect(x: 20, y: 20, width: view.frame.size.width - 40, height: (view.frame.size.height - 150)), configuration: webConfiguration)
                        webView.uiDelegate = self
                        webView.load(data, mimeType: "application/pdf", characterEncodingName: "", baseURL: pdfToOpen.deletingLastPathComponent())
                        webView.tag = 100
                        view.addSubview(webView)
                        // create and configure footer for PDF viewer
                        let shareFooterView = UIView(frame: CGRect(x: 0, y: (view.frame.size.height + view.bounds.minY - 72), width: view.frame.size.width, height: 72))
                        shareFooterView.backgroundColor = UIColor(displayP3Red: 66.0/255.0 , green: 135.0/255.0, blue: 245.0/255.0, alpha: 1.0)
                        shareFooterView.tag = 200
                        view.addSubview(shareFooterView)
                        // create and configure the webView and shareFooterView dismiss button
                        let dismissButton = UIButton(frame: CGRect(x: view.frame.size.width-64, y: 32, width: 24, height: 24))
                        dismissButton.setImage(UIImage(named: "blue-delete-100"), for: UIControl.State.normal)
                        dismissButton.addTarget(self, action: #selector(removeSubviews), for: UIControl.Event.touchUpInside)
                        dismissButton.tag = 300
                        view.addSubview(dismissButton)
                        // create and configure share button
                        let shareButton = UIButton(frame: CGRect(x: ((shareFooterView.frame.size.width/2) - 16), y: ((shareFooterView.frame.size.height/2) - 24) , width: 32, height: 32))
                        shareButton.setImage(UIImage(named: "white-share-rounded-90"), for: UIControl.State.normal)
                        dismissButton.addTarget(self, action: #selector(bringUpPDFActionSheet), for: UIControl.Event.touchUpInside)
                        shareFooterView.addSubview(shareButton)
                        
                    } catch {
                        print("ERROR: couldn't create Data from pdfToOpen \(error.localizedDescription) in CourseContentDetailsTableViewController.swift -> openWebViewButtonTapped(cell:) - line 232")
                    }
                }
            }
        }
    }
}


extension CourseContentDetailsTableViewController: SFSafariViewControllerDelegate {
    
    // MARK: - SafariServices protocol functions
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}

