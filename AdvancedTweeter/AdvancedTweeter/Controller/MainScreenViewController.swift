//
//  MainScreenViewController.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 16/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit
import Dynatrace

class MainScreenViewController: UIViewController {

    @IBOutlet weak var Label_UserName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    var userName = ""
    let tableCell = "MainScreenTableViewCell"
    var newMessages: [Message] = []
    var viewModel = MainScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newAction(_ sender: UIButton) {

        loggReportForDynatrace()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "NewMessageViewControllerID") as! NewMessageViewController
        vc.userName = userName
        vc.tweetMessageDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupUI() {
        setBackgroundColor()
        Label_UserName.text = userName
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    func updateUI() {
        tableView.reloadData()
        indicator.stopAnimating()
    }
    
    func fetchData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        viewModel.loadAllMessages { [weak self] success in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func loggReportForDynatrace() {
        //Do logging for Dybatrace here:
        Dynatrace.identifyUser(userName)
//        DTXAction.reportError(withName: "My custom error", error: NSError(domain: "Global issue", code: 007, userInfo: nil))
        let myAction = DTXAction.enter(withName: #function)
        myAction?.reportEvent(withName: "Something important just happened")
        myAction?.leave()
        
        debugPrint("Dynatrace report logged here!!")
//        fatalError()
    }
}
//MARK: -UITableViewDataSource, UITableViewDelegate
extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! MainScreenTableViewCell
        let messageViewModel = viewModel.messages[indexPath.row]
        cell.messageViewModel = messageViewModel
        return cell
    }
}
//MARK: -UITableViewDataSource, TweetMessageDelegate
extension MainScreenViewController: TweetMessageDelegate {
  
    func MessageOnTweet(messages: [Message]) {
        for i in 0..<messages.count{
            self.viewModel.appendNewMessage(message: messages[i])
        }
        self.tableView.reloadData()
    }
}
