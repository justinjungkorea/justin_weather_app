//
//  ViewController.swift
//  JustinWeatherApp
//
//  Created by Dong Wook Jung on 20/06/2019.
//  Copyright © 2019 Dong Wook Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tempFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "Ko_kr")
        return formatter
    }()
    
    @IBOutlet weak var listTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.backgroundColor = UIColor.clear
        listTableView.separatorStyle = .none
        listTableView.showsVerticalScrollIndicator = false
        
        WeatherDataSource.shared.fetchSummary(lat: 37.498206, lon: 127.02761){
            [weak self] in self?.listTableView.reloadData()
        }
        
        WeatherDataSource.shared.fetchForecast(lat: 37.498206, lon: 127.02761){
            [weak self] in self?.listTableView.reloadData()
        }
    }

    var topInset: CGFloat = 0.0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if topInset == 0.0 {
            let first = IndexPath(row: 0, section: 0)
            if let cell = listTableView.cellForRow(at: first){
                topInset = listTableView.frame.height - cell.frame.height
                listTableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
            }
        }
    }

}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return WeatherDataSource.shared.forecastList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as! SummaryTableViewCell
            
            if let data = WeatherDataSource.shared.summary?.weather.minutely.first{
                cell.weatherImageView.image = UIImage(named: data.sky.code)
                cell.statusLabel.text = data.sky.name
                
                let max = Double(data.temperature.tmax) ?? 0.0
                let min = Double(data.temperature.tmin) ?? 0.0
                
                let maxStr = tempFormatter.string(for: max) ?? "-"
                let minStr = tempFormatter.string(for: min) ?? "-"
                
                cell.minMaxLabel.text = "최대 \(maxStr)℃ 최소 \(minStr)℃"
                
                let current = Double(data.temperature.tc) ?? 0.0
                let currentStr = tempFormatter.string(for: current) ?? "-"
                
                cell.currentTemperatureLabel.text = "\(currentStr)℃ "
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell
        
        let target = WeatherDataSource.shared.forecastList[indexPath.row]
        
        dateFormatter.dateFormat = "M.d (E)"
        cell.dateLabel.text = dateFormatter.string(for: target.date)
        
        dateFormatter.dateFormat = "HH:00"
        cell.timeLabel.text = dateFormatter.string(for: target.date)
        
        cell.weatherImageView.image = UIImage(named: target.skyCode)
        cell.statusLabel.text = target.skyName
        
        let tempStr = tempFormatter.string(for: target.temperature) ?? "-"
        cell.temperatureLabel.text = "\(tempStr)℃"
        
        return cell
    }
}

