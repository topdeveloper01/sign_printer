import UIKit

class AlmostDoneViewController: UIViewController {
    
  
    @IBOutlet weak var tableView: UITableView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
    
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    tableView.delegate = self
    tableView.dataSource = self
  }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}


//MARK: UITableView Delegate & DataSource
extension AlmostDoneViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selphotoTableViewCell")
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 680
    }

}


