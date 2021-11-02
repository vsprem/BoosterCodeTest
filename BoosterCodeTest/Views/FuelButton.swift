//
//  FuelButton.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 30.10.2021..
//

import UIKit

protocol FuelButtonDelegate {
    func didTapFuelButton(sender: FuelButton)
}

class FuelButton: UIView {
    let nibName = "FuelButton"
    
    @IBOutlet weak var lblFuelName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    
    public var fuelData: FuelData?
    public var isSelected: Bool = false {
        didSet {
            if isSelected == true {
                self.backgroundColor = .green
            } else {
                self.backgroundColor = .clear
            }
        }
    }
    
    public var delegate: FuelButtonDelegate?
    
    required convenience init(fuelData: FuelData?) {
        self.init(frame: CGRect.zero)
        setData(fuelData: fuelData)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func setupview() {
        lblFuelName.text = fuelData?.fuelName ?? "-/-"
        lblPrice.text = fuelData?.price ?? "-/-"
    }
    
    public func setData(fuelData: FuelData?) {
        self.fuelData = fuelData
        setupview()
    }
    
    @IBAction func btnSelectAction() {
        delegate?.didTapFuelButton(sender: self)
    }
}
