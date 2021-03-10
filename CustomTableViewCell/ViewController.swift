//
//  ViewController.swift
//  CustomTableViewCell
//
//  Created by ちいつんしん on 2021/03/09.
//

import UIKit

struct Item {
    var title:String
    var image: UIImage?
    var titleIsHidden: Bool
    var buttonTitle: String {
        switch titleIsHidden {
            case true:
                return "表示"
            case false:
                return "非表示"
        }
    }
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private var items = Array<Item>(repeating: Item(title: "text", image: UIImage(named: "bunny"), titleIsHidden: false), count: 20)


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse or create a cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath) as! BasicStyle

        cell.configure(
            item: items[indexPath.row],
            didTapHideButton: { [weak self] in
                self?.items[indexPath.row].titleIsHidden.toggle()
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        )
        return cell
    }
}

class BasicStyle: UITableViewCell {
    @IBOutlet private weak var hideButton: UIButton!

    private var didTapHideButtonHandler: () -> Void = {}

    func configure(item: Item, didTapHideButton: @escaping () -> Void) {
        textLabel?.text = item.title
        imageView?.image = item.image
        textLabel?.isHidden = item.titleIsHidden
        hideButton.setTitle(item.buttonTitle, for: .normal)
        didTapHideButtonHandler = didTapHideButton
    }

    @IBAction func didTapHideButton(_ sender: Any) {
        didTapHideButtonHandler()
    }
}
