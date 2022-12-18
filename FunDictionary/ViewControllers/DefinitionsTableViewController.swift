
import UIKit

class DefinitionsTableViewController: UITableViewController {
    
    var definitions: DefinitionsList?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        definitions?.list.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let definition = definitions?.list[indexPath.section]
        
        switch indexPath.row {
        case 0:
            content.text = definition?.definition.clearText()
        default:
            content.text = definition?.example.clearText()
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        definitions?.list[section].word
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Written by \(definitions?.list[section].author ?? "") on \(definitions?.list[section].written_on.components(separatedBy: "T")[0] ?? "")"
        
    }
}

// MARK: - Networking
extension DefinitionsTableViewController {
    func fetchWordDefinitions(of word: String) {
        guard let url = URL(string: Links.searchByWord + word) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error ?? "")
                return
            }
            do {
                self?.definitions = try JSONDecoder().decode(DefinitionsList.self, from: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension String {
    func clearText() -> String {
        self.replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
    }
}
