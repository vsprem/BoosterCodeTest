//
//  OrderedViewController.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 01.11.2021..
//

import UIKit

class OrderedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnCancel: UIButton!
    
    var viewModel: OrderedViewModel!
    
    enum Constants {
        static let cell = "cell"
        static let estimatedTableRowHeight: CGFloat = 40
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = viewModel.title
        self.navigationItem.setHidesBackButton(true, animated: true)
        setupTableView()
        btnCancel.setTitle(viewModel.btnTitle, for: .normal)
        
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = Constants.estimatedTableRowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func btnCanceAction() {
        viewModel.didTapCancel()
    }
}

extension OrderedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: Constants.cell)
        
        cell.selectionStyle = .none
        
        let item = viewModel.tableData[indexPath.row]
        guard let title = item.keys.first,
              let subtitle = item[title]
        else { return UITableViewCell() }
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        
        return cell
    }
}
