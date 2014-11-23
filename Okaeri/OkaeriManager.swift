import MultipeerConnectivity

typealias stateChange = ((state: MCSessionState) -> ())?

class OkaeriManager: NSObject, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {
    let localPeerID = MCPeerID(displayName: NSHost.currentHost().localizedName)
    let advertiser: MCNearbyServiceAdvertiser?
    var session: MCSession?
    var onStateChange: stateChange?
    
    override init() {
        super.init()
        advertiser = MCNearbyServiceAdvertiser(peer: localPeerID, discoveryInfo: nil, serviceType: "tadaima")
        advertiser!.delegate = self
        advertiser!.startAdvertisingPeer()
        println("MC: Started advertising with \(advertiser)")
    }
}

// MARK: MCNearbyServiceAdvertiserDelegate
extension OkaeriManager {
    func advertiser(advertiser: MCNearbyServiceAdvertiser!,
                    didReceiveInvitationFromPeer peerID: MCPeerID!,
                    withContext context: NSData!,
                    invitationHandler: ((Bool, MCSession!) -> Void)!) {
        session = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .None)
        let userName : NSString! = NSString(data: context, encoding: NSUTF8StringEncoding)
        println("MC: Invitation received from \(userName) ::: \(peerID)")
        session!.delegate = self
        invitationHandler(true, session!)
    }
}

// MARK: MCSessionDelegate

extension OkaeriManager {
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        println("MC: Session \(session) changed state to \(state.rawValue)")
        if let block = onStateChange? {
            block(state: state)
        }
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        println("MC: Session \(session) received data: \(data)")
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
    }
    
}
