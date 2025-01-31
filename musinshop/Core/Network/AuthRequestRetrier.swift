//
//  AuthRequestRetrier.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/5/24.
//

import Foundation
import Alamofire

public class AuthRequestRetrier : RequestInterceptor {
    private var requestsToRetry: [(RetryResult) -> Void] = []
    
    private var isRefreshing = false
    
    private var errorLock = NSLock()

    public init() {
    }
    
    public func retry(_ request: Alamofire.Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        errorLock.lock() ; defer { errorLock.unlock() }
        
        var logString = "request retrier:"
        
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        print("401 오류!!\n\(request.description))")
        
        if shouldRefreshToken(request) {
            BsLog.d("---------------------------- enqueue completion\n request: \(request) \n\n")
            requestsToRetry.append(completion)

            if !isRefreshing {
                isRefreshing = true
                    
                BsLog.d("<<<<<<<<<<<<<< start token refresh\n request: \(String(describing:request))\n\n")
                Task { [unowned self] in
                    do {
//                        let tokenResponse = try await AuthServiceImpl().refreshToken()
                        let tokenResponse = TokenResponse(tokenType: "", accessToken: "", refreshToken: "", expiresIn: 0, username: "")
                        //token refresh success.
                        BsLog.d(">>>>>>>>>>>>>> refreshToken success\ntoken: \n\(tokenResponse)\n request: \(request) \n\n")
                        
                        //proceed all pending requests.
                        self.requestsToRetry.forEach {
                            $0(.retry)
                        }
                    } catch {
                        //token refresh failure.
                        BsLog.e(" refreshToken error: \(error). retry aborted.\n request: \(request) \n\n")
                        
                        //pending requests all cancel
                        self.requestsToRetry.forEach {
                            $0(.doNotRetryWithError(error))
                        }
                    }
                    
                    self.requestsToRetry.removeAll() //reset all stored completion
                    self.isRefreshing = false
                }
            }
        }
        else {
            let bsError = NetworkError.invalidToken("refresh token not exist. retry aborted.\n\n")
            BsLog.e(" should not refresh: \(bsError)  -> pass through \n")
            completion(.doNotRetryWithError(bsError))
        }
    }
    
    private func shouldRefreshToken(_ request: Alamofire.Request) -> Bool  {
        guard MSAUTH.tokenManager.getToken()?.refreshToken != nil else {
            BsLog.e("refresh token not exist. retry aborted.\n\n")
            return false
        }

        return true
    }
}
