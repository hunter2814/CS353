//
//  ViewController.swift
//  RecoveryBank
//
//  Created by Hunter Lynch on 5/7/16.
//  Copyright © 2016 Hunter Lynch. All rights reserved.
//

import UIKit

struct Question {
    var questionString: String?
    var answers: [String]?
    var selectedAnswerIndex: Int?
}

var questionsList: [Question] = [Question(questionString: "How difficult was your activity?", answers: ["Easy(recovery day)", "Medium(meduim run/light workout)", "Hard(Primary workout/long run)", "Meet Day"], selectedAnswerIndex: nil), Question(questionString: "How much sleep did you get?", answers: ["5 or less", "6", "7", "8", "9+"],  selectedAnswerIndex: nil), Question(questionString: "How well did you sleep?", answers: ["good", "okay", "poor"],  selectedAnswerIndex: nil), Question(questionString: "Descrribe your energy level", answers: ["High", "Medium", "Low"],  selectedAnswerIndex: nil), Question(questionString: "Describe your appitite", answers: ["High", "Medium", "Low"],  selectedAnswerIndex: nil), Question(questionString: "Did you drink more than 64oz water?", answers: ["No", "Yes"], selectedAnswerIndex: nil), Question(questionString: "Did you take any vitamins?", answers: ["No","Yes"], selectedAnswerIndex: nil)]

class QuestionController: UITableViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recovery Bank"
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
        
        tableView.registerClass(AnswerCell.self, forCellReuseIdentifier: cellId)
        tableView.registerClass(QuestionHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        tableView.sectionHeaderHeight = 50
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let index = navigationController?.viewControllers.indexOf(self) {
            let question = questionsList[index]
            if let count = question.answers?.count {
                return count
            }
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! AnswerCell
        
        if let index = navigationController?.viewControllers.indexOf(self) {
            let question = questionsList[index]
            cell.nameLabel.text = question.answers?[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(headerId) as! QuestionHeader
        
        if let index = navigationController?.viewControllers.indexOf(self) {
            let question = questionsList[index]
            header.nameLabel.text = question.questionString
        }
        
        return header
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let index = navigationController?.viewControllers.indexOf(self) {
            questionsList[index].selectedAnswerIndex = indexPath.item
            
            if index < questionsList.count - 1 {
                let questionController = QuestionController()
                navigationController?.pushViewController(questionController, animated: true)
            } else {
                let controller = ResultsController()
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
}

class ResultsController: UIViewController {
    
    let resultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulations, you're Recovery Score is 100!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "done")
        
        navigationItem.title = "Results"
        
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(resultsLabel)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": resultsLabel]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": resultsLabel]))
        
        let totals = ["20","30", "40", "50", "60", "70", "80", "90", "100"]
        
        var score = 0
        for question in questionsList {
            score += question.selectedAnswerIndex!
        }
        
        let result = totals[score % totals.count]
        resultsLabel.text = "Congratulations, you're Recovery Score is \(result)!"
    }
    
    func done() {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}

class QuestionHeader: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Question"
        label.font = UIFont.boldSystemFontOfSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AnswerCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Answer"
        label.font = UIFont.systemFontOfSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
    
}
