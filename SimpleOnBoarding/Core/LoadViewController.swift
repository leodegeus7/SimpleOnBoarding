//
//  LoadViewController.swift
//  MORE-TSBR
//
//  Created by Leonardo Geus on 15/09/17.
//  Copyright © 2017 T-Systems Brasil. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {
    
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var progressBarLoad: UIProgressView!
    
    var timerLoad: Timer!
    var timesInTimer = 0
    var simpleOnBoarding:SimpleOnBoarding!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBarLoad.progressTintColor = simpleOnBoarding.progressBarLoadingColor
        progressBarLoad.progress = 0
        progressBarLoad.trackTintColor = simpleOnBoarding.progressBarBackLoadingColor
        loadingImage.backgroundColor = simpleOnBoarding.backgroundColorLoading
        loadingImage.image = simpleOnBoarding.loadingImage
    }
    
    func startOnline() {
        getOnlineWelcomeInfo(url: simpleOnBoarding.jsonURLOnline, completionHandler: { (welcomeViewsInfo) in
            DispatchQueue.main.async {
                if let _ = welcomeViewsInfo {
                    self.segueToWelcomeView(welcomeViewsInfo: welcomeViewsInfo!)
                } else {
                    print("Impossible go to Welcome View")
                }
            }
        })
    }
    
    func startOffline() {
        if simpleOnBoarding.showLoadingScreenWhenOffline {
            timerLoad = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
                let timeWithLoading = TimeInterval(self.simpleOnBoarding.timeWithLoading)
                let steps = timeWithLoading/0.1
                self.timesInTimer = self.timesInTimer + 1
                self.moveProgressBar(progressBar: self.progressBarLoad, value: Float((1.0/steps))*Float(self.timesInTimer), maxScale: 1, minScale: 0)
                if self.timesInTimer >= Int(steps) {
                    self.timerLoad.invalidate()
                    self.findOfflineFile()
                }
                
            })
        } else {
                self.findOfflineFile()
            
        }
    }
    
    func findOfflineFile() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let welcomeViewsInfo = self.getWelcomeInfo(fileURL: self.simpleOnBoarding.jsonURLOffline)
            if let _ = welcomeViewsInfo {
                self.segueToWelcomeView(welcomeViewsInfo: welcomeViewsInfo!)
            } else {
                print("Impossible go to Welcome View")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// This function is used to get the information to populate the Welcome Views. The information is from a json file localized in bundle
    ///
    /// - Returns: return an array of OnBoarding object to populate the views after load
    func getWelcomeInfo(fileURL: URL) -> [OnBoarding]? {
                if let data = getDataFromURL(url: fileURL) {
                    if let any = jsonSerialize(fileData: data) {
                        if let dic = convertAnyToDic(json: any) {
                            
                            let viewsArray = dic["views"] as! Array<Dictionary<String, String>>
                            var welcomeViews = [OnBoarding]()
                            var count = 1
                            for view in viewsArray {
                                let img = view["image"]
                                let title = view["title"]
                                let text = view["text"]
                                let logo = view["logo"]
                                let buttonText = view["button"]
                                if let _ = img, let _ = title, let _ = buttonText, let _ = text, let _ = logo {
                                    
                                    if let image = self.findImageForWelcomeView(imageName: img!) {
                                        let welcomeView: OnBoarding!
                                        let logoImage = self.findLogoImage(imageName: logo!)
                                        if count == viewsArray.count {
                                            welcomeView = OnBoarding(titleLabel: title!, logo: logoImage!, topImage: image, descriptionLabel: text!, bottomButton: buttonText!, isLast: true)
                                        } else {
                                            welcomeView = OnBoarding(titleLabel: title!, logo: logoImage!, topImage: image, descriptionLabel: text!, bottomButton: buttonText!, isLast: false)
                                        }
                                        welcomeViews.append(welcomeView)
                                    } else {
                                        print("Can't find image \(img!) in bundle, try insert images with prefix onBoarding, like onBoarding3")
                                    }
                                } else {
                                    print("Impossible mount view because the info is corrupted")
                                }
                                count = count + 1
                            }
                            return welcomeViews
                        } else {
                            print("Can't convert Any to Dic")
                        }
                    } else {
                        print("Can't serialize json in \(fileURL)")
                    }
                } else {
                    print("Can't convert URL Path to Data")
                }
        return nil
    }
    
    /// This function is used to get the information to populate the Welcome Views. The information is from a json file localized in bundle
    ///
    /// - Returns: return an array of OnBoarding object to populate the views after load
    func getOnlineWelcomeInfo(url: URL,completionHandler: @escaping ([OnBoarding]?) -> Void) {
        
        URLSession.shared.dataTask(with: NSURL(string: "http://192.168.3.6:8000/api/json")! as URL, completionHandler: { (data, response, error) -> Void in
            
            if let any = self.jsonSerialize(fileData: data!) {
                if let dic = self.convertAnyToDic(json: any) {
                    
                    let viewsArray = dic["views"] as! Array<Dictionary<String, String>>
                    var welcomeViews = [OnBoarding]()
                    var count = 1
                    for view in viewsArray {
                        let img = view["image"]
                        let title = view["title"]
                        let text = view["text"]
                        let logo = view["logo"]
                        let buttonText = view["button"]
                        if let _ = img, let _ = title, let _ = buttonText, let _ = text, let _ = logo {
                            
                            if let image = self.findImageForWelcomeView(imageName: img!) {
                                let welcomeView: OnBoarding!
                                let logoImage = self.findLogoImage(imageName: logo!)
                                if count == viewsArray.count {
                                    welcomeView = OnBoarding(titleLabel: title!, logo: logoImage!, topImage: image, descriptionLabel: text!, bottomButton: buttonText!, isLast: true)
                                } else {
                                    welcomeView = OnBoarding(titleLabel: title!, logo: logoImage!, topImage: image, descriptionLabel: text!, bottomButton: buttonText!, isLast: false)
                                }
                                welcomeViews.append(welcomeView)
                            } else {
                                print("Can't find image \(img!) in bundle, try insert images with prefix onBoarding, like onBoarding3")
                            }
                        } else {
                            print("Impossible mount view because the info is corrupted")
                        }
                        count = count + 1
                    }
                    completionHandler(welcomeViews)
                } else {
                    print("Can't convert Any to Dic")
                    completionHandler(nil)
                }
            } else {
                print("Can't serialize json")
                completionHandler(nil)
            }
        }).resume()
    }
    
    /// It's used to find file in bundle with a path URL
    ///
    /// - Parameter fileName: a string with the name of file without format
    /// - Returns: return the URL in String Format
    public func findFileURL(fileName: String) -> String? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            return path
            
        } else {
            print("Invalid filename.")
            return nil
        }
        
    }
    
    /// It's a smart function to select the possible image to populate the Welcome views, if the image passed in JSon file is invalid, the function will select a possible photo of bundle
    ///
    /// - Parameter imageName: pass in this function the imageName without extension
    /// - Returns: returns an image if succeeds
    func findImageForWelcomeView(imageName: String) -> UIImage? {
        let image = UIImage(named: imageName)
        if let _ = image {
            return image!
            
        } else {
            
            var images = [UIImage]()
            for index in 1...80 {
                let imageOnBoarding = UIImage(named: "onBoarding\(index)")
                if let _ = imageOnBoarding {
                    images.append(imageOnBoarding!)
                }
            }
            if images.count > 0 {
                print("Can't found image \(imageName). Another image will replace")
                return images.last!
            } else {
                return nil
            }
        }
    }
    
    func findLogoImage(imageName: String) -> UIImage? {
        if imageName == "nil" {
            return UIImage()
        } else {
            let image = UIImage(named: imageName)
            if let _ = image {
                return image!
            } else {
                print("Not founded logo image in bundle, please fix the name of image in your json file")
                return UIImage()
                
            }
            
        }
    }
    
    /// Segue to WelcomeViewController
    ///
    /// - Parameter welcomeViewsInfo: we need to pass an array of onBoarding to populate the views
    func segueToWelcomeView(welcomeViewsInfo: [OnBoarding]) {
        let storyboard = UIStoryboard(name: "Welcome", bundle: Bundle(for:LoadViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "WelcomePage") as! WelcomePageController
        vc.welcomeViewsInfo = welcomeViewsInfo
        vc.simpleOnBoarding = simpleOnBoarding
        present(vc, animated: true, completion: nil)
    }
    
    /// Test the existance of file in an URL String
    ///
    /// - Parameter urlString: pass the URL in string format with prefix file:///
    /// - Returns: return a bool if test succeeds
    public func existFileInURLString(urlString: String) -> Bool {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: "\(urlString)") {
            return true
        } else {
            return false
        }
    }
    
    /// Convert a string to URL
    ///
    /// - Parameter url: pass the URL in string format
    /// - Returns: return a URL in URL File format if succeeds
    public func convertStringToUrl(url: String) -> URL? {
        if let url = URL(string: "file:///\(url)") {
            return url
        } else {
            print("Invalid url.")
            
            return nil
            
        }
    }
    
    /// Function to serialize json files without options
    ///
    /// - Parameter fileData: the input parameter is a Data
    /// - Returns: return an optional 'any' object
    public func jsonSerialize(fileData: Data) -> Any? {
        do {
            let json = try JSONSerialization.jsonObject(with: fileData, options: [])
            return json
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    /// Function to converto any object to Dic if possible, frequently used to convert the response of Json Serialize function
    ///
    /// - Parameter json: the input argument is an option Any
    /// - Returns: the output is a Dictionary with string key
    public func convertAnyToDic(json: Any?) -> Dictionary<String, Any>? {
        if let dic = json as? Dictionary<String, Any> {
            return dic
        } else {
            return nil
        }
    }
    
    /// Function to get data from bundle file
    ///
    /// - Parameter url: the input argumet is an URL
    /// - Returns: the output is a optional Data Object
    public func getDataFromURL(url: URL) -> Data? {
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
    
    /// This function is used to set a proportional value in progress Bar, you can insert a new scale with min-max arguments. Or, you can just put 0-100 in this argument to use a percentage scale
    ///
    /// - Parameters:
    ///   - progressBar: the progressBar object to be set
    ///   - value: the value in your scale
    ///   - maxScale: the max value in your scale
    ///   - minScale: the min value in your scale
    func moveProgressBar(progressBar: UIProgressView, value: Float, maxScale: Float, minScale: Float) {
        let newValue = (100)/(maxScale-minScale)*(value-minScale)
        progressBar.progress = newValue/100
    }
    
}
