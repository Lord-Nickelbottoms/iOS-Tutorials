//
//  ToDoVC.swift
//  Models
//
//  Created by DA MAC M1 135 on 2023/05/24.
//

import UIKit

class ToDoVC: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var searchingArray = [String]()
	var searching = false	//used to switch between the full list of items or the searched list amount
	
	var array = [ToDo]()
//	var array = [
//		"Afrikaans",
//		"Arabic",
//		"Bengali",
//		"Bulgarian",
//		"Catalan",
//		"Cantonese",
//		"Croatian",
//		"Czech",
//		"Danish",
//		"Dutch",
//		"Lithuanian",
//		"Malay",
//		"Malayalam",
//		"Panjabi",
//		"Tamil",
//		"English",
//		"Finnish",
//		"French",
//		"German",
//		"Greek",
//		"Hebrew",
//		"Hindi",
//		"Hungarian",
//		"Indonesian",
//		"Italian",
//		"Japanese",
//		"Javanese",
//		"Korean",
//		"Norwegian",
//		"Polish",
//		"Portuguese",
//		"Romanian",
//		"Russian",
//		"Serbian",
//		"Slovak",
//		"Slovene",
//		"Spanish",
//		"Swedish",
//		"Telugu",
//		"Thai",
//		"Turkish",
//		"Ukrainian",
//		"Vietnamese",
//		"Welsh",
//		"Sign language",
//		"Algerian",
//		"Aramaic",
//		"Armenian",
//		"Berber",
//		"Burmese",
//		"Bosnian",
//		"Brazilian",
//		"Bulgarian",
//		"Cypriot",
//		"Corsica",
//		"Creole",
//		"Scottish",
//		"Egyptian",
//		"Esperanto",
//		"Estonian",
//		"Finn",
//		"Flemish",
//		"Georgian",
//		"Hawaiian",
//		"Indonesian",
//		"Inuit",
//		"Irish",
//		"Icelandic",
//		"Latin",
//		"Mandarin",
//		"Nepalese",
//		"Sanskrit",
//		"Tagalog",
//		"Tahitian",
//		"Tibetan",
//		"Gypsy",
//		"Wu"]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
				tableView.dataSource = self
				tableView.delegate = self
		
		fetchApiData(URL: "https://jsonplaceholder.typicode.com/todos"){ result in
		self.array = result
			print(result)
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	func fetchApiData(URL url: String, completion: @escaping([ToDo]) -> Void) {
		guard let url = URL(string: url)
		else{
			return
		}
		
		let session = URLSession.shared
		
		let dataTask = session.dataTask(with: url) { data, response, error in
			if data != nil, error == nil {
				do{
					let parsingData = try JSONDecoder().decode([ToDo].self, from: data!)
					completion(parsingData)
					
				}
				catch{
					print("Parsing error")
				}
			}
			
		}

		dataTask.resume()
	}
}
	
extension ToDoVC: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
		
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			
			if searching {
				return searchingArray.count
			}
			else{
				
				return array.count
			}
		}
		
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell
			else{
				return UITableViewCell()
			}
			
			if searching {
				cell.textLabel?.text = searchingArray[indexPath.row]
//				cell.textLabel?.text = searchingArray[indexPath.row]
			}
			else{
				cell.userId.text = "\(array[indexPath.row].id)"
				cell.title?.text = array[indexPath.row].title
//				cell.textLabel?.text = array[indexPath.row]
			}
			
			return cell
		}
		
		func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
			.delete
		}
		
		func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
			tableView.beginUpdates()
			array.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .bottom)
			tableView.endUpdates()
		}
		
		func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//			searchingArray = array.filter( {$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
			searching = true
			tableView.reloadData()
		}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
		
		vc?.numLabel = "\(array[indexPath.row].id)"
		vc?.lblTitle = array[indexPath.row].title
		
		self.navigationController?.pushViewController(vc!, animated: true)
	}
	
	
	}
