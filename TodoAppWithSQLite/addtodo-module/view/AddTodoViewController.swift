//
//  AddTodoViewController.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 3.02.2023.
//

import UIKit

class AddTodoCategoriesCell : UITableViewCell {
    
}

class AddTodoViewController: UIViewController {
    
    @IBOutlet weak var todoTitleTF: UITextField!
    
    @IBOutlet weak var todoDescriptionTF: UITextField!
    
    @IBOutlet weak var selectCategoryBTN: UIButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddTodoCategoriesCell.self, forCellReuseIdentifier: "addTodoCategoriesCell")
        
        categories.append(Category(category_id: 1, category_name: "deneme 1"))
        categories.append(Category(category_id: 2, category_name: "deneme 2"))
        categories.append(Category(category_id: 3, category_name: "deneme 3"))
        categories.append(Category(category_id: 4, category_name: "deneme 4"))
    }
    
    // Create transparent view for list
    func addTransparentView(frames:CGRect) {
        
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        // Table view
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width , height: 0)
        self.view.addSubview(tableView)
        
        tableView.layer.cornerRadius = 5
        
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width , height: CGFloat(self.categories.count * 50))
        },completion: nil )
    }
    
    // Remove transparent view
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width , height: 0)
        },completion: nil )
    }

    
    // Select category button
    @IBAction func onClickSelectCategoryBTN(_ sender: Any) {
        selectedButton = selectCategoryBTN
        addTransparentView(frames: selectCategoryBTN.frame)
    }
}

// Extension for table view
extension AddTodoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addTodoCategoriesCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.category_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        selectCategoryBTN.setTitle(category.category_name, for: .normal)
        removeTransparentView()
    }
    
}
