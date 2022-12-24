
import UIKit

class DefinitionsTableViewController: UITableViewController {
    
    private var definitions: Definition!

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        definitions?.list.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let definition = definitions.list[indexPath.section]
        
        switch indexPath.row {
        case 0:
            content.text = definition.definition.clearText()
        default:
            content.text = definition.example.clearText()
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        definitions?.list[section].word
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Written by \(definitions?.list[section].author ?? "") on \(definitions?.list[section].writtenOn.components(separatedBy: "T")[0] ?? "")"
        
    }
    
    // MARK: - Public Methods
    func fetchWordDefinitions(of word: String) {
        let url = Links.searchByWord + word
        NetworkManager.shared.fetch(Definition.self, from: url) { [weak self] result in
            switch result {
            case .success(let data):
                if data.list.count > 0 {
                    self?.definitions = data
                    self?.tableView.reloadData()
                } else {
                    self?.showAlert(
                        title: "Oops",
                        message: "No definitions has been finded"
                    )
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: - Extensions
extension DefinitionsTableViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
           // self.navigationController?.dismiss(animated: true)
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
}

extension String {
    func clearText() -> String {
        self.replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
    }
}
