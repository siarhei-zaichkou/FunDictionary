
import UIKit

class MainViewController: UIViewController {

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var wordTextField: UITextField!

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let definitionTableVC = segue.destination as? DefinitionsTableViewController else { return }
        
        let word = wordTextField.text ?? ""
        
        guard let encodedWord = word.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        definitionTableVC.fetchWordDefinitions(of: encodedWord)
    }
    
    @IBAction func searchButtonPressed() {
        
    }
}
