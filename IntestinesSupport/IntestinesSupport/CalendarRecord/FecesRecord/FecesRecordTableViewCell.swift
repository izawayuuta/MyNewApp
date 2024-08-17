//
//  FecesRecordTableViewCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/14.
//

import UIKit

class FecesRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: FecesDetailCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray  // 縦線の色
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupVerticalLine()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVerticalLine()
    }
    
    private func setupVerticalLine() {
        contentView.addSubview(verticalLine)
        verticalLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalLine.widthAnchor.constraint(equalToConstant: 1), // 縦線の幅
            verticalLine.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verticalLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16) // 左端からの距離
        ])
    }
    func configure(with record: Int) {
        // recordのデータを使用してUI要素を設定する
        //            label1.text = record
        label1.text = "\(record)"
        // 他のラベルやUI要素も必要に応じて設定
    }
}
