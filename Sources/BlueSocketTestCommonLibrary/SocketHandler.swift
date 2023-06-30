//
//  SocketHandler.swift
//  BlueSocket
//
//  Created by Sung, Danny on 2021-04-10.
//  Copyright © 2021 Kitura project. All rights reserved.
//
//     Licensed under the Apache License, Version 2.0 (the "License");
//     you may not use this file except in compliance with the License.
//     You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//     Unless required by applicable law or agreed to in writing, software
//     distributed under the License is distributed on an "AS IS" BASIS,
//     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//     See the License for the specific language governing permissions and
//     limitations under the License.
//

import Foundation
import Socket

protocol SocketHandler: AnyObject {
    var error: Error? { get set }
    
    var socket: Socket { get }

    var hasActivity: Bool { get }
    
    func processInternal() throws
}

extension SocketHandler {
    func process() {
        do {
            try processInternal()
        } catch {
            print("Error: \(error.localizedDescription)")
            self.error = error
        }
    }
}

protocol BufferedSocketHandler: SocketHandler {
    var pendingOutput: Data { get set }
    
}

protocol ClientSocketHandler: SocketHandler {
    var onClose: () -> Void { get set }
}

extension BufferedSocketHandler {
    var hasPendingOutput: Bool {
        return pendingOutput.count > 0
    }
}

