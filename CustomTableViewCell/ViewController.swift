//
//  ViewController.swift
//  CustomTableViewCell
//
//  Created by ちいつんしん on 2021/03/09.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    struct Item {
        var title:String
        var image: UIImage?
        var titleIsHidden: Bool
        func buttonTitle(titleIsHidde:Bool) -> String {
            switch titleIsHidden {
                case true:
                    return "表示"
                case false:
                    return "非表示"
            }
        }

    }

    var cellArray = [Item]()
    let cellNumber = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        let item = Item(title: "text", image: UIImage(named: "bunny") ?? nil , titleIsHidden: false)

        for n in 0 ..< cellNumber {
            cellArray.append(item)
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse or create a cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)

        // For a standard cell, use the UITableViewCell properties.
        cell.textLabel!.text = cellArray[indexPath.row].title
        cell.imageView!.image = cellArray[indexPath.row].image
        cell.textLabel!.isHidden = cellArray[indexPath.row].titleIsHidden
        return cell
    }
    @IBAction func hide(_ sender: UIButton) {

        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            return
        }
        cellArray[indexPath.row].titleIsHidden = !cellArray[indexPath.row].titleIsHidden
        sender.setTitle(cellArray[indexPath.row].buttonTitle(titleIsHidde: cellArray[indexPath.row].titleIsHidden), for: .normal)
        tableView.reloadData()

    }
}

