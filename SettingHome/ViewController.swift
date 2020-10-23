//
//  ViewController.swift
//  SettingsUI
//
//  Created by MAC on 12/10/20.
//

import UIKit


struct Data
{
    var sect = Int()
    var Title = [String]()
    var Img = [UIImage]()
}
var variable = [Data]()
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{
    
    var filterText = [String]()
    var filterImage = [UIImage]()
    var isSearching = false
    
    @IBOutlet weak var DataTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        variable = [Data(sect: 0,Title: ["About phone","System apps updater","Security status"], Img:[#imageLiteral(resourceName: "44"),#imageLiteral(resourceName: "07"),#imageLiteral(resourceName: "03")]),
                    Data(sect: 1, Title: ["SIM cards & mobile networks","Wi-Fi","Bluetooth","Portable hotspot","Connection & sharing"], Img: [#imageLiteral(resourceName: "777"),#imageLiteral(resourceName: "999"),#imageLiteral(resourceName: "08"),#imageLiteral(resourceName: "13"),#imageLiteral(resourceName: "34")]),
                    Data(sect: 2, Title: ["Lock screen", "Display","Sound & vibration","Notifications","Home screen","Wallpaper","Themes"], Img: [#imageLiteral(resourceName: "08"),#imageLiteral(resourceName: "31"),#imageLiteral(resourceName: "14"),#imageLiteral(resourceName: "666"),#imageLiteral(resourceName: "481"),#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "444")]),
                    Data(sect: 3, Title: ["Passwods & security", "Battery & performance","Apps","Additional settings"], Img: [#imageLiteral(resourceName: "03"),#imageLiteral(resourceName: "10"),#imageLiteral(resourceName: "26"),#imageLiteral(resourceName: "111")]),
                    Data(sect: 4, Title: ["Digital Welbeing & parental controls","Special features"], Img: [#imageLiteral(resourceName: "74"),#imageLiteral(resourceName: "30")]),
                    Data(sect: 5, Title: ["My Account","Google","Accounts & sync"], Img: [#imageLiteral(resourceName: "44"),#imageLiteral(resourceName: "29"),#imageLiteral(resourceName: "07")]),
                    Data(sect: 6, Title: ["Privacy","Location","Services & feedback"], Img: [#imageLiteral(resourceName: "21"),#imageLiteral(resourceName: "32"),#imageLiteral(resourceName: "02")])]
        
        DataTable.delegate = self
        DataTable.dataSource = self
        DataTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "DataCell")
        navigationController?.isNavigationBarHidden = false
        searchBarSetup()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching
        {
            return 1
        }
        else
        {
            return variable.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching
        {
            return filterText.count
        }
        else
        {
            return variable[section].Title.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = DataTable.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! TableViewCell
        if isSearching
        {
            cell.NameLabel.text = filterText[indexPath.row]
            cell.menuIcon.image = filterImage[indexPath.row]
        }
        else
        {
            cell.menuIcon.image = variable[indexPath.section].Img[indexPath.row]
            cell.NameLabel.text = variable[indexPath.section].Title[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        DataTable.deselectRow(at: indexPath, animated: true)
        let detail:SecondVC = self.storyboard?.instantiateViewController(identifier: "SecondVC") as! SecondVC
        if isSearching
        {
            detail.textData = filterText[indexPath.row]
            detail.image = filterImage[indexPath.row]
        }
        else
        {
            detail.textData = variable[indexPath.section].Title[indexPath.row]
            detail.image = variable[indexPath.section].Img[indexPath.row]
        }
        navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
    func searchBarSetup()
    {
        let search = UISearchBar(frame: CGRect(x: 0, y: 0, width:(UIScreen.main.bounds.size.width), height: 50))
        search.layer.cornerRadius = 20
        search.showsCancelButton=true
        search.tintColor = .gray
        search.barTintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.DataTable.tableHeaderView = search
        search.delegate = self
        search.placeholder = "Search"
        search.returnKeyType = .done
        
        let cancel = search.value(forKey: "cancelButton") as? UIButton
        cancel?.tintColor = .red
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filterText=[]
        filterImage=[]
        if searchBar.text == nil || searchBar.text == ""
        {
            isSearching = false
            view.endEditing(true)
            DataTable.reloadData()
        }
        else{
            isSearching = true
            for datavar in variable
            {
                filterText.append(contentsOf: datavar.Title.filter({return $0.contains(searchText)}))

                for i in datavar.Title.filter({return $0.contains(searchText)})
                {
                    if let imgkey = datavar.Title.firstIndex(of: i)
                    {
                        filterImage.append(datavar.Img[imgkey])
                    }
                }
            }
        }
        
        print(filterText,filterImage)
        DataTable.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filterText=[]
        filterImage=[]
        DataTable.reloadData()
    }
}
