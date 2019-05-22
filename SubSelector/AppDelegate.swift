//
//  AppDelegate.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var subsriptionFlow: SubscriptionFlow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let navigationController = self.window?.rootViewController as? UINavigationController{
            //
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [MockURLProtocol.self]
            MockURLProtocol.requestHandler = {(request) in
                return (URLResponse(), try! Data(contentsOf: Bundle.main.url(forResource: "CountriesWithManyItem", withExtension: "json")!))
            }

            let urlSession = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)

            self.subsriptionFlow = SubscriptionFlow(rootController: navigationController, session: urlSession)
            self.subsriptionFlow?.onActivateCompleted = { () in
                print("finish")
            }
            self.subsriptionFlow?.start()
        }
        return true
    }
}

