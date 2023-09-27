//
//  SearchListTableViewCell.swift
//  WeatherX-Project
//
//  Created by 조규연 on 9/27/23.
//

import UIKit
import MapKit
import SnapKit

class SearchListTableViewCell: UITableViewCell {
    
    private var nameLabel: UILabel = UILabel()
    
    var searchData: MKLocalSearchCompletion? {
        didSet {
            guard let city = searchData else {
                return
            }
            nameLabel.text = city.title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(data: MKLocalSearchCompletion) {
        searchData = data
    }

}
