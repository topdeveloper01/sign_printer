import UIKit

class RegisterViewController: UIViewController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

  }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func onRegister(_ sender: Any) {
        
    }
    
    @IBAction func goLogin(_ sender: Any) {
        let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        //  let navigation = UINavigationController(rootViewController: controller)
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
}
