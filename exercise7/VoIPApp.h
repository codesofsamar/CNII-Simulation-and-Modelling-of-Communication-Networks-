#ifndef VOIPAPP_H_
#define VOIPAPP_H_

#include <string.h>
#include <list>
#include "INETDefs.h"
#include "UDPBasicApp.h"
#include "InterfaceTableAccess.h"
#include "IPvXAddressResolver.h"
#include "NodeOperations.h"

class VoIPApp: public UDPBasicApp {

private:
    simtime_t starttime;
    simtime_t avg_delay;
    simtime_t sender_queue_delay;
    int numLostPKT;

protected:
    virtual void initialize(int stage);
    virtual void finish();

    virtual void processPacket(cPacket *pk);

};



#endif
