#include "UDPBasicApp.h"

#include "InterfaceTableAccess.h"
#include "IPvXAddressResolver.h"
#include "NodeOperations.h"
#include "VoIPApp.h"


Define_Module(VoIPApp);
void VoIPApp::initialize(int stage) {
    ApplicationBase::initialize(stage);

    if (stage == 0) {
        numSent = 0;
        numReceived = 0;
        starttime = 0;
        numLostPKT = 0;
        avg_delay = 0;
        sender_queue_delay = 0;
        WATCH(numSent);
        WATCH(numReceived);
        sentPkSignal = registerSignal("sentPk");
        rcvdPkSignal = registerSignal("rcvdPk");

        localPort = par("localPort");
        destPort = par("destPort");
        startTime = par("startTime").doubleValue();
        stopTime = par("stopTime").doubleValue();
        if (stopTime >= SIMTIME_ZERO && stopTime < startTime)
            error("Invalid startTime/stopTime parameters");
        selfMsg = new cMessage("sendTimer");
    }
}

void VoIPApp::finish() {
    float errorrate = 0;
    if (numSent != 0)
        errorrate = ((float) (numSent - numReceived) / numSent) * 100;
    EV << "Error rate= " << errorrate * 100 << "%, Sent= " << numSent
              << " , Received= " << numReceived << endl;
    recordScalar("packets sent", numSent);
    recordScalar("packets received", numReceived);
    recordScalar("packets error rate", errorrate);
    recordScalar("packets lost", numLostPKT);
    recordScalar("packets sender queue delay",
            sender_queue_delay / (numReceived + numLostPKT));
    recordScalar("packets avg_delays", avg_delay / (numReceived + numLostPKT));
    ApplicationBase::finish();
}

void VoIPApp::processPacket(cPacket *pk) {

    simtime_t timedelay = 0;
    simtime_t accepteddelay = 0.2; // accepted delay of 200ms
    timedelay = simTime() - (pk->getCreationTime());
    avg_delay = avg_delay + timedelay;
    sender_queue_delay = sender_queue_delay + (pk->getSendingTime())
            - (pk->getCreationTime());
    if (timedelay > accepteddelay) {
        numLostPKT++;
        EV << "Packet Lost: " << numLostPKT << endl;
    } else {
        numReceived++;
        EV << "Packet Received: " << numReceived << endl;
    }
    emit(rcvdPkSignal, pk);
    EV << "Received packet: " << UDPSocket::getReceivedPacketInfo(pk) << endl;
    delete pk;
}

