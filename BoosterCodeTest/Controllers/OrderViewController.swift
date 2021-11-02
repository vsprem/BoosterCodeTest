//
//  OrderViewController.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 31.10.2021..
//

import UIKit

class OrderViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnOrder: UIButton!
    
    var viewModel: OrderViewModel!
    
    enum Constants {
        static let cellTime = "cellTimes"
        static let cellCard = "cellCard"
        static let estimatedTableRowHeight: CGFloat = 40
        static let headerHeight: CGFloat = 30
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = viewModel.title
        setupTableView()
        btnOrder.setTitle(viewModel.btnTitle, for: .normal)
        btnOrder.isEnabled = false
        
        viewModel.getOrderData {
            tableView.reloadData()
        } error: { _ in
            //Not used
        }
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = Constants.estimatedTableRowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func btnOrderAction() {
        viewModel.sendOrder()
    }
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.orderData?.deliveryTimes.count ?? 0
        case 1:
            return viewModel.orderData?.cards.count ?? 0
        default:
            print("Out of bounds for some reason")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellTime) ??
                UITableViewCell(style: .default, reuseIdentifier: Constants.cellTime)
            
            let deliveryTime = viewModel.orderData?.deliveryTimes[indexPath.row]
            
            cell.textLabel?.text = deliveryTime?.name
            
            cell.accessoryType = (indexPath.row == viewModel.selectedDeliveryTimeIndex ? .checkmark : .none)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellCard) ??
                UITableViewCell(style: .subtitle, reuseIdentifier: Constants.cellCard)
            
            let card = viewModel.orderData?.cards[indexPath.row]
            
            cell.textLabel?.text = card?.cardName
            cell.detailTextLabel?.text = card?.cardNumber
            
            cell.accessoryType = (indexPath.row == viewModel.selectedCardIndex ? .checkmark : .none)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 16, y: 0, width: tableView.frame.size.width - 32, height: 30))
        view.backgroundColor = .gray
        
        let label = UILabel(frame: view.frame)
        label.textColor = .white
        label.text = viewModel.headerTitles[section]
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            viewModel.selectedDeliveryTimeIndex = indexPath.row
        } else {
            viewModel.selectedCardIndex = indexPath.row
        }
        if viewModel.selectedCardIndex != -1,
           viewModel.selectedDeliveryTimeIndex != -1 {
            btnOrder.isEnabled = true
        }
        
        tableView.reloadSections([indexPath.section], with: .none)
    }
}
