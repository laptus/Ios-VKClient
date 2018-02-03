//
//  AuthVC.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 10/12/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import UIKit
import WebKit

class AuthVC: UIViewController {
    @IBOutlet weak var vkWebView: WKWebView!{
        didSet{
            vkWebView.navigationDelegate = self
        }
    }
    var environment: Environment {
        return EnvironmentImp.VKEnvironment()
    }
    var token: String = ""
    lazy var router: AuthRouter = AuthRouter(environment: environment)

    override func viewDidLoad() {
        super.viewDidLoad()
        showAuthPage()
    }

    func showAuthPage(){
        do{
            let request = try router.login().asURLRequest()
            vkWebView.load(request)
        }catch{
            print(error)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toApp", let tabsVC = segue.destination as? TabsVC {
            tabsVC.token = token
        }
    }

    @IBAction func logout(segue: UIStoryboard){
        
    }
}

extension AuthVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else {

                decisionHandler(.allow)
                return
        }

        let params = parse(paramters: fragment)

        guard let token = params["access_token"] else {
            print("токен не обнаружен")
            return
        }

        self.token = token

        decisionHandler(.cancel)
        performSegue(withIdentifier: "toApp", sender: nil)
    }

    func parse(paramters: String) -> [String: String] {

        let params = paramters
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }

        return params
    }
}
