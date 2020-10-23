//
//  DailyTableViewCell.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 23/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell, DequeueInitializable {
    
    //MARK:- Properties
    
    private var viewModel: DailyTableViewCellViewModelType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
